import 'package:gestor_fire/shared/model/instancia_model.dart';

enum InstanceStatus { intial, loaded, error, success }

class InstanceState {
  InstanceState({
    required this.status,
    this.message,
    this.instancia,
    this.enabledForm = false,
  });

  InstanceState.initial()
    : this(status: InstanceStatus.intial, message: null, enabledForm: true);

  InstanceStatus status;
  String? message;
  InstanciaModel? instancia;
  bool? enabledForm;

  InstanceState copyWith({
    InstanceStatus? status,
    String? message,
    InstanciaModel? instancia,
    bool? enabledForm,
  }) {
    return InstanceState(
      status: status ?? this.status,
      message: message ?? this.message,
      instancia: instancia ?? this.instancia,
      enabledForm: enabledForm ?? this.enabledForm,
    );
  }
}
