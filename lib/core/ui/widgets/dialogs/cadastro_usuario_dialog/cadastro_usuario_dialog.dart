import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:gestor_fire/core/ui/widgets/fields/fields.dart';

class CadastroUsuarioDialog extends StatelessWidget {
  const CadastroUsuarioDialog({
    super.key,
    required this.formKey,
    required this.register,
  });

  final GlobalKey<FormBuilderState> formKey;
  final Future<void> Function() register;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: context.theme.colorScheme.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: FormBuilder(
            autovalidateMode: AutovalidateMode.disabled,
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Cadastro de Usuário',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 24),
                FormBuilderTextField(
                  name: 'nome',
                  onTapOutside: (_) => context.unfocus(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('Infome seu nome completo'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Nome é obrigatório',
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'cpf',
                  onTapOutside: (_) => context.unfocus(),
                  keyboardType: TextInputType.numberWithOptions(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('Inform seu cpf'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Cpf é obrigatório',
                    ),
                  ]),
                ),

                radioGroup<String>(
                  context,
                  name: 'sexo',
                  label: 'Sexo',
                  isRequired: true,
                  orientation: OptionsOrientation.horizontal,
                  options:
                      [
                            {'value': 'masculino', 'description': 'Masculino'},
                            {'value': 'feminino', 'description': 'Feminino'},
                          ]
                          .map(
                            (option) => (
                              value: option['value'] as String,
                              description: option['description'] as String,
                            ),
                          )
                          .toList(),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Sexo é obrigatório',
                    ),
                  ]),
                ),
                FormBuilderTextField(
                  name: 'funcao',
                  onTapOutside: (_) => context.unfocus(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('Informe sua função'),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'Fução é obrigatório',
                    ),
                  ]),
                ),
                const SizedBox(height: 16),
                Button(
                  textButton: 'Cadastrar',
                  colorText: Colors.white,
                  colorButton: Colors.blueAccent,
                  fontWeight: FontWeight.w700,
                  onPressed: () async {
                    switch (formKey.currentState?.saveAndValidate()) {
                      case true:
                        await register();
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
