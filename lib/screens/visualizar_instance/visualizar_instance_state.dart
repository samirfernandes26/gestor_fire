import 'package:gestor_fire/shared/model/instancia_model.dart';

enum VisualizarInstanceStatus { intial, initial, loaded, error, success }

class VisualizarInstanceState {
  VisualizarInstanceState({required this.status, this.message, this.instancia});

  VisualizarInstanceState.initial()
    : this(status: VisualizarInstanceStatus.intial, message: null);

  VisualizarInstanceStatus status;
  String? message;
  InstanciaModel? instancia;

  VisualizarInstanceState copyWith({
    VisualizarInstanceStatus? status,
    String? message,
    InstanciaModel? instancia,
  }) {
    return VisualizarInstanceState(
      status: status ?? this.status,
      message: message ?? this.message,
      instancia: instancia ?? this.instancia,
    );
  }
}
