import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/screens/instance/instance_state.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'instance_vm.g.dart';

@Riverpod()
class InstanceVm extends _$InstanceVm {
  @override
  InstanceState build() => InstanceState.initial();

  Future<void> loadData(InstanciaModel instancia, UsuarioModel user) async {
    state = state.copyWith(
      instancia: instancia,
      usuario: user,
      status: InstanceStatus.loaded,
    );
  }

  Future<void> editForm() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

    final usuarioLogRef = usuarioRef
        .doc(state.usuario!.userId)
        .collection('logs');

    bool enabled = false;

    if (state.enabledForm == false || state.enabledForm == null) {
      enabled = true;
    } else {
      enabled = false;
    }

    state = state.copyWith(enabledForm: enabled);

    await usuarioLogRef.doc(timestamp.toString()).set({
      'tipo_acao':
          '${state.enabledForm! ? 'Habilitou' : 'Desabilitou'} edição de instância de ${state.instancia!.text}',
      'local': 'Atualização da instancia',
      'log_id': timestamp,
    });
  }

  Future<void> salvar(form, BuildContext context) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final usuarioRef = FirebaseFirestore.instance.collection('usuarios');

    final usuarioLogRef = usuarioRef
        .doc(state.usuario!.userId)
        .collection('logs');

    Map<String, dynamic> instanciaMap = montarObjeto(instanciaForm: form);

    final instancesRef = FirebaseFirestore.instance.collection('instances');

    await instancesRef
        .doc(instanciaMap['instancia']['cidade_id'])
        .update(instanciaMap['instancia']);

    final settingsRef = instancesRef
        .doc(instanciaMap['instancia']['cidade_id'])
        .collection('settings');

    await settingsRef
        .doc('feedback')
        .update(instanciaMap['settings']['feedback']);

    await settingsRef.doc('gps').update(instanciaMap['settings']['gps']);

    await settingsRef
        .doc('manutencao')
        .update(instanciaMap['settings']['manutencao']);

    await settingsRef
        .doc('pesquisa')
        .update(instanciaMap['settings']['pesquisa']);

    await usuarioLogRef.doc(timestamp.toString()).set({
      'tipo_acao': 'Atualizou a instancia ${instanciaMap['instancia']['text']}',
      'local': 'Atualização da instancia',
      'log_id': timestamp,
    });

    if (context.mounted) {
      context.navigator.pushNamedAndRemoveUntil(
        RouteGeneratorKeys.listaInstances,
        arguments: {'reload': true},
        (route) => false,
      );
    }
  }

  Map<String, dynamic> montarObjeto({
    required Map<String, dynamic> instanciaForm,
  }) => {
    'instancia': {
      'ativo': instanciaForm['ativo'] ? 1 : 0,
      'cidade': instanciaForm['cidade'],
      'cidade_id': instanciaForm['cidade_id'],
      'id': instanciaForm['id'],
      'municipio_id': instanciaForm['municipio_id'],
      'text': instanciaForm['text'],
      'uf': instanciaForm['uf'],
    },
    'settings': {
      'feedback': {
        'ativo': instanciaForm['feedback_ativo'] ? 1 : 0,
        'periodo': int.parse(instanciaForm['feedback_periodo']),
        'usar_local': instanciaForm['feedback_usar_local'] ? 1 : 0,
      },
      'gps': {
        'precision_GPS': instanciaForm['precision_GPS'] ? 1 : 0,
        'search_type_GPS': instanciaForm['search_type_GPS'] ? 1 : 0,
      },
      'manutencao': {'senha': int.parse(instanciaForm['senha'])},
      'pesquisa': {
        'covid': instanciaForm['covid'] ? 1 : 0,
        'usar_local': instanciaForm['pesquisa_usar_local'] ? 1 : 0,
      },
    },
  };
}
