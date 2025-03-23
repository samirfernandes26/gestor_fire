import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/helpers/messages.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/cadastro_usuario_dialog/cadastro_usuario_dialog.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/solicita_senha_usuario_dialog/solicita_senha_usuario_dialog.dart';
import 'package:gestor_fire/screens/home/home_state.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_vm.g.dart';

@Riverpod()
class HomeVm extends _$HomeVm {
  @override
  HomeState build() => HomeState.initial();

  Future<void> loadData() async {
    List<UsuarioModel> users = await listarUsuarios();

    state = state.copyWith(users: users, status: HomeStatus.loaded);
  }

  Future<void> addUsuarios({
    required BuildContext context,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    await showDialog<bool>(
      context: context,
      builder:
          (context) => CadastroUsuarioDialog(
            formKey: formKey,
            register: () async {
              Map<String, dynamic> response = {
                'ativo': 1,
                'nome': formKey.currentState?.value['nome'],
                'sexo': formKey.currentState?.value['sexo'],
                'cpf': int.parse(formKey.currentState?.value['cpf']),
                'funcao': formKey.currentState?.value['funcao'],
              };

              await newUser(userMap: response);

              if (context.mounted) {
                context.navigator.pop(true);
              }
            },
          ),
    );
    await loadData();
  }

  Future<void> newUser({required Map<String, dynamic> userMap}) async {
    // final timestamp = DateTime.now().millisecondsSinceEpoch;

    final nomeId = (removeDiacritics(
      userMap['nome'].toLowerCase().trim(),
    )).split(RegExp(r'\s+')).join('_');

    final instancesRef = FirebaseFirestore.instance.collection('usuarios');

    final settingsRef = instancesRef.doc(nomeId).collection('logs');

    await instancesRef.doc(nomeId).set(userMap);

    // await settingsRef.doc(timestamp.toString()).set({
    //   'tipo_acao': 'updade',
    //   'local': 'instancia',
    //   'logs_id':
    // });
  }

  Future<List<UsuarioModel>> listarUsuarios() async {
    final instancesRef = FirebaseFirestore.instance.collection('usuarios');

    final querySnapshot = await instancesRef.get();

    final List<UsuarioModel> usuarios = [];

    for (var doc in querySnapshot.docs) {
      final data = doc.data();
      final userId = doc.id;
      final instanciaMap = {'userId': userId, ...data};
      usuarios.add(UsuarioModel.fromJson(instanciaMap));
    }

    return usuarios;
  }

  Future<void> liberarUsuario({
    required UsuarioModel user,
    required BuildContext context,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    try {
      var senha = 0000000;

      await showDialog<bool>(
        context: context,
        builder:
            (context) => SolicitaSenhaUsuarioDialog(
              formKey: formKey,
              register: () async {
                senha = int.parse(formKey.currentState?.value['senha']);

                if (context.mounted) {
                  context.navigator.pop(true);
                }
              },
            ),
      );

      if (user.cpf == senha && context.mounted) {
        context.navigator.pushNamed(
          RouteGeneratorKeys.listaInstances,
          arguments: {'reload': true, 'usuario': user},
        );
      } else {
        if (context.mounted) {
          Messages.showErrors(
            'A senha informada está incorreta, tente novamente!',
            context,
          );
        }
      }
    } catch (e) {
      if (context.mounted) {
        Messages.showErrors(
          'A senha informada está incorreta, tente novamente!',
          context,
        );
      }
    }
  }
}
