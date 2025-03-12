import 'package:flutter/material.dart';
import 'package:gestor_fire/screens/home/home_screen.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_screens.dart';
import 'package:gestor_fire/screens/visualizar_instance/visualizar_instance_screen.dart';

sealed class RouteGeneratorKeys {
  static const path = '/';
  static const authLogin = '/auth/login';
  static const home = '/home';
  static const listaInstances = '/listaInstances';
  static const visualizarInstance = '/visualizarInstance';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteGeneratorKeys.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const HomeScreen(),
        );
      case RouteGeneratorKeys.listaInstances:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const ListaInstancesScreen(),
        );
      case RouteGeneratorKeys.visualizarInstance:
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => const VisualizarInstanceScreen(),
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
