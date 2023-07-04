import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import '../../../../common/const/color.dart';

class UnderLineButtonLayout extends StatelessWidget {
  final List<String> underLineMenuList;
  final ValueChanged onTap;
  final int index;

  const UnderLineButtonLayout({
    required this.underLineMenuList,
    required this.onTap,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Stack(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Divider(
              color: Color(0xFFf2f2f2),
              thickness: 1,
            ),
          ),
          SizedBox(
            width: double.infinity,
            height: 29,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return UnderLineButton(
                  title: underLineMenuList[index],
                  isSelected: index == this.index,
                  onTap: () {
                    print('underlinebuttn>$index');
                    onTap(index);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 12);
              },
              itemCount: underLineMenuList.length,
            ),
          ),
        ],
      ),
    );
  }
}

class UnderLineButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isSelected;

  const UnderLineButton({
    required this.onTap,
    required this.title,
    this.isSelected = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fontStyle = TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: isSelected ? selectTextColor : deselectTextColor,
    );
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: title,
        style: fontStyle,
      ),
      textDirection: ui.TextDirection.ltr,
    )..layout();

    final textWidth = textPainter.width;
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            title,
            style: fontStyle,
          ),
          const SizedBox(height: 6),
          Container(
            color: isSelected ? selectTextColor : Colors.transparent,
            width: textWidth + 12,
            height: 1,
          ),
        ],
      ),
    );
  }
}
