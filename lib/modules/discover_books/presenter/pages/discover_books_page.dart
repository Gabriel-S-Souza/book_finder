import 'package:book_finder/core/di/service_locator_imp.dart';
import 'package:book_finder/modules/details/presenter/pages/book_details_page.dart';
import 'package:book_finder/modules/discover_books/presenter/components/drawer_discover_component.dart';
import 'package:book_finder/modules/discover_books/presenter/components/grid_books_component.dart';
import 'package:book_finder/modules/discover_books/presenter/controllers/discover_books_controller.dart';
import 'package:flutter/material.dart';

import '../../../../core/commom/presenter/widgets/loading_widget.dart';
import '../../../../locale_service.dart';
import '../components/search_bar_component.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/no_books_to_show_widget.dart';

class DiscoverBooksPage extends StatefulWidget {
  const DiscoverBooksPage({super.key});

  @override
  State<DiscoverBooksPage> createState() => _DiscoverBooksPageState();
}

class _DiscoverBooksPageState extends State<DiscoverBooksPage> with TickerProviderStateMixin {
  final _controller = ServiceLocatorImp.I.get<DiscoverBooksController>();
  final _localController = ServiceLocatorImp.I.get<LocaleService>();
  late final TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  AppLocalizations get t => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          appBar: SearchBarComponent(
            onSearch: (value) {
              _controller.searchBooks(value);
              _tabController.animateTo(0);
            },
            onMenuPressed: () {
              _scaffoldKey.currentState!.openDrawer();
            },
          ),
          drawer: DrawerDiscoverComponent(
            onLanguageChanged: _localController.set,
            currentLocale: _localController.localeEnum,
          ),
          body: AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                return Column(
                  children: [
                    TabBar(
                      controller: _tabController,
                      onTap: (index) {
                        bool showfavorites = index == 1;
                        _tabController.animateTo(showfavorites ? 1 : 0);
                        _controller.setTabIsfavorites(showfavorites);
                      },
                      tabs: [
                        Tab(
                          text: t.all,
                        ),
                        Tab(
                          text: t.favorites,
                        ),
                      ],
                    ),
                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (_controller.isLoading) {
                            return const LoadingWidget();
                          }
                          if (_controller.booksToShow.isEmpty) {
                            return const NoBooksToShowWidget();
                          }

                          return GridBooksComponent(
                            books: _controller.booksToShow,
                            togglefavorite: _controller.togglefavoriteBook,
                            onTap: (book) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetailsPage(bookEntity: book),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
