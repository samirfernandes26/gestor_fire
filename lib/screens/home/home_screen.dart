import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/core/ui/widgets/tiles/user_tile/user_tile.dart';
import 'package:gestor_fire/screens/home/home_state.dart';
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
    final formKey = GlobalKey<FormBuilderState>();

    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final HomeVm(:loadData, :addUsuarios) = ref.read(homeVmProvider.notifier);

    final HomeState(:users, :status) = ref.watch(homeVmProvider);

    if (status == HomeStatus.intial || arguments?['reload'] == true) {
      Future(() async {
        arguments?['reload'] = false;
        await loadData();
      });
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Home')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            await addUsuarios(context: context, formKey: formKey);
          },
          child: const Icon(
            Icons.person_add_outlined,
            color: Colors.white,
            size: 32,
          ),
        ),
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
                const SizedBox(height: 16),

                Expanded(
                  child: ListView.builder(
                    itemCount: users?.length ?? 0,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: TileUser(
                            onTap:
                                () => context.navigator.pushNamed(
                                  RouteGeneratorKeys.listaInstances,
                                  arguments: {
                                    'reload': true,
                                    'usuario': users![index],
                                  },
                                ),
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
