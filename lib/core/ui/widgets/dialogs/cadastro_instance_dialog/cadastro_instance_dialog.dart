import 'package:flutter/material.dart';
import 'package:diacritic/diacritic.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/helper/data/estados_do_brasil.dart';
import 'package:gestor_fire/core/helper/data/localidade.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

final Map<String, int> _ufIdBySigla = {
  for (var i = 0; i < estadosDoBrasilData.length; i++)
    estadosDoBrasilData[i].value: i + 1,
};

Map<String, dynamic>? _findLocalidadeByTexto({
  required String? texto,
  required String? estadoSigla,
}) {
  if (texto == null || texto.trim().isEmpty) {
    return null;
  }

  final normalized = removeDiacritics(texto.toLowerCase().trim());
  final ufId = _ufIdBySigla[estadoSigla];

  for (final item in localidadeData) {
    final localidadeFiltro = item['localidade_filtro'] as String? ?? '';
    final itemUfId = item['uf_id'] as int?;

    final matchesUf = ufId == null || itemUfId == ufId;
    final matchesLocalidade = localidadeFiltro == normalized;

    if (matchesUf && matchesLocalidade) {
      return item;
    }
  }

  return null;
}

class CadastroInstanceDialog extends StatelessWidget {
  const CadastroInstanceDialog({
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

                const SizedBox(height: 24),

                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final termo = removeDiacritics(
                      textEditingValue.text.toLowerCase().trim(),
                    );

                    if (termo.isEmpty) {
                      return const Iterable<String>.empty();
                    }

                    final estadoSelecionado =
                        formKey.currentState?.fields['estado']?.value
                            as String?;
                    final ufId = _ufIdBySigla[estadoSelecionado];

                    return localidadeData
                        .where((localidade) {
                          final localidadeFiltro =
                              localidade['localidade_filtro'] as String? ?? '';
                          final itemUfId = localidade['uf_id'] as int?;
                          final matchesUf = ufId == null || itemUfId == ufId;

                          return matchesUf && localidadeFiltro.contains(termo);
                        })
                        .map((localidade) => localidade['localidade'] as String)
                        .toSet()
                        .take(30);
                  },
                  fieldViewBuilder:
                      (
                        context,
                        textEditingController,
                        focusNode,
                        onFieldSubmitted,
                      ) => FormBuilderTextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        name: 'localidade_id',
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                          label: Text('Localidade'),
                        ),
                        valueTransformer: (value) {
                          final estadoSelecionado =
                              formKey.currentState?.fields['estado']?.value
                                  as String?;
                          final localidade = _findLocalidadeByTexto(
                            texto: value,
                            estadoSigla: estadoSelecionado,
                          );

                          return localidade?['id'];
                        },
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(
                            errorText: 'Localidade é obrigatória',
                          ),
                          (value) {
                            final estadoSelecionado =
                                formKey.currentState?.fields['estado']?.value
                                    as String?;
                            final localidade = _findLocalidadeByTexto(
                              texto: value,
                              estadoSigla: estadoSelecionado,
                            );

                            if (localidade == null) {
                              return 'Selecione uma localidade válida da lista';
                            }

                            return null;
                          },
                        ]),
                      ),
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
