import 'package:flutter/material.dart';

class TabBarComponent extends StatelessWidget {
  final void Function(int)? onTap;
  final TabController controller;
  final List<String> tabTitles;
  const TabBarComponent({
    super.key,
    required this.onTap,
    required this.controller,
    required this.tabTitles,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      onTap: onTap,
      indicatorColor: Theme.of(context).colorScheme.primaryContainer.withAlpha(180),
      tabs: tabTitles
          .map(
            (title) => Tab(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: controller.index == tabTitles.indexOf(title)
                      ? Theme.of(context).colorScheme.primaryContainer.withAlpha(180)
                      : Theme.of(context).textTheme.labelSmall!.color?.withAlpha(150) ??
                          Colors.grey,
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
