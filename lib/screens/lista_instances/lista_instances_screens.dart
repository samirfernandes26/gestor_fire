import 'package:asyncstate/asyncstate.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/cards/instancia/instancia_card.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_state.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_vm.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';

class ListaInstancesScreen extends ConsumerStatefulWidget {
  const ListaInstancesScreen({super.key});

  @override
  ConsumerState<ListaInstancesScreen> createState() =>
      _ListaInstancesScreenState();
}

class _ListaInstancesScreenState extends ConsumerState<ListaInstancesScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final ListaInstancesVm(:loadData, :newInstance) = ref.read(
      listaInstancesVmProvider.notifier,
    );

    final ListaInstancesState(:instancias, :usuario, :status) = ref.watch(
      listaInstancesVmProvider,
    );

    final instanciasOrdenadas = [...?instancias]..sort((a, b) {
      final nomeA = removeDiacritics(a.nome.toLowerCase().trim());
      final nomeB = removeDiacritics(b.nome.toLowerCase().trim());
      return nomeA.compareTo(nomeB);
    });

    final UsuarioModel? usuarioAtual =
        usuario ?? arguments?['usuario'] as UsuarioModel?;

    final bool usuarioEhAdministrador =
        removeDiacritics((usuarioAtual?.funcao ?? '').toLowerCase().trim()) ==
            'administrador' ||
        removeDiacritics((usuarioAtual?.funcao ?? '').toLowerCase().trim()) ==
            'adiministrador' ||
        removeDiacritics((usuarioAtual?.funcao ?? '').toLowerCase().trim()) ==
            'admin';

    if (status == ListaInstancesStatus.intial && arguments?['reload'] == true) {
      arguments!['reload'] = false;
      Future(() async {
        await loadData(usuario: arguments['usuario']).asyncLoader();
      });
    }

    return PopScope(
      canPop: instancias != null,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Instancias'),
          automaticallyImplyLeading: false,
        ),
        floatingActionButton:
            usuarioEhAdministrador
                ? FloatingActionButton(
                  backgroundColor: Colors.blueAccent,
                  onPressed: () async {
                    await newInstance(context: context, formKey: formKey);
                  },
                  child: const Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                    size: 32,
                  ),
                )
                : null,
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
                Expanded(
                  child: ListView.builder(
                    itemCount: instanciasOrdenadas.length,
                    itemBuilder:
                        (context, index) => Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: InstanciaCard(
                            enableSlide: true,
                            instancia: instanciasOrdenadas[index],
                            usuario: usuario!,
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
