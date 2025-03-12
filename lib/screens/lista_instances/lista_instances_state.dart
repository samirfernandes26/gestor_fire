import 'package:gestor_fire/shared/model/instancia_model.dart';

enum ListaInstancesStatus { intial, loaded, error, success }

class ListaInstancesState {
  ListaInstancesState({required this.status, this.message, this.instancias});

  ListaInstancesState.initial()
    : this(status: ListaInstancesStatus.intial, message: null);

  ListaInstancesStatus status;
  String? message;
  List<InstanciaModel>? instancias;

  ListaInstancesState copyWith({
    ListaInstancesStatus? status,
    String? message,
    List<InstanciaModel>? instancias,
  }) {
    return ListaInstancesState(
      status: status ?? this.status,
      message: message ?? this.message,
      instancias: instancias ?? this.instancias,
    );
  }
}
