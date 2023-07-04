import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';

class FullViewButton extends StatelessWidget {
  final VoidCallback onTap;

  const FullViewButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '전체보기',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
                color: kFullViewTextColor,
              ),
            ),
            Icon(
              Icons.chevron_right,
              size: 13,
              color: kFullViewIconColor,
            ),
          ],
      ),
    );
  }
}
