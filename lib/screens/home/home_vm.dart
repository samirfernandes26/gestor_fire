import 'package:gestor_fire/screens/home/home_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'home_vm.g.dart';

@Riverpod()
class HomeVm extends _$HomeVm {
  @override
  HomeState build() => HomeState.initial();

  Future<void> testeFire() async {
    // final municipiosSnapshot =
    //     await FirebaseFirestore.instance.collection('instances').get();

    // final docRef = FirebaseFirestore.instance
    //     .collection('instances')
    //     .doc('barra_longa');

    // var docSnapshot = await docRef.get();

    // if (docSnapshot.exists) {
    //   final data = docSnapshot.data() as Map<String, dynamic>;
    // }

    // await atualizarNomeCidade('Barra Longa Batata');

    // docSnapshot = await docRef.get();

    // if (docSnapshot.exists) {
    //   final data = docSnapshot.data() as Map<String, dynamic>;
    // }

    // await atualizarConfiguracaoDocsSeparados();

    // await adicionarNovidadeVersao();

    // for (var doc in municipiosSnapshot.docs) {
    //   print(doc.data());
    // }
  }

  Future<void> atualizarNomeCidade(String novoNome) async {
    final docRef = FirebaseFirestore.instance
        .collection('instances')
        .doc('barra_longa');

    await docRef.update({'cidade': novoNome});
  }

  Future<void> addUsuarios() async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;

    // 1. Cria o documento "caratinga" na coleção "instances" com os campos básicos.
    final instancesRef = FirebaseFirestore.instance.collection('usuarios');
    final settingsRef = instancesRef.doc('samir_fenandes').collection('logs');

    await settingsRef.doc(timestamp.toString()).set({
      'tipo_acao': 'updade',
      'local': 'instancia',
    });

    await instancesRef.doc('samir_fenandes').set({
      'ativo': 1,
      'nome': 'Samir Fernandes',
      'Sexo': 'masuclino',
      'funcao': 'Desenvolvedor',
      'cpf': 11931783632,
    });
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
