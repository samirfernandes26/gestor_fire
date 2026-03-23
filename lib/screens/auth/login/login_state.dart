import 'package:gestor_fire/shared/model/usuario_model.dart';

enum LoginStatus { intial, loading, error, success }

class LoginState {
  LoginState({required this.status, this.message, this.usuario});

  LoginState.initial() : this(status: LoginStatus.intial, message: null);

  LoginStatus status;
  String? message;
  UsuarioModel? usuario;

  LoginState copyWith({
    LoginStatus? status,
    String? message,
    UsuarioModel? usuario,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
      usuario: usuario ?? this.usuario,
    );
  }
}
