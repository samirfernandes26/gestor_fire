// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeVm)
final homeVmProvider = HomeVmProvider._();

final class HomeVmProvider extends $NotifierProvider<HomeVm, HomeState> {
  HomeVmProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeVmProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeVmHash();

  @$internal
  @override
  HomeVm create() => HomeVm();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeState>(value),
    );
  }
}

String _$homeVmHash() => r'1334131b1149b42c1b703fa8c838f218a77bf38c';

abstract class _$HomeVm extends $Notifier<HomeState> {
  HomeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeState, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeState, HomeState>,
              HomeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
