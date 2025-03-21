import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/collapse/collapsable_info_content/collapsable_info_content.dart';
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

    final VisualizarInstanceState(:instancia, :status) = ref.watch(
      visualizarInstanceVmProvider,
    );

    if (status == VisualizarInstanceStatus.initial ||
        arguments?['reload'] == true) {
      Future(() async {
        arguments!['reload'] = false;
        await loadData(arguments['instancia']);
      });
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            context.navigator.pushNamed(
              RouteGeneratorKeys.instanceScreen,
              arguments: {'instancia': instancia, 'reload': true},
            );
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
                  CollapsableInfoContent(
                    title: 'Dados Da Instancia',
                    content: [
                      _rowInfo(
                        context,
                        icon: Icons.badge,
                        label: 'Nome Instacia Exibido',
                        description: instancia?.text,
                        color: Colors.blue,
                      ),
                    ],
                    contentCollapsed: [
                      _rowInfo(
                        context,
                        icon: Icons.person,
                        label: 'Instancia Ativa',
                        description: instancia?.ativo == 1 ? 'Sim' : 'Não',
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.person,
                        label: 'Cidade',
                        description: instancia?.cidade,
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.label,
                        label: 'Cidade Id',
                        description: instancia?.cidadeId,
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Url Instancia',
                        description: instancia?.id,
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.badge,
                        label: 'Municipio Id',
                        description: instancia?.municipioId,
                        color: Colors.blue,
                      ),

                      // const Divider(),
                    ],
                  ),

                  CollapsableInfoContent(
                    title: 'Dados de configuração da instancia',
                    content: [
                      _rowInfo(
                        context,
                        icon: Icons.badge,
                        label: 'Senha / Ticket de manutenção',
                        description:
                            instancia?.settings.manutencao.senha.toString(),
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.badge,
                        label: 'Usa mdm',
                        description:
                            instancia?.settings.manutencao.mdm == 1
                                ? 'Sim'
                                : 'Não',
                        color: Colors.blue,
                      ),
                    ],
                    contentCollapsed: [
                      const Divider(),
                      _rowInfo(
                        context,
                        icon: Icons.person,
                        label: 'Feedback ativo',
                        description:
                            instancia?.settings.feedback.ativo == 1
                                ? 'Sim'
                                : 'Não',
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.person,
                        label: 'Periodo vigente Feedback em Dias',
                        description:
                            '${instancia?.settings.feedback.periodo ?? 0} Dias',
                        color: Colors.blue,
                      ),
                      _rowInfo(
                        context,
                        icon: Icons.label,
                        label: 'Usar Configuração local de Feedback',
                        description:
                            instancia?.settings.feedback.usarLocal == 1
                                ? 'Ativado'
                                : 'Desativado',
                        color: Colors.blue,
                      ),
                      const Divider(),
                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Precisão do GPS',
                        description:
                            instancia?.settings.gps.precisionGps == 1
                                ? 'Ativado'
                                : 'Desativado',
                        color: Colors.blue,
                      ),

                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Tipo de Pesquisa GPS',
                        description:
                            instancia?.settings.gps.searchTypeGps == 1
                                ? 'Ativado'
                                : 'Desativado',
                        color: Colors.blue,
                      ),
                      const Divider(),
                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label:
                            'Usuarios id com permissão de Logout com producão',
                        description: instancia
                            ?.settings
                            .manutencao
                            .logoutUserIdPermission
                            .join(','),
                        color: Colors.blue,
                      ),

                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Controle de manutenção',
                        description:
                            instancia?.settings.manutencao.controle == 1
                                ? 'Ativado'
                                : 'Desativado',
                        color: Colors.blue,
                      ),

                      const Divider(),

                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Pesquisa Covid',
                        description:
                            instancia?.settings.pesquisa.covid == 1
                                ? 'Ativado'
                                : 'Desativado',
                        color: Colors.blue,
                      ),

                      _rowInfo(
                        context,
                        icon: Icons.cake,
                        label: 'Usar configuração local de pesquisa',
                        description:
                            instancia?.settings.pesquisa.usarLocal == 1
                                ? 'Não'
                                : 'Sim',
                        color: Colors.blue,
                      ),
                    ],
                  ),
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
