import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gestor_fire/core/extensions/build_context_extention.dart';
import 'package:gestor_fire/core/ui/widgets/buttons/button/button.dart';
import 'package:gestor_fire/screens/auth/login/login_state.dart';
import 'package:gestor_fire/screens/auth/login/login_vm.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.read(loginVmProvider.notifier);
    final LoginState(:status) = ref.watch(loginVmProvider);

    final isLoading = status == LoginStatus.loading;

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FormBuilder(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Acesso ao sistema',
                        textAlign: TextAlign.center,
                        style: context.theme.textTheme.titleLarge?.copyWith(
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      FormBuilderTextField(
                        name: 'cpf',
                        enabled: !isLoading,
                        keyboardType: TextInputType.number,
                        maxLength: 11,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          labelText: 'CPF',
                          hintText: 'Informe seu CPF',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'CPF é obrigatório'),
                          FormBuilderValidators.minLength(
                            11,
                            errorText: 'CPF deve conter 11 dígitos',
                          ),
                          FormBuilderValidators.maxLength(
                            11,
                            errorText: 'CPF deve conter 11 dígitos',
                          ),
                        ]),
                      ),
                      const SizedBox(height: 8),
                      FormBuilderTextField(
                        name: 'senha',
                        enabled: !isLoading,
                        keyboardType: TextInputType.number,
                        obscureText: true,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        onTapOutside: (_) => context.unfocus(),
                        decoration: const InputDecoration(
                          labelText: 'Senha',
                          hintText: 'Informe sua senha',
                        ),
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(errorText: 'Senha é obrigatória'),
                        ]),
                      ),
                      const SizedBox(height: 20),
                      Button(
                        textButton: isLoading ? 'Entrando...' : 'Entrar',
                        colorText: Colors.white,
                        colorButton: Colors.blueAccent,
                        fontWeight: FontWeight.w700,
                        onPressed: () async {
                          if (isLoading) return;

                          switch (_formKey.currentState?.saveAndValidate()) {
                            case true:
                              final values = _formKey.currentState!.value;
                              await login(
                                cpf: values['cpf'] as String? ?? '',
                                senha: values['senha'] as String? ?? '',
                                context: context,
                              );
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
          ),
        ),
      ),
    );
  }
}
