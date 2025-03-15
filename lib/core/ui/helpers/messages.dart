import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';

/// Classe utilitária para exibição de mensagens usando o pacote top_snackbar_flutter.
class Messages {
  /// Exibe uma mensagem de erro.
  ///
  /// - Parâmetros:
  ///   - `message`: Mensagem a ser exibida.
  ///   - `context`: Contexto de construção do widget.
  static void showErrors(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.error(message: message),
    );
  }

  /// Exibe uma mensagem de informação.
  ///
  /// - Parâmetros:
  ///   - `message`: Mensagem a ser exibida.
  ///   - `context`: Contexto de construção do widget.
  static void showInfo(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.info(message: message),
    );
  }

  /// Exibe uma mensagem de sucesso.
  ///
  /// - Parâmetros:
  ///   - `message`: Mensagem a ser exibida.
  ///   - `context`: Contexto de construção do widget.
  static void showSuccess(String message, BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      CustomSnackBar.success(message: message),
    );
  }
}
