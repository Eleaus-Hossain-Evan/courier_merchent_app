import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_merchent_app/presentation/parcel/widgets/event_card.dart';

import '../../../domain/parcel/model/parcel_model.dart';

class MyTimeLineTile extends StatelessWidget {
  const MyTimeLineTile({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.log,
    required this.onTap,
  }) : super(key: key);

  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final StatusLog log;
  final void Function(StatusLog) onTap;

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      alignment: TimelineAlign.manual,
      isFirst: isFirst,
      isLast: isLast,
      lineXY: 0.1,
      beforeLineStyle: LineStyle(
          color: isPast
              ? context.colors.primary.withOpacity(.4)
              : context.colors.primary.withOpacity(.1)),
      indicatorStyle: IndicatorStyle(
        color: isPast
            ? context.colors.primary
            : context.colors.primary.withOpacity(.5),
        iconStyle: IconStyle(
          iconData: Icons.check,
          fontSize: 12.sp,
          color: isPast ? Colors.white : context.colors.primary.withOpacity(.4),
        ),
        drawGap: true,
      ),
      endChild: Container(
        constraints: const BoxConstraints(
          minHeight: 120,
        ),
        child: EventCard(
          isPast: isPast,
          title: log.time,
          subTitle: log.log,
          onTap: () {
            onTap.call(log);
          },
        ),
      ),
    );
  }
}

class TimelineDelivery extends StatelessWidget {
  const TimelineDelivery({
    Key? key,
    required this.data,
  }) : super(key: key);

  final List<StatusLog> data;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ...data
              .mapIndexed(
                (currentValue, index) => TimelineTile(
                  alignment: TimelineAlign.manual,
                  lineXY: 0.1,
                  isFirst: true,
                  indicatorStyle: const IndicatorStyle(
                    width: 20,
                    color: Color(0xFF27AA69),
                    padding: EdgeInsets.all(6),
                  ),
                  endChild: EventCard(
                    isPast: data.lock.isFirst(currentValue),
                    title: currentValue.time,
                    subTitle: currentValue.log,
                    onTap: () {
                      // onTap.call(currentValue);
                    },
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Color(0xFF27AA69),
                  ),
                ),
              )
              .toList(),
          // TimelineTile(
          //   alignment: TimelineAlign.manual,
          //   lineXY: 0.1,
          //   isFirst: true,
          //   indicatorStyle: const IndicatorStyle(
          //     width: 20,
          //     color: Color(0xFF27AA69),
          //     padding: EdgeInsets.all(6),
          //   ),
          //   endChild: EventCard(
          //     isPast: isPast,
          //     title: log.time,
          //     subTitle: log.log,
          //     onTap: () {
          //       onTap.call(log);
          //     },
          //   ),
          //   beforeLineStyle: const LineStyle(
          //     color: Color(0xFF27AA69),
          //   ),
          // ),
        ],
      ),
    );
  }
}
