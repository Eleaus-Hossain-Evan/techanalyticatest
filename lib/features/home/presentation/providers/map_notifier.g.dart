// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(MapAsyncNotifier)
const mapAsyncNotifierProvider = MapAsyncNotifierFamily._();

final class MapAsyncNotifierProvider
    extends $AsyncNotifierProvider<MapAsyncNotifier, RouteModel?> {
  const MapAsyncNotifierProvider._({
    required MapAsyncNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'mapAsyncNotifierProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mapAsyncNotifierHash();

  @override
  String toString() {
    return r'mapAsyncNotifierProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  MapAsyncNotifier create() => MapAsyncNotifier();

  @override
  bool operator ==(Object other) {
    return other is MapAsyncNotifierProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mapAsyncNotifierHash() => r'f208bcc4b810b9c1055450a496c5e24334b009e0';

final class MapAsyncNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          MapAsyncNotifier,
          AsyncValue<RouteModel?>,
          RouteModel?,
          FutureOr<RouteModel?>,
          String
        > {
  const MapAsyncNotifierFamily._()
    : super(
        retry: null,
        name: r'mapAsyncNotifierProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MapAsyncNotifierProvider call(String identifier) =>
      MapAsyncNotifierProvider._(argument: identifier, from: this);

  @override
  String toString() => r'mapAsyncNotifierProvider';
}

abstract class _$MapAsyncNotifier extends $AsyncNotifier<RouteModel?> {
  late final _$args = ref.$arg as String;
  String get identifier => _$args;

  FutureOr<RouteModel?> build(String identifier);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref = this.ref as $Ref<AsyncValue<RouteModel?>, RouteModel?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<RouteModel?>, RouteModel?>,
              AsyncValue<RouteModel?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
