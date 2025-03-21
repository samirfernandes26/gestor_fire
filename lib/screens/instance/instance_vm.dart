import 'package:gestor_fire/screens/instance/instance_state.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'instance_vm.g.dart';

@Riverpod()
class InstanceVm extends _$InstanceVm {
  @override
  InstanceState build() => InstanceState.initial();

  Future<void> loadData(InstanciaModel instancia) async {
    state = state.copyWith(instancia: instancia, status: InstanceStatus.loaded);
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
