enum ListaInstancesStatus { intial, loaded, error, success }

class ListaInstancesState {
  ListaInstancesStatus status;

  String? message;

  ListaInstancesState.initial()
    : this(status: ListaInstancesStatus.intial, message: null);

  ListaInstancesState({required this.status, this.message});

  ListaInstancesState copyWith({
    ListaInstancesStatus? status,
    String? message,
  }) {
    return ListaInstancesState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
