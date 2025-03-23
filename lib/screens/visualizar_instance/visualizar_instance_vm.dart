import 'package:gestor_fire/screens/visualizar_instance/visualizar_instance_state.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'visualizar_instance_vm.g.dart';

@Riverpod()
class VisualizarInstanceVm extends _$VisualizarInstanceVm {
  @override
  VisualizarInstanceState build() => VisualizarInstanceState.initial();

  Future<void> loadData(InstanciaModel instancia, UsuarioModel user) async {
    state = state.copyWith(
      instancia: instancia,
      usuario: user,
      status: VisualizarInstanceStatus.loaded,
    );
  }
}
