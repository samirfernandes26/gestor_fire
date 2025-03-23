import 'package:flutter/material.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class SolicitaSenhaUsuarioDialog extends StatelessWidget {
  const SolicitaSenhaUsuarioDialog({
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
                  'Informe a senha para liberação',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 24),

                FormBuilderTextField(
                  name: 'senha',
                  onTapOutside: (_) => context.unfocus(),
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('informe a sua senha de acesso'),
                  ),
                  keyboardType: TextInputType.number,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                      errorText: 'senha e obrigatório',
                    ),
                  ]),
                ),

                const SizedBox(height: 16),

                Button(
                  textButton: 'Entrar',
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
