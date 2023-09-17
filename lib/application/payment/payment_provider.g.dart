// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getPendingPaymentListHash() =>
    r'679e4f131f960065eeeaac2f04773e838487c1b0';

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

typedef GetPendingPaymentListRef
    = AutoDisposeFutureProviderRef<PendingPaymentResponse>;

/// See also [getPendingPaymentList].
@ProviderFor(getPendingPaymentList)
const getPendingPaymentListProvider = GetPendingPaymentListFamily();

/// See also [getPendingPaymentList].
class GetPendingPaymentListFamily
    extends Family<AsyncValue<PendingPaymentResponse>> {
  /// See also [getPendingPaymentList].
  const GetPendingPaymentListFamily();

  /// See also [getPendingPaymentList].
  GetPendingPaymentListProvider call({
    int page = 1,
    int limit = 10,
  }) {
    return GetPendingPaymentListProvider(
      page: page,
      limit: limit,
    );
  }

  @override
  GetPendingPaymentListProvider getProviderOverride(
    covariant GetPendingPaymentListProvider provider,
  ) {
    return call(
      page: provider.page,
      limit: provider.limit,
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
  String? get name => r'getPendingPaymentListProvider';
}

/// See also [getPendingPaymentList].
class GetPendingPaymentListProvider
    extends AutoDisposeFutureProvider<PendingPaymentResponse> {
  /// See also [getPendingPaymentList].
  GetPendingPaymentListProvider({
    this.page = 1,
    this.limit = 10,
  }) : super.internal(
          (ref) => getPendingPaymentList(
            ref,
            page: page,
            limit: limit,
          ),
          from: getPendingPaymentListProvider,
          name: r'getPendingPaymentListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getPendingPaymentListHash,
          dependencies: GetPendingPaymentListFamily._dependencies,
          allTransitiveDependencies:
              GetPendingPaymentListFamily._allTransitiveDependencies,
        );

  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return other is GetPendingPaymentListProvider &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getHistoryPaymentListHash() =>
    r'a2dc377fd0cea0110b9528a29457fe489d6867fc';
typedef GetHistoryPaymentListRef
    = AutoDisposeFutureProviderRef<HistoryPaymentListResponse>;

/// See also [getHistoryPaymentList].
@ProviderFor(getHistoryPaymentList)
const getHistoryPaymentListProvider = GetHistoryPaymentListFamily();

/// See also [getHistoryPaymentList].
class GetHistoryPaymentListFamily
    extends Family<AsyncValue<HistoryPaymentListResponse>> {
  /// See also [getHistoryPaymentList].
  const GetHistoryPaymentListFamily();

  /// See also [getHistoryPaymentList].
  GetHistoryPaymentListProvider call({
    int page = 1,
    int limit = 10,
  }) {
    return GetHistoryPaymentListProvider(
      page: page,
      limit: limit,
    );
  }

  @override
  GetHistoryPaymentListProvider getProviderOverride(
    covariant GetHistoryPaymentListProvider provider,
  ) {
    return call(
      page: provider.page,
      limit: provider.limit,
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
  String? get name => r'getHistoryPaymentListProvider';
}

/// See also [getHistoryPaymentList].
class GetHistoryPaymentListProvider
    extends AutoDisposeFutureProvider<HistoryPaymentListResponse> {
  /// See also [getHistoryPaymentList].
  GetHistoryPaymentListProvider({
    this.page = 1,
    this.limit = 10,
  }) : super.internal(
          (ref) => getHistoryPaymentList(
            ref,
            page: page,
            limit: limit,
          ),
          from: getHistoryPaymentListProvider,
          name: r'getHistoryPaymentListProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getHistoryPaymentListHash,
          dependencies: GetHistoryPaymentListFamily._dependencies,
          allTransitiveDependencies:
              GetHistoryPaymentListFamily._allTransitiveDependencies,
        );

  final int page;
  final int limit;

  @override
  bool operator ==(Object other) {
    return other is GetHistoryPaymentListProvider &&
        other.page == page &&
        other.limit == limit;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, limit.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getSinglePaymentHistoryHash() =>
    r'8cf12aa4496fbd910431dfabf55990837a5106e8';
typedef GetSinglePaymentHistoryRef
    = AutoDisposeFutureProviderRef<SingleHistoryPaymentResponse>;

/// See also [getSinglePaymentHistory].
@ProviderFor(getSinglePaymentHistory)
const getSinglePaymentHistoryProvider = GetSinglePaymentHistoryFamily();

/// See also [getSinglePaymentHistory].
class GetSinglePaymentHistoryFamily
    extends Family<AsyncValue<SingleHistoryPaymentResponse>> {
  /// See also [getSinglePaymentHistory].
  const GetSinglePaymentHistoryFamily();

  /// See also [getSinglePaymentHistory].
  GetSinglePaymentHistoryProvider call({
    required String historyId,
  }) {
    return GetSinglePaymentHistoryProvider(
      historyId: historyId,
    );
  }

  @override
  GetSinglePaymentHistoryProvider getProviderOverride(
    covariant GetSinglePaymentHistoryProvider provider,
  ) {
    return call(
      historyId: provider.historyId,
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
  String? get name => r'getSinglePaymentHistoryProvider';
}

/// See also [getSinglePaymentHistory].
class GetSinglePaymentHistoryProvider
    extends AutoDisposeFutureProvider<SingleHistoryPaymentResponse> {
  /// See also [getSinglePaymentHistory].
  GetSinglePaymentHistoryProvider({
    required this.historyId,
  }) : super.internal(
          (ref) => getSinglePaymentHistory(
            ref,
            historyId: historyId,
          ),
          from: getSinglePaymentHistoryProvider,
          name: r'getSinglePaymentHistoryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getSinglePaymentHistoryHash,
          dependencies: GetSinglePaymentHistoryFamily._dependencies,
          allTransitiveDependencies:
              GetSinglePaymentHistoryFamily._allTransitiveDependencies,
        );

  final String historyId;

  @override
  bool operator ==(Object other) {
    return other is GetSinglePaymentHistoryProvider &&
        other.historyId == historyId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, historyId.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
