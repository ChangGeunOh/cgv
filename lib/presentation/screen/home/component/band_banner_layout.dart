import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/band_banner_data.dart';

class BandBannerLayout extends StatelessWidget {
  final VoidCallback onTap;
  final BandBannerData bandBannerData;

  const BandBannerLayout({
    required this.onTap,
    required this.bandBannerData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        color: Color(bandBannerData.color),
        child: CachedNetworkImage(
          imageUrl: bandBannerData.imgUrl,
        ),
      ),
    );
  }
}
