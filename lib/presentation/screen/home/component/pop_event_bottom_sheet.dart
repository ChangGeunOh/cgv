import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/card_data.dart';

class PopEventBottomSheet extends StatelessWidget {
  final ValueChanged onTapEvent;
  final ValueChanged onTapToday;
  final VoidCallback onTapClose;
  final CardData? popEventData;
  final bool isNoToday;
  final List<CardData>? popEventList;

  const PopEventBottomSheet({
    this.popEventData,
    this.popEventList,
    required this.isNoToday,
    required this.onTapEvent,
    required this.onTapClose,
    required this.onTapToday,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xc0000000),
      child: Column(
        children: [
          const Spacer(),
          Container(
            height: 475,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30),
              child: Column(
                children: [
                  if (popEventData != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CachedNetworkImage(
                        imageUrl: popEventData!.imgUrl,
                      ),
                    ),
                  const SizedBox(height: 8),
                  if (popEventList != null)
                    SizedBox(
                      height: 252,
                      width: double.infinity,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: popEventList!
                            .mapIndexed(
                              (index, e) => Padding(
                                padding:
                                    EdgeInsets.only(left: index == 0 ? 30 : 10),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4)),
                                  child: InkWell(
                                    onTap: () => onTapEvent(e),
                                    child: CachedNetworkImage(
                                      imageUrl: e.imgUrl,
                                      width: 334,
                                      height: 252,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 30),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isNoToday,
                          onChanged: (value) => onTapToday(value!),
                        ),
                        const Text(
                          '오늘은 그만 보기',
                          style: TextStyle(
                            fontWeight: FontWeight.w200,
                            fontSize: 13,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: onTapClose,
                          child: const Text(
                            '닫기',
                            style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
