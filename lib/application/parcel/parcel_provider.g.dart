// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parcel_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$singleParcelHash() => r'909b79e29e9fa9df6f13880aa7b9f62b610dc6bb';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
