import 'dart:convert';

import 'package:equatable/equatable.dart';

class ParcelState extends Equatable {
  final bool loading;
  const ParcelState({
    required this.loading,
  });

  factory ParcelState.init() => const ParcelState(loading: false);

  ParcelState copyWith({
    bool? loading,
  }) {
    return ParcelState(
      loading: loading ?? this.loading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'loading': loading,
    };
  }

  factory ParcelState.fromMap(Map<String, dynamic> map) {
    return ParcelState(
      loading: map['loading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParcelState.fromJson(String source) =>
      ParcelState.fromMap(json.decode(source));

  @override
  String toString() => 'ParcelState(loading: $loading)';

  @override
  List<Object> get props => [loading];
}
