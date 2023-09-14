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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
