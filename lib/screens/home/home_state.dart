enum HomeStatus { intial, loaded, error, success }

class HomeState {
  HomeStatus status;

  String? message;

  HomeState.initial() : this(status: HomeStatus.intial, message: null);

  HomeState({required this.status, this.message});

  HomeState copyWith({HomeStatus? status, String? message}) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
