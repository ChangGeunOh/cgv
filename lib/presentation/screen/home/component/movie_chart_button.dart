import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';

class MovieChartButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool isSelected;

  const MovieChartButton({
    required this.title,
    required this.onTap,
    bool? isSelected,
    super.key,
  }) : isSelected = isSelected ?? false;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'NotoSansKR',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isSelected ? textColor : deselectTextColor,
        ),
      ),
    );
  }
}
