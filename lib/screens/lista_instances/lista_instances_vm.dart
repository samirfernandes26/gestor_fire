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
}
