import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/screens/visualizar_instance/visualizar_instance_state.dart';
import 'package:gestor_fire/screens/visualizar_instance/visualizar_instance_vm.dart';
import 'package:gestor_fire/shared/infra/routes/route_generator.dart';

class VisualizarInstanceScreen extends ConsumerStatefulWidget {
  const VisualizarInstanceScreen({super.key});

  @override
  ConsumerState<VisualizarInstanceScreen> createState() =>
      _VisualizarInstanceScreenState();
}

class _VisualizarInstanceScreenState
    extends ConsumerState<VisualizarInstanceScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final VisualizarInstanceVm(:loadData) = ref.read(
      visualizarInstanceVmProvider.notifier,
    );

    final VisualizarInstanceState(:instancia, :status, :usuario) = ref.watch(
      visualizarInstanceVmProvider,
    );

    if (status == VisualizarInstanceStatus.initial ||
        arguments?['reload'] == true) {
      Future(() async {
        arguments!['reload'] = false;
        await loadData(arguments['instancia'], arguments['usuario']);
      });
    }

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(title: const Text('Vizuallizar Instancia')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            final result = await context.navigator.pushNamed(
              RouteGeneratorKeys.instanceScreen,
              arguments: {
                'instancia': instancia,
                'reload': true,
                'usuario': usuario,
              },
            );

            if (result is Map<String, dynamic> &&
                result['instancia'] != null &&
                result['usuario'] != null &&
                context.mounted) {
              await loadData(result['instancia'], result['usuario']);
            }
          },
          child: const Icon(Icons.edit_outlined, color: Colors.white, size: 32),
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
            child: Scrollbar(
              thickness: 5,
              child: ListView(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      instancia?.nome.toUpperCase() ?? 'Nova Instância',
                      textAlign: TextAlign.center,
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.badge,
                    label: 'Nome Instacia Exibido',
                    description: instancia?.nome.toUpperCase(),
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.person,
                    label: 'Localidade ID',
                    description: instancia?.localidadeId.toString(),
                    color: Colors.blue,
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.phone,
                    label: 'Instancia Ativa',
                    description: instancia?.ativo == true ? 'Sim' : 'Não',
                    color: Colors.blue,
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.health_and_safety,
                    label: 'Versa Saude ACS',
                    description:
                        instancia?.acs == true
                            ? 'Em Funcionamento'
                            : 'Desativado',
                    color: Colors.blue,
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.pest_control,
                    label: 'Versa Saude ACE',
                    description:
                        instancia?.ace == true
                            ? 'Em Funcionamento'
                            : 'Desativado',
                    color: Colors.blue,
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.directions_car,
                    label: 'Versa Saude Motorista',
                    description:
                        instancia?.motorista == true
                            ? 'Em Funcionamento'
                            : 'Desativado',
                    color: Colors.blue,
                  ),

                  SizedBox(height: 16),
                  _rowInfo(
                    context,
                    icon: Icons.link,
                    label: 'URL de Acesso',
                    description: instancia?.url,
                    color: Colors.blue,
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _rowInfo(
  BuildContext context, {
  required String label,
  String? description,
  IconData? icon,
  Color? color,
  TextOverflow? overflow,
}) => Padding(
  padding: const EdgeInsets.only(bottom: 8.0),
  child: Row(
    children: [
      if (icon != null)
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(icon, color: color ?? Colors.blue),
        ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              overflow: overflow ?? TextOverflow.visible,
              style: context.theme.textTheme.titleMedium?.copyWith(
                color: color ?? Colors.blue,
              ),
            ),
            Text(
              description ?? 'Não informado',
              overflow: overflow ?? TextOverflow.visible,
              style: context.theme.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    ],
  ),
);
