import 'package:gestor_fire/shared/model/usuario_model.dart';

enum HomeStatus { intial, loaded, error, success }

class HomeState {
  HomeState({required this.status, this.message, this.users});

  HomeState.initial() : this(status: HomeStatus.intial, message: null);

  HomeStatus status;
  String? message;
  List<UsuarioModel>? users;

  HomeState copyWith({
    HomeStatus? status,
    String? message,
    List<UsuarioModel>? users,
  }) {
    return HomeState(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
    );
  }
}
