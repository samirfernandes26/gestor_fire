import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/screens/home/home_vm.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final HomeVm(:testeFire) = ref.read(homeVmProvider.notifier);

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        body: Visibility(
          visible: true,
          replacement: const AppLoader(color: Colors.white),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color:
                  context.brightness == Brightness.dark
                      ? Colors.transparent
                      : context.theme.colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Ola Mundo'),
                const SizedBox(height: 16),
                Button(
                  textButton: 'Teste',
                  fontWeight: FontWeight.w700,
                  colorText: Colors.white,
                  colorButton: Colors.blueAccent,
                  onPressed: () async {
                    testeFire();
                  },
                ),
                const SizedBox(height: 16),
                Button(
                  textButton: 'Teste',
                  fontWeight: FontWeight.w700,
                  colorText: Colors.white,
                  colorButton: Colors.green,
                  onPressed: () async {
                    context.navigator.pushNamed(
                      RouteGeneratorKeys.listaInstances,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
