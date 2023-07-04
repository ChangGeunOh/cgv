import 'package:flutter/material.dart';

class SliverSizedBox extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const SliverSizedBox({
    this.height,
    this.width,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
