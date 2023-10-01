// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeHash() => r'394c3e8324919a9b1d418781dfe5e4ab2402ef02';

/// See also [Home].
@ProviderFor(Home)
final homeProvider =
    AutoDisposeAsyncNotifierProvider<Home, HomeResponse>.internal(
  Home.new,
  name: r'homeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$homeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Home = AutoDisposeAsyncNotifier<HomeResponse>;
String _$dashboardHash() => r'd82ebd57a8ceafa062a449f0b5da99496cad4dba';

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

abstract class _$Dashboard
    extends BuildlessAutoDisposeAsyncNotifier<DashboardModel> {
  late final String startTime;
  late final String endTime;

  FutureOr<DashboardModel> build({
    String startTime = '',
    String endTime = '',
  });
}

/// See also [Dashboard].
@ProviderFor(Dashboard)
const dashboardProvider = DashboardFamily();

/// See also [Dashboard].
class DashboardFamily extends Family<AsyncValue<DashboardModel>> {
  /// See also [Dashboard].
  const DashboardFamily();

  /// See also [Dashboard].
  DashboardProvider call({
    String startTime = '',
    String endTime = '',
  }) {
    return DashboardProvider(
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  DashboardProvider getProviderOverride(
    covariant DashboardProvider provider,
  ) {
    return call(
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
  String? get name => r'dashboardProvider';
}

/// See also [Dashboard].
class DashboardProvider
    extends AutoDisposeAsyncNotifierProviderImpl<Dashboard, DashboardModel> {
  /// See also [Dashboard].
  DashboardProvider({
    this.startTime = '',
    this.endTime = '',
  }) : super.internal(
          () => Dashboard()
            ..startTime = startTime
            ..endTime = endTime,
          from: dashboardProvider,
          name: r'dashboardProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dashboardHash,
          dependencies: DashboardFamily._dependencies,
          allTransitiveDependencies: DashboardFamily._allTransitiveDependencies,
        );

  final String startTime;
  final String endTime;

  @override
  bool operator ==(Object other) {
    return other is DashboardProvider &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, startTime.hashCode);
    hash = _SystemHash.combine(hash, endTime.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<DashboardModel> runNotifierBuild(
    covariant Dashboard notifier,
  ) {
    return notifier.build(
      startTime: startTime,
      endTime: endTime,
    );
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
