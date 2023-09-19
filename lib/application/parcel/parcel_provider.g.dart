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

typedef CreateBulkParcelRef
    = AutoDisposeFutureProviderRef<FetchAllParcelResponse>;

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
    required this.merchant,
    required this.data,
  }) : super.internal(
          (ref) => createBulkParcel(
            ref,
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
        );

  final MerchantInfoModel merchant;
  final String data;

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

String _$singleParcelHash() => r'909b79e29e9fa9df6f13880aa7b9f62b610dc6bb';

abstract class _$SingleParcel
    extends BuildlessAutoDisposeAsyncNotifier<ParcelModel> {
  late final String id;

  Future<ParcelModel> build(
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
    this.id,
  ) : super.internal(
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
        );

  final String id;

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

  @override
  Future<ParcelModel> runNotifierBuild(
    covariant SingleParcel notifier,
  ) {
    return notifier.build(
      id,
    );
  }
}

String _$fetchAllTypeParcelHash() =>
    r'74778d98271bd8c736c712e1fa235f9ed0e7d478';

abstract class _$FetchAllTypeParcel
    extends BuildlessAutoDisposeAsyncNotifier<FetchAllParcelResponse> {
  late final ParcelRegularStatus type;
  late final int page;
  late final int limit;
  late final String serialId;
  late final String customerPhone;
  late final String startTime;
  late final String endTime;

  Future<FetchAllParcelResponse> build({
    ParcelRegularStatus type = ParcelRegularStatus.all,
    int page = 1,
    int limit = 10,
    String serialId = "",
    String customerPhone = "",
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
    String serialId = "",
    String customerPhone = "",
    String startTime = "",
    String endTime = "",
  }) {
    return FetchAllTypeParcelProvider(
      type: type,
      page: page,
      limit: limit,
      serialId: serialId,
      customerPhone: customerPhone,
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
      serialId: provider.serialId,
      customerPhone: provider.customerPhone,
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
    this.type = ParcelRegularStatus.all,
    this.page = 1,
    this.limit = 10,
    this.serialId = "",
    this.customerPhone = "",
    this.startTime = "",
    this.endTime = "",
  }) : super.internal(
          () => FetchAllTypeParcel()
            ..type = type
            ..page = page
            ..limit = limit
            ..serialId = serialId
            ..customerPhone = customerPhone
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
        );

  final ParcelRegularStatus type;
  final int page;
  final int limit;
  final String serialId;
  final String customerPhone;
  final String startTime;
  final String endTime;

  @override
  bool operator ==(Object other) {
    return other is FetchAllTypeParcelProvider &&
        other.type == type &&
        other.page == page &&
        other.limit == limit &&
        other.serialId == serialId &&
        other.customerPhone == customerPhone &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, type.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);
    hash = _SystemHash.combine(hash, serialId.hashCode);
    hash = _SystemHash.combine(hash, customerPhone.hashCode);
    hash = _SystemHash.combine(hash, startTime.hashCode);
    hash = _SystemHash.combine(hash, endTime.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  Future<FetchAllParcelResponse> runNotifierBuild(
    covariant FetchAllTypeParcel notifier,
  ) {
    return notifier.build(
      type: type,
      page: page,
      limit: limit,
      serialId: serialId,
      customerPhone: customerPhone,
      startTime: startTime,
      endTime: endTime,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
