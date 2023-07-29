import 'dart:convert';

import 'package:courier_merchent_app/domain/profile/get_area_model_response.dart';
import 'package:courier_merchent_app/utils/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart';

import '../../infrastructure/profile_repo.dart';
import '../global.dart';
import 'profile_state.dart';

// part 'profile_provider.g.dart';

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>(
  (ref) => ProfileNotifier(ref, ProfileRepo()),
  name: 'otherProblemProvider',
);

class ProfileNotifier extends StateNotifier<ProfileState> {
  final Ref ref;
  final ProfileRepo repo;
  ProfileNotifier(this.ref, this.repo) : super(ProfileState.init());

  Future<List<AreaModel>> getDistrict() async {
    final data = await repo.allDistrict();

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }

  Future<List<AreaModel>> getArea(String id) async {
    final data = await repo.allAreaByDistrict(id);

    return data.fold(
      (l) {
        showErrorToast(l.error.message);
        return [];
      },
      (r) => (r.data),
    );
  }
}

final futureProvider = FutureProvider<List<AreaModel>>((ref) async {
  final client = Client();
  final response = await client.get(
    Uri.parse(APIRoute.BASE_URL + APIRoute.ALL_DISTRICT),
  );
  final Map<String, dynamic> regResponse = jsonDecode(response.body);
  final List<AreaModel> areaModelList =
      GetAreaModelResponse.fromMap(regResponse).data;
  return areaModelList;
});

// @riverpod
// Future<List<AreaModel>> allDistrictProvider() async {
//   final data = await ProfileRepo().allDistrict();
//   return data.fold((l) => showErrorToast(l.error.message), (r) => r.data);
// }

final areaProvider = FutureProvider<List<AreaModel>>(
  (ref) async {
    final data = await ProfileRepo().allDistrict();

    return Future.value(data.fold(
      (l) {
        showErrorToast('categoriesProvider');
        return [];
      },
      (r) => (r.data),
    ));
  },
);
