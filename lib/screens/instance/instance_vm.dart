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
          '${state.enabledForm! ? 'Habilitou' : 'Desabilitou'} edição de instância de ${state.instancia!.nome}',
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

    InstanciaModel instances = state.instancia!;

    Map<String, dynamic> instanciaMap = montarObjeto(
      instanciaForm: form,
      instance: instances,
    );

    final instancesRef = FirebaseFirestore.instance.collection('municipios');

    await instancesRef
        .doc(instances.documentoId)
        .update(instanciaMap['municipios']);

    await usuarioLogRef.doc(timestamp.toString()).set({
      'tipo_acao':
          'Editou a instância de ${state.instancia!.nome} - ${state.instancia!.url}',
      'local': 'Atualização da instancia',
      'log_id': timestamp,
    });

    instances.ativo = instanciaMap['municipios']['ativo'] as bool;
    instances.ace = instanciaMap['municipios']['ace'] as bool;
    instances.acs = instanciaMap['municipios']['acs'] as bool;
    instances.motorista = instanciaMap['municipios']['motorista'] as bool;

    if (context.mounted) {
      context.navigator.pop({
        'reload': true,
        'instancia': instances,
        'usuario': state.usuario,
      });
    }
  }

  Map<String, dynamic> montarObjeto({
    required Map<String, dynamic> instanciaForm,
    required InstanciaModel instance,
  }) => {
    'municipios': {
      'ativo': instanciaForm['ativo'],
      'ace': instanciaForm['ace'],
      'acs': instanciaForm['acs'],
      'motorista': instanciaForm['motorista'],
      'nome': instance.nome,
      'url': instance.url,
      'localidade_id': instance.localidadeId,
    },
  };
}
