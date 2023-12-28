// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recentParcelHash() => r'124aaddea1754c11f1ea9422c51c4f5a601d0746';

/// See also [recentParcel].
@ProviderFor(recentParcel)
final recentParcelProvider =
    AutoDisposeFutureProvider<FetchAllParcelResponse>.internal(
  recentParcel,
  name: r'recentParcelProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$recentParcelHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RecentParcelRef = AutoDisposeFutureProviderRef<FetchAllParcelResponse>;
String _$createBulkParcelHash() => r'473c4c3334940bab8036d5dcefd9463af945ff6a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [createBulkParcel].
@ProviderFor(createBulkParcel)
const createBulkParcelProvider = CreateBulkParcelFamily();

/// See also [createBulkParcel].
class CreateBulkParcelFamily
    extends Family<AsyncValue<FetchAllParcelResponse>> {
  /// See also [createBulkParcel].
  const CreateBulkParcelFamily();

  /// See also [createBulkParcel].
  CreateBulkParcelProvider call({
    required MerchantInfoModel merchant,
    required String data,
  }) {
    return CreateBulkParcelProvider(
      merchant: merchant,
      data: data,
    );
  }

  @override
  CreateBulkParcelProvider getProviderOverride(
    covariant CreateBulkParcelProvider provider,
  ) {
    return call(
      merchant: provider.merchant,
      data: provider.data,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'createBulkParcelProvider';
}

/// See also [createBulkParcel].
class CreateBulkParcelProvider
    extends AutoDisposeFutureProvider<FetchAllParcelResponse> {
  /// See also [createBulkParcel].
  CreateBulkParcelProvider({
    required MerchantInfoModel merchant,
    required String data,
  }) : this._internal(
          (ref) => createBulkParcel(
            ref as CreateBulkParcelRef,
            merchant: merchant,
            data: data,
          ),
          from: createBulkParcelProvider,
          name: r'createBulkParcelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$createBulkParcelHash,
          dependencies: CreateBulkParcelFamily._dependencies,
          allTransitiveDependencies:
              CreateBulkParcelFamily._allTransitiveDependencies,
          merchant: merchant,
          data: data,
        );

  CreateBulkParcelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.merchant,
    required this.data,
  }) : super.internal();

  final MerchantInfoModel merchant;
  final String data;

  @override
  Override overrideWith(
    FutureOr<FetchAllParcelResponse> Function(CreateBulkParcelRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CreateBulkParcelProvider._internal(
        (ref) => create(ref as CreateBulkParcelRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        merchant: merchant,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FetchAllParcelResponse> createElement() {
    return _CreateBulkParcelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CreateBulkParcelProvider &&
        other.merchant == merchant &&
        other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, merchant.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CreateBulkParcelRef
    on AutoDisposeFutureProviderRef<FetchAllParcelResponse> {
  /// The parameter `merchant` of this provider.
  MerchantInfoModel get merchant;

  /// The parameter `data` of this provider.
  String get data;
}

class _CreateBulkParcelProviderElement
    extends AutoDisposeFutureProviderElement<FetchAllParcelResponse>
    with CreateBulkParcelRef {
  _CreateBulkParcelProviderElement(super.provider);

  @override
  MerchantInfoModel get merchant =>
      (origin as CreateBulkParcelProvider).merchant;
  @override
  String get data => (origin as CreateBulkParcelProvider).data;
}

String _$singleParcelHash() => r'909b79e29e9fa9df6f13880aa7b9f62b610dc6bb';

abstract class _$SingleParcel
    extends BuildlessAutoDisposeAsyncNotifier<ParcelModel> {
  late final String id;

  FutureOr<ParcelModel> build(
    String id,
  );
}

/// See also [SingleParcel].
@ProviderFor(SingleParcel)
const singleParcelProvider = SingleParcelFamily();

/// See also [SingleParcel].
class SingleParcelFamily extends Family<AsyncValue<ParcelModel>> {
  /// See also [SingleParcel].
  const SingleParcelFamily();

  /// See also [SingleParcel].
  SingleParcelProvider call(
    String id,
  ) {
    return SingleParcelProvider(
      id,
    );
  }

  @override
  SingleParcelProvider getProviderOverride(
    covariant SingleParcelProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'singleParcelProvider';
}

/// See also [SingleParcel].
class SingleParcelProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SingleParcel, ParcelModel> {
  /// See also [SingleParcel].
  SingleParcelProvider(
    String id,
  ) : this._internal(
          () => SingleParcel()..id = id,
          from: singleParcelProvider,
          name: r'singleParcelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$singleParcelHash,
          dependencies: SingleParcelFamily._dependencies,
          allTransitiveDependencies:
              SingleParcelFamily._allTransitiveDependencies,
          id: id,
        );

  SingleParcelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<ParcelModel> runNotifierBuild(
    covariant SingleParcel notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(SingleParcel Function() create) {
    return ProviderOverride(
      origin: this,
      override: SingleParcelProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SingleParcel, ParcelModel>
      createElement() {
    return _SingleParcelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SingleParcelProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin SingleParcelRef on AutoDisposeAsyncNotifierProviderRef<ParcelModel> {
  /// The parameter `id` of this provider.
  String get id;
}

class _SingleParcelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SingleParcel, ParcelModel>
    with SingleParcelRef {
  _SingleParcelProviderElement(super.provider);

  @override
  String get id => (origin as SingleParcelProvider).id;
}

String _$fetchAllTypeParcelHash() =>
    r'0e53266d2253900b21a2c8f550cb8a1517c29130';

abstract class _$FetchAllTypeParcel
    extends BuildlessAutoDisposeAsyncNotifier<FetchAllParcelResponse> {
  late final ParcelRegularStatus type;
  late final int page;
  late final int limit;
  late final String value;
  late final String startTime;
  late final String endTime;

  FutureOr<FetchAllParcelResponse> build({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
    String value = "",
    String startTime = "",
    String endTime = "",
  });
}

/// See also [FetchAllTypeParcel].
@ProviderFor(FetchAllTypeParcel)
const fetchAllTypeParcelProvider = FetchAllTypeParcelFamily();

/// See also [FetchAllTypeParcel].
class FetchAllTypeParcelFamily
    extends Family<AsyncValue<FetchAllParcelResponse>> {
  /// See also [FetchAllTypeParcel].
  const FetchAllTypeParcelFamily();

  /// See also [FetchAllTypeParcel].
  FetchAllTypeParcelProvider call({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
    String value = "",
    String startTime = "",
    String endTime = "",
  }) {
    return FetchAllTypeParcelProvider(
      type: type,
      page: page,
      limit: limit,
      value: value,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  FetchAllTypeParcelProvider getProviderOverride(
    covariant FetchAllTypeParcelProvider provider,
  ) {
    return call(
      type: provider.type,
      page: provider.page,
      limit: provider.limit,
      value: provider.value,
      startTime: provider.startTime,
      endTime: provider.endTime,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchAllTypeParcelProvider';
}

/// See also [FetchAllTypeParcel].
class FetchAllTypeParcelProvider extends AutoDisposeAsyncNotifierProviderImpl<
    FetchAllTypeParcel, FetchAllParcelResponse> {
  /// See also [FetchAllTypeParcel].
  FetchAllTypeParcelProvider({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
    String value = "",
    String startTime = "",
    String endTime = "",
  }) : this._internal(
          () => FetchAllTypeParcel()
            ..type = type
            ..page = page
            ..limit = limit
            ..value = value
            ..startTime = startTime
            ..endTime = endTime,
          from: fetchAllTypeParcelProvider,
          name: r'fetchAllTypeParcelProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchAllTypeParcelHash,
          dependencies: FetchAllTypeParcelFamily._dependencies,
          allTransitiveDependencies:
              FetchAllTypeParcelFamily._allTransitiveDependencies,
          type: type,
          page: page,
          limit: limit,
          value: value,
          startTime: startTime,
          endTime: endTime,
        );

  FetchAllTypeParcelProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.type,
    required this.page,
    required this.limit,
    required this.value,
    required this.startTime,
    required this.endTime,
  }) : super.internal();

  final ParcelRegularStatus type;
  final int page;
  final int limit;
  final String value;
  final String startTime;
  final String endTime;

  @override
  FutureOr<FetchAllParcelResponse> runNotifierBuild(
    covariant FetchAllTypeParcel notifier,
  ) {
    return notifier.build(
      type: type,
      page: page,
      limit: limit,
      value: value,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  Override overrideWith(FetchAllTypeParcel Function() create) {
    return ProviderOverride(
      origin: this,
      override: FetchAllTypeParcelProvider._internal(
        () => create()
          ..type = type
          ..page = page
          ..limit = limit
          ..value = value
          ..startTime = startTime
          ..endTime = endTime,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        type: type,
        page: page,
        limit: limit,
        value: value,
        startTime: startTime,
        endTime: endTime,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<FetchAllTypeParcel,
      FetchAllParcelResponse> createElement() {
    return _FetchAllTypeParcelProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchAllTypeParcelProvider &&
        other.type == type &&
        other.page == page &&
        other.limit == limit &&
        other.value == value &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, value.hashCode);
    hash = _SystemHash.combine(hash, startTime.hashCode);
    hash = _SystemHash.combine(hash, endTime.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchAllTypeParcelRef
    on AutoDisposeAsyncNotifierProviderRef<FetchAllParcelResponse> {
  /// The parameter `type` of this provider.
  ParcelRegularStatus get type;

  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `limit` of this provider.
  int get limit;

  /// The parameter `value` of this provider.
  String get value;

  /// The parameter `startTime` of this provider.
  String get startTime;

  /// The parameter `endTime` of this provider.
  String get endTime;
}

class _FetchAllTypeParcelProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<FetchAllTypeParcel,
        FetchAllParcelResponse> with FetchAllTypeParcelRef {
  _FetchAllTypeParcelProviderElement(super.provider);

  @override
  ParcelRegularStatus get type => (origin as FetchAllTypeParcelProvider).type;
  @override
  int get page => (origin as FetchAllTypeParcelProvider).page;
  @override
  int get limit => (origin as FetchAllTypeParcelProvider).limit;
  @override
  String get value => (origin as FetchAllTypeParcelProvider).value;
  @override
  String get startTime => (origin as FetchAllTypeParcelProvider).startTime;
  @override
  String get endTime => (origin as FetchAllTypeParcelProvider).endTime;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
