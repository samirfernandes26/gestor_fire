import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/screens/lista_instances/lista_instances_vm.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';
import 'package:gestor_fire/shared/model/instancia_model.dart';
import 'package:gestor_fire/shared/model/usuario_model.dart';

class InstanciaCard extends ConsumerWidget {
  const InstanciaCard({
    super.key,
    required this.instancia,
    required this.usuario,
    required this.enableSlide,
  });

  final InstanciaModel instancia;
  final UsuarioModel usuario;
  final bool enableSlide;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ListaInstancesVm(:deleteInstance) = ref.read(
      listaInstancesVmProvider.notifier,
    );

    return Slidable(
      enabled: enableSlide,
      closeOnScroll: true,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              deleteInstance(context: context, cidadeId: instancia.cidadeId);
            },
            backgroundColor: Colors.blue.shade100,
            foregroundColor: Colors.redAccent.shade700,
            borderRadius: const BorderRadius.all(Radius.circular(16.0)),
            label: 'Deletar',
            icon: Icons.delete,
          ),
        ],
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: InkWell(
          onTap: () {
            context.navigator.pushNamed(
              RouteGeneratorKeys.visualizarInstance,
              arguments: {
                'instancia': instancia,
                'usuario': usuario,
                'reload': true,
              },
            );
          },
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              '${instancia.text.toUpperCase()} - ${instancia.uf.toUpperCase()}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: context.theme.textTheme.titleLarge
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color:
                                        context.brightness == Brightness.light
                                            ? Colors.blueAccent
                                            : Colors.white,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            instancia.id,
                            overflow: TextOverflow.ellipsis,
                            style: context.theme.textTheme.titleSmall?.copyWith(
                              color:
                                  context.brightness == Brightness.light
                                      ? Colors.blueGrey
                                      : Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
