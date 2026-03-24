import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    final InstanceVm(:loadData, :salvar) = ref.read(
      instanceVmProvider.notifier,
    );

    final InstanceState(:status, :instancia) = ref.watch(
      instanceVmProvider,
    );

    if (status == InstanceStatus.intial || arguments?['reload'] == true) {
      Future(() async {
        arguments!['reload'] = false;
        await loadData(arguments['instancia'], arguments['usuario']);
      });
    }

    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: AppBar(title: const Text('Instancias')),
        body: Visibility(
          visible: true,
          replacement: const AppLoader(color: Colors.white),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: IntrinsicHeight(
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
                      child: FormBuilder(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                instancia?.nome.toUpperCase() ??
                                    'Nova Instância',
                                textAlign: TextAlign.center,
                                style: context.theme.textTheme.bodySmall
                                    ?.copyWith(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: context.theme.colorScheme.primary,
                                  ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Visibility(
                              visible: instancia != null,
                              replacement: const SizedBox.shrink(),
                              child: Column(
                                children: [
                                  textField(
                                    context,
                                    name: 'nome',
                                    label: 'Nome',
                                    initialValue: instancia!.nome,
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'Nome é obrigatório';
                                      }
                                      return null;
                                    },
                                  ),
                                  textField(
                                    context,
                                    name: 'url',
                                    label: 'URL',
                                    initialValue: instancia.url,
                                    keyboardType: TextInputType.url,
                                    isRequired: true,
                                    validator: (value) {
                                      if (value == null ||
                                          value.trim().isEmpty) {
                                        return 'URL é obrigatória';
                                      }
                                      return null;
                                    },
                                  ),
                                  switchField(
                                    context,
                                    name: 'ativo',
                                    label: 'Ativo',
                                    initialValue: instancia.ativo,
                                    enabled: true,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: switchField(
                                          context,
                                          name: 'ace',
                                          label: 'ACE',
                                          initialValue: instancia.ace,
                                          enabled: true,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: switchField(
                                          context,
                                          name: 'acs',
                                          label: 'ACS',
                                          initialValue: instancia.acs,
                                          enabled: true,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: switchField(
                                          context,
                                          name: 'motorista',
                                          label: 'Motorista',
                                          initialValue: instancia.motorista,
                                          enabled: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),
                            const Text(
                              'Termo de Responsabilidade',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Eu, usuário deste sistema, assumo total responsabilidade por todas as ações realizadas nesta aplicação, '
                              'ciente de que estou operando diretamente sobre dados e funcionalidades em ambiente de produção.',
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Comprometo-me a:',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            const Padding(
                              padding: EdgeInsets.only(left: 12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '• Atuar com cautela e atenção redobrada em cada modificação;',
                                  ),
                                  Text(
                                    '• Registrar previamente uma demanda formal para qualquer alteração;',
                                  ),
                                  Text(
                                    '• Utilizar como senha apenas o número da demanda correspondente;',
                                  ),
                                  Text(
                                    '• Não compartilhar acessos ou credenciais com terceiros;',
                                  ),
                                  Text(
                                    '• Assumir integralmente as consequências por eventuais falhas ou prejuízos.',
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Este sistema registra logs de todas as operações realizadas, incluindo o responsável por cada ação. '
                              'Em caso de uso indevido, medidas administrativas poderão ser aplicadas.',
                            ),
                            const Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color:
                context.brightness == Brightness.dark
                    ? Colors.white
                    : context.theme.colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Button(
                  textButton: 'Salvar',
                  fontSize: 16,
                  useFlexible: true,
                  widthButton: 300,
                  textAlign: TextAlign.center,
                  colorText: Colors.white,
                  colorButton: Colors.green,
                  fontWeight: FontWeight.bold,
                  onPressed: () async {
                    switch (formKey.currentState?.saveAndValidate()) {
                      case true:
                        salvar(formKey.currentState?.value, context);
                        break;
                      case false || null:
                        break;
                    }
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
