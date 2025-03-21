import 'package:gestor_fire/screens/instance/instance_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'instance_vm.g.dart';

@Riverpod()
class InstanceVm extends _$InstanceVm {
  @override
  InstanceState build() => InstanceState.initial();

  Future<void> loadData() async {
    // List<InstanciaModel> instancias = await listarInstancias();

    // state = state.copyWith(instancias: instancias);
  }

  editForm() {
    bool enabled = false;

    if (state.enabledForm == false || state.enabledForm == null) {
      enabled = true;
    } else {
      enabled = false;
    }

    state = state.copyWith(enabledForm: enabled);
  }
}
