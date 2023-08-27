import 'package:flutter/material.dart';

class KShimmerContainer extends StatelessWidget {
  const KShimmerContainer({
    Key? key,
    this.height,
    this.width,
  }) : super(key: key);
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const ListTile(),
    );
  }
}
