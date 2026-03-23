// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visualizar_instance_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VisualizarInstanceVm)
final visualizarInstanceVmProvider = VisualizarInstanceVmProvider._();

final class VisualizarInstanceVmProvider
    extends $NotifierProvider<VisualizarInstanceVm, VisualizarInstanceState> {
  VisualizarInstanceVmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'visualizarInstanceVmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$visualizarInstanceVmHash();

  @$internal
  @override
  VisualizarInstanceVm create() => VisualizarInstanceVm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VisualizarInstanceState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VisualizarInstanceState>(value),
    );
  }
}

String _$visualizarInstanceVmHash() =>
    r'84b275acfdb552062abb4d37c90c7aa0bd95dc5a';

abstract class _$VisualizarInstanceVm
    extends $Notifier<VisualizarInstanceState> {
  VisualizarInstanceState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<VisualizarInstanceState, VisualizarInstanceState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VisualizarInstanceState, VisualizarInstanceState>,
              VisualizarInstanceState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
