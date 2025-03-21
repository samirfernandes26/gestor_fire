import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';
import 'package:gestor_fire/core/ui/widgets/fields/fields.dart';
import 'package:gestor_fire/core/ui/widgets/loaders/app_loader/app_loader.dart';
import 'package:gestor_fire/screens/instance/instance_state.dart';
import 'package:gestor_fire/screens/instance/instance_vm.dart';

class InstanceScreen extends ConsumerStatefulWidget {
  const InstanceScreen({super.key});

  @override
  ConsumerState<InstanceScreen> createState() => _InstanceScreenState();
}

class _InstanceScreenState extends ConsumerState<InstanceScreen> {
  final formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    final InstanceVm(:loadData, :editForm) = ref.read(
      instanceVmProvider.notifier,
    );

    final InstanceState(:status, :instancia, :enabledForm) = ref.watch(
      instanceVmProvider,
    );

    if (status == InstanceStatus.intial || arguments?['reload'] == true) {
      Future(() async {
        arguments!['reload'] = false;
        await loadData(arguments['instancia']);
      });
    }

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(title: const Text('Instancias')),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent,
          onPressed: () async {
            // TODO
          },
          child: const Icon(
            Icons.add_circle_outline,
            color: Colors.white,
            size: 32,
          ),
        ),
        body: Visibility(
          visible: true,
          replacement: const AppLoader(color: Colors.white),
          child: FormBuilder(
            autovalidateMode: AutovalidateMode.disabled,
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
                    textField(
                      context,
                      label: 'Informe o ticket',
                      name: 'senha',
                      isRequired: true,
                      initialValue: instancia?.cidadeId ?? '',
                    ),

                    const SizedBox(height: 8),

                    Divider(),

                    const SizedBox(height: 8),
                    Button(
                      textButton:
                          '${enabledForm == false ? 'Abilitar' : 'Desabilitar'} todos os campos',
                      colorText: Colors.white,
                      colorButton: Colors.blueAccent,
                      fontWeight: FontWeight.w700,
                      onPressed: () async {
                        editForm();
                      },
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Configuração de Instancia',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: textField(
                            context,
                            label: 'Cidade',
                            name: 'cidade',
                            initialValue: instancia?.cidade ?? '',
                            enabled: enabledForm!,
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: checkSingle(
                            context,
                            name: 'ativo',
                            label: 'Estado',
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                instancia?.ativo == 1
                                    ? 'Ativado'
                                    : 'Desativado',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            initialValue: instancia?.ativo == 1 ? true : false,
                            enabled: enabledForm,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),

                    textField(
                      context,
                      label: 'Cidade Id',
                      name: 'cidade_id',
                      isRequired: true,
                      enabled: enabledForm,
                      initialValue: instancia?.cidadeId ?? '',
                    ),

                    textField(
                      context,
                      label: 'Url Municipio',
                      name: 'id',
                      isRequired: true,
                      enabled: enabledForm,
                      initialValue: instancia?.id ?? '',
                    ),

                    textField(
                      context,
                      label: 'Municipio Id',
                      name: 'municipio_id',
                      isRequired: true,
                      enabled: enabledForm,
                      initialValue: instancia?.municipioId ?? '',
                    ),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: textField(
                            context,
                            label: 'Texto Visivel',
                            name: 'text',
                            isRequired: true,
                            enabled: enabledForm,
                            initialValue: instancia?.text ?? '',
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: textField(
                            context,
                            label: 'Estado uf',
                            name: 'text',
                            isRequired: true,
                            enabled: enabledForm,
                            maxLength: 2,
                            initialValue: instancia?.uf ?? '',
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Divider(),

                    const SizedBox(height: 8),
                    Text(
                      'Configuração de Feedback',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    checkSingle(
                      context,
                      name: 'feedback_ativo',
                      label: 'feedback',
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          instancia?.settings.feedback.ativo == 1
                              ? 'Ativado'
                              : 'Desativado',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      initialValue:
                          instancia?.settings.feedback.ativo == 1
                              ? true
                              : false,
                      enabled: enabledForm,
                      isRequired: true,
                    ),
                    checkSingle(
                      context,
                      name: 'feedback_usar_local',
                      label: 'Usar Configuração local',
                      title: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                        child: Text(
                          instancia?.settings.feedback.usarLocal == 1
                              ? 'Ativado'
                              : 'Desativado',
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      initialValue:
                          instancia?.settings.feedback.usarLocal == 1
                              ? true
                              : false,
                      enabled: enabledForm,
                      isRequired: true,
                    ),
                    textField(
                      context,
                      label: 'Periodo em dias',
                      name: 'feedback_periodo',
                      isRequired: true,
                      keyboardType: TextInputType.number,
                      initialValue:
                          instancia?.settings.feedback.periodo.toString() ?? '',
                      enabled: enabledForm,
                    ),

                    const SizedBox(height: 8),

                    Divider(),

                    const SizedBox(height: 8),
                    Text(
                      'Configuração de GPS',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: checkSingle(
                            context,
                            name: 'precision_GPS',
                            label: 'Precisão GPS',
                            enabled: enabledForm,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                instancia?.settings.gps.precisionGps == 1
                                    ? 'Ativado'
                                    : 'Desativado',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            initialValue:
                                instancia?.settings.gps.precisionGps == 1
                                    ? true
                                    : false,
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: checkSingle(
                            context,
                            name: 'searchType_GPS',
                            label: 'SearchType Gps',
                            enabled: enabledForm,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                instancia?.ativo == 1
                                    ? 'Ativado'
                                    : 'Desativado',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            initialValue:
                                instancia?.settings.gps.searchTypeGps == 1
                                    ? true
                                    : false,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    Divider(),

                    const SizedBox(height: 8),
                    Text(
                      'Configuração de Pesquisa',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: checkSingle(
                            context,
                            name: 'covid',
                            label: 'Persquisa Covid',
                            enabled: enabledForm,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                instancia?.settings.pesquisa.covid == 1
                                    ? 'Ativado'
                                    : 'Desativado',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            initialValue:
                                instancia?.settings.pesquisa.covid == 1
                                    ? true
                                    : false,
                            isRequired: true,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: checkSingle(
                            context,
                            name: 'pesquisa_usar_local',
                            label: 'Usar Configuração local',
                            enabled: enabledForm,
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text(
                                instancia?.settings.pesquisa.usarLocal == 1
                                    ? 'Ativado'
                                    : 'Desativado',
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            initialValue:
                                instancia?.settings.pesquisa.usarLocal == 1
                                    ? true
                                    : false,
                            isRequired: true,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
