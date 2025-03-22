import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';

enum ListaInstancesStatus { intial, loaded, error, success }

class ListaInstancesState {
  ListaInstancesState({
    required this.status,
    this.message,
    this.instancias,
    this.usuario,
  });

  ListaInstancesState.initial()
    : this(status: ListaInstancesStatus.intial, message: null);

  ListaInstancesStatus status;
  String? message;
  List<InstanciaModel>? instancias;
  UsuarioModel? usuario;

  ListaInstancesState copyWith({
    ListaInstancesStatus? status,
    String? message,
    List<InstanciaModel>? instancias,
    UsuarioModel? usuario,
  }) {
    return ListaInstancesState(
      status: status ?? this.status,
      message: message ?? this.message,
      instancias: instancias ?? this.instancias,
      usuario: usuario ?? this.usuario,
    );
  }
}
