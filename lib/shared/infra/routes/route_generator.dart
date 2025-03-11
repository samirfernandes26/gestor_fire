import 'package:flutter/material.dart';
import 'package:gestor_fire/screens/home/home_screen.dart';

sealed class RouteGeneratorKeys {
  static const path = '/';
  static const authLogin = '/auth/login';
  static const home = '/home';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteGeneratorKeys.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
      // case RouteGeneratorKeys.authLogin:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (context) => const AutenticacaoScreen(),
      //   );
      // case RouteGeneratorKeys.painel:
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (context) => const PainelScreen(),
      //   );

      default:
        // return _errorRoute();
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Página não encontrada'),
            centerTitle: true,
          ),
          body: const Center(child: Text('Página não encontrada')),
        );
      },
    );
  }
}
