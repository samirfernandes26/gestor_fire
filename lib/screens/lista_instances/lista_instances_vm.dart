import 'package:asyncstate/asyncstate.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/helpers/messages.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/cadastro_instance_dialog/cadastro_instance_dialog.dart';
import 'package:gestor_fire/core/ui/widgets/tiles/confirmacao/confirmacao_dialog.dart';
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
    List<InstanciaModel> instancias = await listarInstancias();

    state = state.copyWith(
      instancias: instancias,
      usuario: usuario,
      status: ListaInstancesStatus.loaded,
    );
  }

  Future<List<InstanciaModel>> listarInstancias() async {
    final instancesRef = FirebaseFirestore.instance.collection('instances');
    final querySnapshot = await instancesRef.get();
    final List<InstanciaModel> instancias = [];

    for (var doc in querySnapshot.docs) {
      Map<String, dynamic> data = doc.data();
      String docId = doc.id;

      final settingsSnapshot = await doc.reference.collection('settings').get();

      Map<String, dynamic> settingsMap = {};

      for (var subDoc in settingsSnapshot.docs) {
        settingsMap[subDoc.id] = subDoc.data();
      }

      Map<String, dynamic> instanciaMap = {
        'documentId': docId,
        ...data,
        'settings': settingsMap,
      };

      instancias.add(InstanciaModel.fromJson(instanciaMap));
    }

    return instancias;
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
                nomeDaCidade: formKey.currentState?.value['municipio'],
                uf: formKey.currentState?.value['estado'],
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

      await instancesRef.doc(instancia['cidade_id']).set(instancia);

      final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

      final usuarioLogRef = usuarioRef
          .doc(state.usuario!.userId)
          .collection('logs');

      final settingsRef = instancesRef
          .doc(instancia['cidade_id'])
          .collection('settings');

      await settingsRef.doc('feedback').set({
        'ativo': 0,
        'periodo': 0,
        'usar_local': 0,
      });

      await settingsRef.doc('gps').set({
        'precision_GPS': 0,
        'search_type_GPS': 0,
      });

      await settingsRef.doc('manutencao').set({
        'controle': 1,
        'logout_user_id_permission': [0],
        'mdm': 0,
        'senha': 0,
      });

      await settingsRef.doc('pesquisa').set({'covid': 0, 'usar_local': 0});

      await usuarioLogRef.doc(timestamp.toString()).set({
        'tipo_acao': 'Cadastrou uma nova instancia, ${instancia['text']}',
        'local': 'Lista de instancias',
        'log_id': timestamp,
      });

      if (context.mounted) {
        Messages.showSuccess(
          'Instancia de  ${instancia['text']} cadastrada com sucesso',
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

  Map<String, dynamic> gerarMapaCidade({
    required String nomeDaCidade,
    required String uf,
  }) {
    final List<String> palavras = nomeDaCidade.trim().split(RegExp(r'\s+'));
    final String cidadeFormatada = palavras
        .map((palavra) {
          if (palavra.isEmpty) return palavra;
          return palavra[0].toUpperCase() + palavra.substring(1).toLowerCase();
        })
        .join(' ');

    final String nomeSemAcentos = removeDiacritics(
      nomeDaCidade.toLowerCase().trim(),
    );

    final String cidadeId = nomeSemAcentos.split(RegExp(r'\s+')).join('_');

    final String idValue =
        'https://${nomeSemAcentos.split(RegExp(r'\s+')).join('')}.versasaude.com.br';

    return {
      'ativo': 1,
      'cidade': cidadeFormatada,
      'cidade_id': cidadeId,
      'id': idValue,
      'municipio_id': 'CODIGO',
      'text': cidadeFormatada,
      'uf': uf,
    };
  }

  Future<void> deleteInstance({
    required BuildContext context,
    required InstanciaModel instancia,
  }) async {
    try {
      bool? result = await showDialog<bool>(
        context: context,
        builder:
            (context) => ConfirmacaoDialog(
              title: 'Deletar instância',
              description: 'Deseja realmente deletar esta instância?',
              onPressedConfirmation: () {
                context.navigator.pop(true);
              },
              onPressedNegation: () {
                context.navigator.pop(false);
              },
            ),
      );

      if (result == true) {
        final timestamp = DateTime.now().millisecondsSinceEpoch;

        final instanceRef = FirebaseFirestore.instance
            .collection('instances')
            .doc(instancia.cidadeId);

        final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

        final usuarioLogRef = usuarioRef
            .doc(state.usuario!.userId)
            .collection('logs');

        final settingsSnapshot = await instanceRef.collection('settings').get();

        WriteBatch batch = FirebaseFirestore.instance.batch();

        for (final doc in settingsSnapshot.docs) {
          batch.delete(doc.reference);
        }

        await batch.commit();

        await instanceRef.delete();

        await loadData(usuario: state.usuario!).asyncLoader();

        if (context.mounted) {
          Messages.showSuccess('Instancia deletada com sucesso', context);
        }

        await usuarioLogRef.doc(timestamp.toString()).set({
          'tipo_acao': 'Deletou a instancia de ${instancia.text}',
          'local': 'Lista de instancias',
          'log_id': timestamp,
        });
      }

      if (result == false && context.mounted) {
        Messages.showSuccess('Ação abortada com sucesso', context);
      }
    } catch (e) {
      if (context.mounted) {
        Messages.showSuccess('Ouve um erro ao deletar instancia: $e', context);
      }
    }
  }
}
