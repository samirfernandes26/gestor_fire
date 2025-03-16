import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/dialogs/cadastro_usuario_dialog/cadastro_usuario_dialog.dart';
import 'package:gestor_fire/screens/home/home_state.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_vm.g.dart';

@Riverpod()
class HomeVm extends _$HomeVm {
  @override
  HomeState build() => HomeState.initial();

  Future<void> loadData() async {
    List<UsuarioModel> users = await listarInstancias();

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
                'cpf': formKey.currentState?.value['cpf'],
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
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    final instancesRef = FirebaseFirestore.instance.collection('usuarios');

    final settingsRef = instancesRef.doc('samir_fenandes').collection('logs');

    await instancesRef.doc('samir_fenandes').set(userMap);

    await settingsRef.doc(timestamp.toString()).set({
      'tipo_acao': 'updade',
      'local': 'instancia',
    });
  }

  Future<List<UsuarioModel>> listarInstancias() async {
    // 1. Referência à coleção "usuarios"
    final instancesRef = FirebaseFirestore.instance.collection('usuarios');

    // 2. Busca todos os documentos de "usuarios"
    final querySnapshot = await instancesRef.get();

    // 3. Cria uma lista para armazenar as usuarios
    final List<UsuarioModel> usuarios = [];

    // 4. Para cada documento da coleção "usuarios"
    for (var doc in querySnapshot.docs) {
      // Converte os campos do documento principal em Map
      final data = doc.data();
      final userId = doc.id;

      // 7. Monta um mapa final para representar a usuarios
      final instanciaMap = {'userId': userId, ...data};

      // 8. Adiciona à lista
      usuarios.add(UsuarioModel.fromJson(instanciaMap));
    }

    // 9. Retorna a lista contendo todos os usuarios
    return usuarios;
  }

  Future<void> atualizarNomeCidade(String novoNome) async {
    final docRef = FirebaseFirestore.instance
        .collection('instances')
        .doc('barra_longa');

    await docRef.update({'cidade': novoNome});
  }

  Future<void> atualizarConfiguracaoDocsSeparados() async {
    // Referência à coleção "configuracao"
    final configRef = FirebaseFirestore.instance.collection('configuracao');

    // Cria um batch para agrupar as operações
    final batch = FirebaseFirestore.instance.batch();

    // 1. Atualiza o documento "controle_de_versao"
    batch.update(configRef.doc('controle_de_versao'), {
      'migration': 2,
      'nova_versao': '3.02.00',
      'nova_versao_test': '3.02.00',
      'obrigatorio': 1,
      'obrigatorio_teste': 1,
      'versaoMigration': '3.02.00',
      'versao_termos_de_uso': '0.0.3',
      'versao_termos_de_uso_teste': '0.0.4',
    });

    // 2. Atualiza o documento "enternet_connection"
    batch.update(configRef.doc('enternet_connection'), {'ping': 2});

    // 3. Atualiza o documento "pesquisas"
    batch.update(configRef.doc('pesquisas'), {
      'permissao_covid': 1,
      'permissao_feedBack': 1,
      'permissao_feedBack_periodo': 1,
    });

    // 4. Atualiza o documento "stagging"
    batch.update(configRef.doc('stagging'), {
      'alpha': '2.0.15',
      'beta': '2.0.12',
      'production': '1.3.92',
    });

    // Executa todas as operações do batch de uma vez
    await batch.commit();
  }

  Future<void> adicionarNovidadeVersao() async {
    // Referência à coleção "novidades_da_versao"
    final novidadesRef = FirebaseFirestore.instance.collection(
      'novidades_da_versao',
    );

    // Exemplo: criar (ou sobrescrever) o documento de ID "3"
    await novidadesRef.doc('3478').set({
      'data': '15/03/2025',
      'versao': '1.3.42',
      'versao_build': 'production',
      'nov_01': 'Texto da novidade 1',
      'nov_02': 'Texto da novidade 2',
      'nov_03': 'Texto da novidade 3',
      'nov_05': 'Texto da novidade 5',
      'nov_06': 'Texto da novidade 6',
      // Se quiser mais campos, basta adicioná-los:
      // 'nov_07': 'Texto da novidade 7',
      // ...
    });
  }
}
