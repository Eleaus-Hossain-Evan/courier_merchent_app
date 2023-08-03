import 'package:courier_merchent_app/application/profile/profile_provider.dart';
import 'package:courier_merchent_app/utils/strings.dart';
import 'package:courier_merchent_app/utils/ui_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../domain/profile/get_area_model_response.dart';
import '../profile/pages/edit_profile/widgets/profile_section.dart';
import '../widgets/widgets.dart';

class AddParcelScreen extends HookConsumerWidget {
  static const route = '/add-parcel';

  const AddParcelScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final phoneController = useTextEditingController();
    final addressController = useTextEditingController();

    final selectedDistrict = useState<AreaModel?>(null);
    return Scaffold(
      appBar: const KAppBar(
        titleText: 'Create New Parcel',
      ),
      body: SingleChildScrollView(
        padding: padding16,
        child: Column(
          crossAxisAlignment: crossStart,
          children: [
            "Customer Information".text.lg.bold.make(),
            gap16,
            KTextFormField2(
              hintText: AppStrings.name,
              controller: nameController,
              containerPadding: padding0,
            ),
            gap16,
            KTextFormField2(
              hintText: AppStrings.phoneNumber,
              controller: phoneController,
              containerPadding: padding0,
            ),
            gap36,
            "Address Information".text.lg.bold.make(),
            gap16,
            KTextFormField2(
              hintText: AppStrings.address,
              controller: addressController,
              containerPadding: padding0,
            ),
            gap16,
            ProfileSection(
              title: AppStrings.pickupStyle,
              containerPadding: paddingV20,
              child: KDropDownSearchWidget<AreaModel>(
                hintText: "Select District",
                selectedItem: selectedDistrict.value,
                asyncItems: (p0) =>
                    ref.read(profileProvider.notifier).getDistrict(),
                itemAsString: (p0) => p0.name.capitalized,
                compareFn: (p0, p1) => identical(p0.name, p0.name),
                onChanged: (value) {
                  selectedDistrict.value = value!;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
