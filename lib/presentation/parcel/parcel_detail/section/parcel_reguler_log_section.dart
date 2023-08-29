import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../domain/parcel/model/parcel_model.dart';
import '../../../../utils/utils.dart';
import '../../../widgets/widgets.dart';
import '../../widgets/event_card.dart';

class ParcelRegularLodSection extends StatelessWidget {
  const ParcelRegularLodSection({
    super.key,
    required this.data,
  });

  final ParcelModel data;

  @override
  Widget build(BuildContext context) {
    List<TimelineModel> items = data.regularStatusLogs
        .mapIndexed(
          (currentValue, index) => TimelineModel(
            EventCard(
              title: currentValue.time,
              subTitle: currentValue.log,
              isPast: data.regularStatusLogs.isLast(currentValue),
            ),
            position: TimelineItemPosition.left,
            iconBackground: data.regularStatusLogs.isLast(currentValue)
                ? context.colors.primary.withOpacity(.2)
                : context.colors.primary,
            icon: Icon(
              Icons.check,
              color: data.regularStatusLogs.isLast(currentValue)
                  ? context.colors.primary.withOpacity(.05)
                  : context.theme.scaffoldBackgroundColor,
            ),
            onTap: () {},
          ),
        )
        .toList();
    return ContainerBGWhiteSlideFromTop(
      bgColor: ColorPalate.bg100,
      padding: padding0,
      borderRadius: radius6,
      child: ExpansionTile(
        title: "Regular Status log".text.make(),
        initiallyExpanded: true,
        shape: Border.all(color: Colors.transparent),
        children: [
          Timeline(
            children: items,
            iconSize: 12.sp,
            position: TimelinePosition.Left,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ).p12()
        ],
      ),
    );
  }
}
