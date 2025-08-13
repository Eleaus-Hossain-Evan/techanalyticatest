// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(googleMapsApiKey)
const googleMapsApiKeyProvider = GoogleMapsApiKeyProvider._();

final class GoogleMapsApiKeyProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  const GoogleMapsApiKeyProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleMapsApiKeyProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleMapsApiKeyHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return googleMapsApiKey(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$googleMapsApiKeyHash() => r'79b7019cf55b61c291d8d5c0340ece42df3aff79';

@ProviderFor(googleDirectionsDataSource)
const googleDirectionsDataSourceProvider =
    GoogleDirectionsDataSourceProvider._();

final class GoogleDirectionsDataSourceProvider
    extends
        $FunctionalProvider<
          GoogleDirectionsDataSource,
          GoogleDirectionsDataSource,
          GoogleDirectionsDataSource
        >
    with $Provider<GoogleDirectionsDataSource> {
  const GoogleDirectionsDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'googleDirectionsDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$googleDirectionsDataSourceHash();

  @$internal
  @override
  $ProviderElement<GoogleDirectionsDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GoogleDirectionsDataSource create(Ref ref) {
    return googleDirectionsDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoogleDirectionsDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoogleDirectionsDataSource>(value),
    );
  }
}

String _$googleDirectionsDataSourceHash() =>
    r'5276e539e13c9ae255dea7a0216381d1e896081a';

@ProviderFor(mapRepository)
const mapRepositoryProvider = MapRepositoryProvider._();

final class MapRepositoryProvider
    extends $FunctionalProvider<MapRepository, MapRepository, MapRepository>
    with $Provider<MapRepository> {
  const MapRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapRepositoryHash();

  @$internal
  @override
  $ProviderElement<MapRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  MapRepository create(Ref ref) {
    return mapRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(MapRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<MapRepository>(value),
    );
  }
}

String _$mapRepositoryHash() => r'd4509fc93b336955b8a8e36c4b6cad415157107d';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
