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

    // await adicionarCaratinga();

    // await atualizarConfiguracaoDocsSeparados();

    // await adicionarNovidadeVersao();

    await listarInstancias();

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

  Future<void> adicionarCaratinga() async {
    // 1. Cria o documento "caratinga" na coleção "instances" com os campos básicos.
    final instancesRef = FirebaseFirestore.instance.collection('instances');
    await instancesRef.doc('caratinga').set({
      'ativo': 1,
      'cidade': 'Caratinga',
      'cidade_id': 'caratinga',
      'id': 'https://caratinga.versasaude.com.br',
      'municipio_id': 'CODIGO', // substitua pelo código real, se disponível
      'text': 'Caratinga',
      'uf': 'MG',
    });

    // 2. Cria a subcoleção "settings" dentro do documento "caratinga".
    final settingsRef = instancesRef.doc('caratinga').collection('settings');

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

  Future<List<Map<String, dynamic>>> listarInstancias() async {
    // 1. Referência à coleção "instances"
    final instancesRef = FirebaseFirestore.instance.collection('instances');

    // 2. Busca todos os documentos de "instances"
    final querySnapshot = await instancesRef.get();

    // 3. Cria uma lista para armazenar as instâncias
    final List<Map<String, dynamic>> listaInstancias = [];

    final List<String> municipios = [];

    // 4. Para cada documento da coleção "instances"
    for (var doc in querySnapshot.docs) {
      // Converte os campos do documento principal em Map
      final data = doc.data();
      final docId = doc.id;

      // Pegando o nome do municio e salvando para ver na lista
      municipios.add(data['text']);

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
      listaInstancias.add(instanciaMap);
    }

    // 9. Retorna a lista contendo todas as instâncias com seus settings
    return listaInstancias;
  }
}
