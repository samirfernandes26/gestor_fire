import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/helpers/messages.dart';
import 'package:gestor_fire/screens/auth/login/login_state.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@Riverpod()
class LoginVm extends _$LoginVm {
  @override
  LoginState build() => LoginState.initial();

  String _onlyNumbers(String value) => value.replaceAll(RegExp(r'\D'), '');

  Future<void> login({
    required String cpf,
    required String senha,
    required BuildContext context,
  }) async {
    state = state.copyWith(status: LoginStatus.loading, message: null);

    try {
      final cpfDigits = _onlyNumbers(cpf);
      final senhaDigits = _onlyNumbers(senha);

      if (cpfDigits.isEmpty || senhaDigits.isEmpty) {
        _showError(
          context: context,
          message: 'Informe CPF e senha para continuar.',
        );
        return;
      }

      final cpfNumber = int.parse(cpfDigits);

      final userQuery =
          await FirebaseFirestore.instance
              .collection('usuarios')
              .where('cpf', isEqualTo: cpfNumber)
              .limit(1)
              .get();

      if (!context.mounted) return;

      if (userQuery.docs.isEmpty) {
        _showError(
          context: context,
          message: 'Usuário não encontrado para o CPF informado.',
        );
        return;
      }

      final doc = userQuery.docs.first;
      final data = doc.data();

      final bool usuarioAtivo = (data['ativo'] as int? ?? 0) == 1;

      if (!usuarioAtivo) {
        _showError(
          context: context,
          message: 'Usuário inativo. Procure o administrador.',
        );
        return;
      }

      // Mantém compatibilidade com a base atual: se não existir "senha",
      // usa o CPF cadastrado como senha padrão.
      final senhaRegistrada = _onlyNumbers(
        (data['senha']?.toString() ?? data['cpf']?.toString() ?? ''),
      );

      if (senhaDigits != senhaRegistrada) {
        _showError(context: context, message: 'Senha inválida, tente novamente.');
        return;
      }

      final usuario = UsuarioModel.fromJson({'userId': doc.id, ...data});

      state = state.copyWith(
        status: LoginStatus.success,
        usuario: usuario,
        message: null,
      );

      if (!context.mounted) return;

      await context.navigator.pushReplacementNamed(
        RouteGeneratorKeys.listaInstances,
        arguments: {'reload': true, 'usuario': usuario},
      );
    } catch (_) {
      if (!context.mounted) return;

      _showError(
        context: context,
        message: 'Não foi possível autenticar agora. Tente novamente.',
      );
    }
  }

  void _showError({required BuildContext context, required String message}) {
    state = state.copyWith(status: LoginStatus.error, message: message);

    if (!context.mounted) return;
    Messages.showErrors(message, context);
  }
}
