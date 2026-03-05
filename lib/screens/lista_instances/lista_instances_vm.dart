import 'dart:developer';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/helper/data/localidade.dart';
import 'package:gestor_fire/core/ui/helpers/messages.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/cadastro_instance_dialog/cadastro_instance_dialog.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_state.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'lista_instances_vm.g.dart';

@Riverpod()
class ListaInstancesVm extends _$ListaInstancesVm {
  @override
  ListaInstancesState build() => ListaInstancesState.initial();

  Future<void> loadData({required UsuarioModel usuario}) async {
    try {
      List<InstanciaModel> instancias = await listarInstancias();

      state = state.copyWith(
        instancias: instancias,
        usuario: usuario,
        status: ListaInstancesStatus.loaded,
      );
    } catch (e) {
      state = state.copyWith(status: ListaInstancesStatus.error);
      rethrow;
    }
  }

  Future<List<InstanciaModel>> listarInstancias() async {
    try {
      final instancesRef = FirebaseFirestore.instance.collection('municipios');
      final querySnapshot = await instancesRef.get();
      final List<InstanciaModel> instancias = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String docId = doc.id;

        log('Instancia ID: $docId, Data: $data');

        Map<String, dynamic> instanciaMap = {'document_id': docId, ...data};

        instancias.add(InstanciaModel.fromJson(instanciaMap));
      }

      return instancias;
    } catch (e) {
      state = state.copyWith(status: ListaInstancesStatus.error);
      rethrow;
    }
  }

  Future<void> newInstance({
    required BuildContext context,
    required GlobalKey<FormBuilderState> formKey,
  }) async {
    await showDialog<bool>(
      context: context,
      builder:
          (context) => CadastroInstanceDialog(
            formKey: formKey,
            register: () async {
              Map<String, dynamic> response = gerarMapaCidade(
                localidadeId: formKey.currentState?.value['localidade_id'],
              );

              await adicionarInstancia(context: context, instancia: response);

              if (context.mounted) {
                context.navigator.pop(true);
              }
            },
          ),
    );

    await loadData(usuario: state.usuario!);
  }

  Future<void> adicionarInstancia({
    required Map<String, dynamic> instancia,
    required BuildContext context,
  }) async {
    try {
      final timestamp = DateTime.now().millisecondsSinceEpoch;

      final instancesRef = FirebaseFirestore.instance.collection('instances');
      final instanceDocRef = instancesRef.doc();
      final instanciaPayload = {...instancia};

      await instanceDocRef.set(instancia);

      final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

      final usuarioLogRef = usuarioRef
          .doc(state.usuario!.userId)
          .collection('logs');

      await usuarioLogRef.doc(timestamp.toString()).set({
        'tipo_acao': 'Cadastrou uma nova instancia, ${instancia['nome']}',
        'local': 'Lista de instancias',
        'log_id': timestamp,
      });

      if (context.mounted) {
        Messages.showSuccess(
          'Instancia de ${instancia['nome']} cadastrada com sucesso',
          context,
        );
      }
    } catch (erro) {
      if (context.mounted) {
        Messages.showErrors(
          'Error ao salvar instancia completa, verifica com o desenvolvedor oque acontece',
          context,
        );
      }
    }
  }

  Map<String, dynamic> _buscarLocalidadePorId({required int localidadeId}) {
    for (final localidade in localidadeData) {
      if (localidade['id'] == localidadeId) {
        return Map<String, dynamic>.from(localidade);
      }
    }

    throw StateError('Localidade id $localidadeId não encontrada');
  }

  Map<String, dynamic> gerarMapaCidade({required int localidadeId}) {
    final localidade = _buscarLocalidadePorId(localidadeId: localidadeId);
    final String nomeDaCidade = localidade['localidade'] as String? ?? '';

    final List<String> palavras = nomeDaCidade.trim().split(RegExp(r'\s+'));
    String cidadeFormatada = palavras
        .map((palavra) {
          if (palavra.isEmpty) return palavra;
          return palavra[0].toUpperCase() + palavra.substring(1).toLowerCase();
        })
        .join(' ');

    // TODO adicionanar correção do estado aqui
    cidadeFormatada = '$cidadeFormatada - MG';

    final String nomeSemAcentos = removeDiacritics(
      nomeDaCidade.toLowerCase().trim(),
    );

    final String idValue =
        'https://${nomeSemAcentos.split(RegExp(r'\s+')).join('')}.versasaude.com.br';

    return {
      'ativo': false,
      'ace': false,
      'acs': false,
      'motorista': false,
      'nome': cidadeFormatada,
      'url': idValue,
      'localidade_id': localidadeId,
    };
  }
}
