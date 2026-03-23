// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LoginVm)
final loginVmProvider = LoginVmProvider._();

final class LoginVmProvider extends $NotifierProvider<LoginVm, LoginState> {
  LoginVmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'loginVmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$loginVmHash();

  @$internal
  @override
  LoginVm create() => LoginVm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LoginState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LoginState>(value),
    );
  }
}

String _$loginVmHash() => r'cb48d75c5ddfe20f926734e62bf077dc306fb1c3';

abstract class _$LoginVm extends $Notifier<LoginState> {
  LoginState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<LoginState, LoginState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<LoginState, LoginState>,
              LoginState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
