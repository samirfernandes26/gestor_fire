import 'package:flutter/material.dart';

/// Classe que fornece uma chave global para o navegador do aplicativo.
class AppNavGlobalKey {
  static AppNavGlobalKey? _instance;

  /// Chave global para o navegador do aplicativo.
  final navKey = GlobalKey<NavigatorState>();

  /// Construtor privado para garantir que a classe seja um singleton.
  AppNavGlobalKey._();

  /// Obtém a instância única da classe AppNavGlobalKey.
  static AppNavGlobalKey get instance => _instance ??= AppNavGlobalKey._();
}
