import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_state.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_vm.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';

class ListaInstancesScreen extends ConsumerStatefulWidget {
  const ListaInstancesScreen({super.key});

  @override
  ConsumerState<ListaInstancesScreen> createState() =>
      _ListaInstancesScreenState();
}

class _ListaInstancesScreenState extends ConsumerState<ListaInstancesScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final ListaInstancesVm(:loadData) = ref.read(
      listaInstancesVmProvider.notifier,
    );

    final ListaInstancesState(:instancias) = ref.watch(
      listaInstancesVmProvider,
    );

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
                Button(
                  textButton: 'LoadData',
                  fontWeight: FontWeight.w700,
                  colorText: Colors.white,
                  colorButton: Colors.redAccent,
                  onPressed: () async {
                    loadData();
                  },
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: instancias?.length ?? 0,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Button(
                            textButton:
                                instancias?[index].text ?? 'Não informado',
                            fontWeight: FontWeight.w700,
                            colorText: Colors.white,
                            colorButton: Colors.grey,
                            onPressed: () async {
                              context.navigator.pushNamed(
                                RouteGeneratorKeys.visualizarInstance,
                                arguments: {
                                  'instancia': instancias?[index],
                                  'reload': true,
                                },
                              );
                            },
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
