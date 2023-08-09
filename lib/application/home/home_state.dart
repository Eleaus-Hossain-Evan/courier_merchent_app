import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/src/ilist/ilist.dart';

import 'package:courier_merchent_app/domain/home/model/home_data.dart';
import 'package:courier_merchent_app/domain/parcel/model/parcel_model.dart';

class HomeState extends Equatable {
  final bool loading;
  final HomeData homeData;
  final IList<ParcelModel> parcelList;

  const HomeState({
    required this.loading,
    required this.homeData,
    required this.parcelList,
  });

  factory HomeState.init() => HomeState(
        loading: false,
        homeData: HomeData.init(),
        parcelList: const IListConst([]),
      );

  HomeState copyWith({
    bool? loading,
    HomeData? homeData,
    IList<ParcelModel>? parcelList,
  }) {
    return HomeState(
      loading: loading ?? this.loading,
      homeData: homeData ?? this.homeData,
      parcelList: parcelList ?? this.parcelList,
    );
  }

  @override
  String toString() =>
      'HomeState(loading: $loading, homeData: $homeData, parcelList: $parcelList)';

  @override
  List<Object> get props => [loading, homeData, parcelList];
}
