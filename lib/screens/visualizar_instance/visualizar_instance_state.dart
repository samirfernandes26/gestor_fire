import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';

enum VisualizarInstanceStatus { intial, initial, loaded, error, success }

class VisualizarInstanceState {
  VisualizarInstanceState({
    required this.status,
    this.message,
    this.instancia,
    this.usuario,
  });

  VisualizarInstanceState.initial()
    : this(status: VisualizarInstanceStatus.intial, message: null);

  VisualizarInstanceStatus status;
  String? message;
  InstanciaModel? instancia;
  UsuarioModel? usuario;

  VisualizarInstanceState copyWith({
    VisualizarInstanceStatus? status,
    String? message,
    InstanciaModel? instancia,
    UsuarioModel? usuario,
  }) {
    return VisualizarInstanceState(
      status: status ?? this.status,
      message: message ?? this.message,
      instancia: instancia ?? this.instancia,
      usuario: usuario ?? this.usuario,
    );
  }
}
