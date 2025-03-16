import 'package:flutter/material.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

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
                  'Cadastro de instancia',
                  style: const TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 16),

                const SizedBox(height: 24),
                FormBuilderTextField(
                  name: 'municipio',
                  onTapOutside: (_) => context.unfocus(),
                  initialValue: '',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('Informe o nome do muncipio'),
                  ),
                ),
                const SizedBox(height: 16),
                FormBuilderTextField(
                  name: 'estado',
                  onTapOutside: (_) => context.unfocus(),
                  initialValue: 'MG',
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    label: Text('Sigla do estado'),
                  ),
                  maxLength: 2,
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
