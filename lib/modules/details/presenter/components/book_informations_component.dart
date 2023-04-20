import 'package:flutter/material.dart';

import '../controllers/book_details_controller.dart';

class BookInformationsComponent extends StatelessWidget {
  final BookDetailsController controller;
  final String description;
  const BookInformationsComponent({
    super.key,
    required this.controller,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.bookDetails!.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
          height: 28,
        ),
        if (controller.bookDetails!.categories.isNotEmpty)
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.category,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.bookDetails!.categories.length > 3
                          ? 3
                          : controller.bookDetails!.categories.length,
                      itemBuilder: (context, index) {
                        return Text(
                          controller.bookDetails!.categories[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 02),
                    ),
                  ),
                ],
              ),
              Divider(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                height: 28,
              ),
            ],
          ),
        controller.getAuthores.isNotEmpty
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 20,
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Column(
                      children: [
                        Text(
                          controller.getAuthores,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : const SizedBox.shrink(),
        Divider(
          color: Theme.of(context).colorScheme.onSurface.withAlpha(110),
          height: 28,
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(
            fontSize: 16,
            color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
            height: 1.3,
          ),
        ),
      ],
    );
  }
}
