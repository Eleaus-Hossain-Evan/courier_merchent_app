import 'package:courier_merchent_app/presentation/parcel/widgets/event_card.dart';
import 'package:courier_merchent_app/presentation/widgets/widgets.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/parcel/parcel_provider.dart';
import '../../utils/utils.dart';

class ParcelDetailScreen extends HookConsumerWidget {
  static const route = '/parcel-detail';

  final String parcelId;
  const ParcelDetailScreen({
    super.key,
    required this.parcelId,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parcel = ref.watch(singleParcelProvider(parcelId));

    final scaffoldKey = useMemoized<GlobalKey<ScaffoldState>>(GlobalKey.new);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: const Drawer(),
      appBar: const KAppBar(titleText: 'TRACK PARCEL'),
      body: parcel.when(
        data: (data) {
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
                        : null,
                  ),
                  onTap: () {},
                ),
              )
              .toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                Text.rich('Tracking ID: '.textSpan.withChildren([
                  data.serialId.textSpan
                      .color(ColorPalate.black600)
                      .semiBold
                      .make(),
                ]).make())
                    .p16(),
                KExpansionTile(
                  title: "Reguler Status log".text.make(),
                  initiallyExpanded: true,
                  children: [
                    Timeline(
                      children: items,
                      iconSize: 14.sp,
                      position: TimelinePosition.Left,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ).p12()
                  ],
                ),
              ],
            ),
          );
        },
        // data: (data) => const ParcelDetailShimmer(),
        error: (error, stackTrace) => error.toString().text.make(),
        loading: () => const ParcelDetailShimmer(),
      ),
    );
  }
}

class ParcelDetailShimmer extends StatelessWidget {
  const ParcelDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return VxShimmer(
      primaryColor: Colors.grey.shade300,
      secondaryColor: Colors.grey.shade100,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              children: [
                VxSkeleton(
                  height: 120.h,
                  width: .3.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                gap16,
                Column(
                  children: [
                    VxSkeleton(
                      height: 50.h,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    gap16,
                    VxSkeleton(
                      height: 50.h,
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ],
                ).expand(),
              ],
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
              ],
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  width: .2.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
              ],
            ),
            gap16,
            Row(
              children: [
                VxSkeleton(
                  height: 50.h,
                  width: .2.sw,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                gap16,
                VxSkeleton(
                  height: 50.h,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                ).flexible(),
              ],
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            gap16,
            VxSkeleton(
              height: 50.h,
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ],
        ),
      ),
    );
  }
}
