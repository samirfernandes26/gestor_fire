// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lista_instances_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ListaInstancesVm)
final listaInstancesVmProvider = ListaInstancesVmProvider._();

final class ListaInstancesVmProvider
    extends $NotifierProvider<ListaInstancesVm, ListaInstancesState> {
  ListaInstancesVmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'listaInstancesVmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$listaInstancesVmHash();

  @$internal
  @override
  ListaInstancesVm create() => ListaInstancesVm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ListaInstancesState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ListaInstancesState>(value),
    );
  }
}

String _$listaInstancesVmHash() => r'f7e9dc4827dbc893563f4ce559e357d225238abe';

abstract class _$ListaInstancesVm extends $Notifier<ListaInstancesState> {
  ListaInstancesState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ListaInstancesState, ListaInstancesState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ListaInstancesState, ListaInstancesState>,
              ListaInstancesState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
