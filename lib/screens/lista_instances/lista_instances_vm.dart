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
      List<InstanciaModel> instancias = await listarInstancias(usuario: usuario);

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

  String _normalizarTexto(String valor) =>
      removeDiacritics(valor.toLowerCase().trim());

  bool _isAdministrador(UsuarioModel usuario) {
    final funcao = _normalizarTexto(usuario.funcao);
    return funcao == 'administrador' ||
        funcao == 'adiministrador' ||
        funcao == 'admin';
  }

  bool _isDesenvolvedor(UsuarioModel usuario) =>
      _normalizarTexto(usuario.funcao) == 'desenvolvedor';

  bool _instanciaEhHomologacaoTesteOuDesenvolvimento(
    InstanciaModel instancia,
  ) {
    final urlNormalizada = _normalizarTexto(instancia.url);
    final nomeNormalizado = _normalizarTexto(instancia.nome);

    bool contemPalavraChave(String texto) =>
        texto.contains('homologacao') ||
        texto.contains('teste') ||
        texto.contains('desenvolvimento');

    return contemPalavraChave(urlNormalizada) ||
        contemPalavraChave(nomeNormalizado);
  }

  bool _deveIncluirInstancia({
    required UsuarioModel usuario,
    required InstanciaModel instancia,
  }) {
    if (_isAdministrador(usuario)) {
      return true;
    }

    if (_isDesenvolvedor(usuario)) {
      return _instanciaEhHomologacaoTesteOuDesenvolvimento(instancia);
    }

    return true;
  }

  Future<List<InstanciaModel>> listarInstancias({
    required UsuarioModel usuario,
  }) async {
    try {
      final instancesRef = FirebaseFirestore.instance.collection('municipios');
      final querySnapshot = await instancesRef.get();
      final List<InstanciaModel> instancias = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data();
        String docId = doc.id;

        log('Instancia ID: $docId, Data: $data');

        Map<String, dynamic> instanciaMap = {'document_id': docId, ...data};
        final instancia = InstanciaModel.fromJson(instanciaMap);

        if (_deveIncluirInstancia(usuario: usuario, instancia: instancia)) {
          instancias.add(instancia);
        }
      }

      instancias.sort((a, b) {
        final nomeA = _normalizarTexto(a.nome);
        final nomeB = _normalizarTexto(b.nome);

        final comparacaoNome = nomeA.compareTo(nomeB);
        if (comparacaoNome != 0) {
          return comparacaoNome;
        }

        return a.localidadeId.compareTo(b.localidadeId);
      });

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
      if (instancia['localidade_id'] is! int) {
        throw StateError('localidade_id inválido para cadastro de instância.');
      }

      if (state.usuario == null) {
        throw StateError('Usuário não carregado para registrar log de cadastro.');
      }

      final municipiosRef = FirebaseFirestore.instance.collection('municipios');
      final municipioDocRef = await municipiosRef.add(instancia);

      // Garante confirmação no servidor para facilitar diagnóstico de falha.
      await municipioDocRef.get(const GetOptions(source: Source.server));

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
          'Instancia de ${instancia['nome']} cadastrada com sucesso (${municipioDocRef.id})',
          context,
        );
      }
    } on FirebaseException catch (erro, stackTrace) {
      log(
        'Erro Firebase ao salvar instância em municipios',
        error: erro,
        stackTrace: stackTrace,
      );

      if (context.mounted) {
        Messages.showErrors(
          'Erro Firebase [${erro.code}]: ${erro.message ?? 'sem detalhes'}',
          context,
        );
      }
    } catch (erro, stackTrace) {
      log(
        'Erro ao salvar instância em municipios',
        error: erro,
        stackTrace: stackTrace,
      );

      if (context.mounted) {
        Messages.showErrors(
          'Erro ao salvar instancia: $erro',
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
