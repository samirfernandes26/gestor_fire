import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/helpers/messages.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/cadastro_instance_dialog/cadastro_instance_dialog.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_state.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'lista_instances_vm.g.dart';

@Riverpod()
class ListaInstancesVm extends _$ListaInstancesVm {
  @override
  ListaInstancesState build() => ListaInstancesState.initial();

  Future<void> loadData() async {
    List<InstanciaModel> instancias = await listarInstancias();

    state = state.copyWith(instancias: instancias);
  }

  Future<List<InstanciaModel>> listarInstancias() async {
    // 1. Referência à coleção "instances"
    final instancesRef = FirebaseFirestore.instance.collection('instances');

    // 2. Busca todos os documentos de "instances"
    final querySnapshot = await instancesRef.get();

    // 3. Cria uma lista para armazenar as instâncias

    final List<InstanciaModel> instancias = [];

    // 4. Para cada documento da coleção "instances"
    for (var doc in querySnapshot.docs) {
      // Converte os campos do documento principal em Map
      final data = doc.data();
      final docId = doc.id;

      // 5. Busca a subcoleção "settings"
      final settingsSnapshot = await doc.reference.collection('settings').get();

      // 6. Cria um Map para armazenar cada documento de "settings"
      final Map<String, dynamic> settingsMap = {};

      for (var subDoc in settingsSnapshot.docs) {
        // A chave será o ID do subdocumento (por ex.: "feedback", "gps", etc.)
        // e o valor será outro Map com os campos do subDoc
        settingsMap[subDoc.id] = subDoc.data();
      }

      // 7. Monta um mapa final para representar a instância
      final instanciaMap = {
        'documentId': docId, // ID do documento principal
        ...data, // espalha os campos do doc (cidade, ativo, etc.)
        'settings': settingsMap, // insere o Map de settings
      };

      // 8. Adiciona à lista
      instancias.add(InstanciaModel.fromJson(instanciaMap));
    }

    // 9. Retorna a lista contendo todas as instâncias com seus settings
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
  }

  Future<void> adicionarInstancia({
    required Map<String, dynamic> instancia,
    required BuildContext context,
  }) async {
    try {
      // 1. Cria o documento "caratinga" na coleção "instances" com os campos básicos.
      final instancesRef = FirebaseFirestore.instance.collection('instances');
      await instancesRef.doc(instancia['cidade_id']).set(instancia);

      // 2. Cria a subcoleção "settings" dentro do documento "caratinga".
      final settingsRef = instancesRef
          .doc(instancia['cidade_id'])
          .collection('settings');

      // Cria o documento "feedback" na subcoleção "settings".
      await settingsRef.doc('feedback').set({
        'ativo': 0,
        'periodo': 0,
        'usar_local': 0,
      });

      // Cria o documento "gps" na subcoleção "settings".
      await settingsRef.doc('gps').set({
        'precision_GPS': 0,
        'search_type_GPS': 0,
      });

      // Cria o documento "manutencao" (ou "manutençcao", conforme sua necessidade) na subcoleção "settings".
      await settingsRef.doc('manutencao').set({
        'controle': 1,
        'logout_user_id_permission': [0],
        'mdm': 0,
        'senha': '0000',
      });

      // Cria o documento "pesquisa" na subcoleção "settings".
      await settingsRef.doc('pesquisa').set({'covid': 0, 'usar_local': 0});

      if (context.mounted) {
        Messages.showErrors(
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
    // 1. Para os campos 'cidade' e 'text', cada palavra com a primeira letra maiúscula.
    final List<String> palavras = nomeDaCidade.trim().split(RegExp(r'\s+'));
    final String cidadeFormatada = palavras
        .map((palavra) {
          if (palavra.isEmpty) return palavra;
          return palavra[0].toUpperCase() + palavra.substring(1).toLowerCase();
        })
        .join(' ');

    // 2. Para 'cidade_id' e 'id': remover acentuação, deixar em minúsculo e ajustar separadores.
    // Primeiro, converte para minúsculo e remove acentos.
    final String nomeSemAcentos = removeDiacritics(
      nomeDaCidade.toLowerCase().trim(),
    );

    // Para 'cidade_id', as palavras são separadas por underscore.
    final String cidadeId = nomeSemAcentos.split(RegExp(r'\s+')).join('_');

    // Para 'id', as palavras são unidas sem separador e montamos a URL.
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
}
