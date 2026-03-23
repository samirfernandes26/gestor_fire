// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instance_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(InstanceVm)
final instanceVmProvider = InstanceVmProvider._();

final class InstanceVmProvider
    extends $NotifierProvider<InstanceVm, InstanceState> {
  InstanceVmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'instanceVmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$instanceVmHash();

  @$internal
  @override
  InstanceVm create() => InstanceVm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(InstanceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<InstanceState>(value),
    );
  }
}

String _$instanceVmHash() => r'd1a9b1196e0e7cea3da3b7a959c1beefb4ea9ae4';

abstract class _$InstanceVm extends $Notifier<InstanceState> {
  InstanceState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<InstanceState, InstanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<InstanceState, InstanceState>,
              InstanceState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
