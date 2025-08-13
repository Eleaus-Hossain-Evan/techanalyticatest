// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

/// Trip repository provider
@ProviderFor(tripRepository)
const tripRepositoryProvider = TripRepositoryProvider._();

/// Trip repository provider
final class TripRepositoryProvider
    extends $FunctionalProvider<TripRepository, TripRepository, TripRepository>
    with $Provider<TripRepository> {
  /// Trip repository provider
  const TripRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripRepositoryHash();

  @$internal
  @override
  $ProviderElement<TripRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TripRepository create(Ref ref) {
    return tripRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripRepository>(value),
    );
  }
}

String _$tripRepositoryHash() => r'6325dfd6dc320fa1aa5a552cc15ebaa58e32a846';

/// Get trips by status use case provider
@ProviderFor(getTripsByStatusUseCase)
const getTripsByStatusUseCaseProvider = GetTripsByStatusUseCaseProvider._();

/// Get trips by status use case provider
final class GetTripsByStatusUseCaseProvider
    extends
        $FunctionalProvider<
          GetTripsByStatusUseCase,
          GetTripsByStatusUseCase,
          GetTripsByStatusUseCase
        >
    with $Provider<GetTripsByStatusUseCase> {
  /// Get trips by status use case provider
  const GetTripsByStatusUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getTripsByStatusUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getTripsByStatusUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetTripsByStatusUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetTripsByStatusUseCase create(Ref ref) {
    return getTripsByStatusUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetTripsByStatusUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetTripsByStatusUseCase>(value),
    );
  }
}

String _$getTripsByStatusUseCaseHash() =>
    r'aa7c990d0d08efc6300878669bf125bc4ba6b692';

/// Search trips use case provider
@ProviderFor(searchTripsUseCase)
const searchTripsUseCaseProvider = SearchTripsUseCaseProvider._();

/// Search trips use case provider
final class SearchTripsUseCaseProvider
    extends
        $FunctionalProvider<
          SearchTripsUseCase,
          SearchTripsUseCase,
          SearchTripsUseCase
        >
    with $Provider<SearchTripsUseCase> {
  /// Search trips use case provider
  const SearchTripsUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchTripsUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchTripsUseCaseHash();

  @$internal
  @override
  $ProviderElement<SearchTripsUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchTripsUseCase create(Ref ref) {
    return searchTripsUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchTripsUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchTripsUseCase>(value),
    );
  }
}

String _$searchTripsUseCaseHash() =>
    r'449222cc32cb0bce53fae45fff1b0e2e1e9ce899';

/// Provider for trips by status
@ProviderFor(tripsByStatus)
const tripsByStatusProvider = TripsByStatusProvider._();

/// Provider for trips by status
final class TripsByStatusProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  /// Provider for trips by status
  const TripsByStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'tripsByStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$tripsByStatusHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return tripsByStatus(ref);
  }
}

String _$tripsByStatusHash() => r'2e4e816b82e198f2c7aab264d70aca9bd65ee653';

/// Provider for searching trips
@ProviderFor(searchTrips)
const searchTripsProvider = SearchTripsProvider._();

/// Provider for searching trips
final class SearchTripsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  /// Provider for searching trips
  const SearchTripsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchTripsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchTripsHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return searchTrips(ref);
  }
}

String _$searchTripsHash() => r'4c15caa147ca2832e59357d3bc8a9ae9a7e64f98';

/// State provider for current selected tab
@ProviderFor(SelectedTripTab)
const selectedTripTabProvider = SelectedTripTabProvider._();

/// State provider for current selected tab
final class SelectedTripTabProvider
    extends $NotifierProvider<SelectedTripTab, TripStatus> {
  /// State provider for current selected tab
  const SelectedTripTabProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTripTabProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTripTabHash();

  @$internal
  @override
  SelectedTripTab create() => SelectedTripTab();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TripStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TripStatus>(value),
    );
  }
}

String _$selectedTripTabHash() => r'571206fb69bbeee3f14b4157f92d71574ed7fae8';

abstract class _$SelectedTripTab extends $Notifier<TripStatus> {
  TripStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TripStatus, TripStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TripStatus, TripStatus>,
              TripStatus,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// State provider for search query
@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

/// State provider for search query
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// State provider for search query
  const SearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'5cfb8bc058f64b12d9a61421526a8ea7b414d4fa';

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for the combined trips
@ProviderFor(combinedTrips)
const combinedTripsProvider = CombinedTripsProvider._();

/// Provider for the combined trips
final class CombinedTripsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Trip>>,
          List<Trip>,
          FutureOr<List<Trip>>
        >
    with $FutureModifier<List<Trip>>, $FutureProvider<List<Trip>> {
  /// Provider for the combined trips
  const CombinedTripsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'combinedTripsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$combinedTripsHash();

  @$internal
  @override
  $FutureProviderElement<List<Trip>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Trip>> create(Ref ref) {
    return combinedTrips(ref);
  }
}

String _$combinedTripsHash() => r'c47bfe8fb49f41ee14642acda90dd73d4f546db4';

/// Provider for getting a trip by ID
@ProviderFor(tripById)
const tripByIdProvider = TripByIdFamily._();

/// Provider for getting a trip by ID
final class TripByIdProvider
    extends $FunctionalProvider<AsyncValue<Trip?>, Trip?, FutureOr<Trip?>>
    with $FutureModifier<Trip?>, $FutureProvider<Trip?> {
  /// Provider for getting a trip by ID
  const TripByIdProvider._({
    required TripByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'tripByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$tripByIdHash();

  @override
  String toString() {
    return r'tripByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Trip?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Trip?> create(Ref ref) {
    final argument = this.argument as String;
    return tripById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TripByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tripByIdHash() => r'86956c184f955c66d6daa373fa1654e8b31d829f';

/// Provider for getting a trip by ID
final class TripByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Trip?>, String> {
  const TripByIdFamily._()
    : super(
        retry: null,
        name: r'tripByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Provider for getting a trip by ID
  TripByIdProvider call(String tripId) =>
      TripByIdProvider._(argument: tripId, from: this);

  @override
  String toString() => r'tripByIdProvider';
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
