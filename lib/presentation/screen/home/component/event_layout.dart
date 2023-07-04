import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../domain/model/function_menu_data.dart';
import 'full_view_button.dart';


class EventLayout extends StatelessWidget {
  final List<FunctionMenuData> eventList;

  const EventLayout({
    required this.eventList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      child: Column(
        children: [
          EventTitle(
            onFullView: () {},
          ),
          ...eventList
              .map(
                (e) => CachedNetworkImage(imageUrl: e.imgUrl),
          )
              .toList()
        ],
      ),
    );
  }
}

class EventTitle extends StatelessWidget {
  final VoidCallback onFullView;

  const EventTitle({
    required this.onFullView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Event',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Spacer(),
        FullViewButton(onTap: () {}),
      ],
    );
  }
}
