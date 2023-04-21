import 'package:book_finder/modules/discover_books/presenter/widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchBarComponent extends StatelessWidget implements PreferredSizeWidget {
  final void Function(String)? onSearch;
  final VoidCallback? onMenuPressed;

  SearchBarComponent({
    Key? key,
    this.onSearch,
    this.onMenuPressed,
  }) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  AppLocalizations t(BuildContext context) => AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(-4, 0),
            child: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: onMenuPressed,
            ),
          ),
          Expanded(
            child: TextFieldWidget(
              hint: t(context).searchPlaceholder,
              controller: _controller,
              onSubmitted: (value) {
                FocusScope.of(context).unfocus();
                if (value.isNotEmpty) {
                  onSearch?.call(value);
                }
              },
              prefix: const Icon(Icons.search),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                FocusScope.of(context).unfocus();
                onSearch?.call(_controller.text);
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
