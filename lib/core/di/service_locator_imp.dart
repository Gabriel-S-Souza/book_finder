import 'package:book_finder/core/http/dio_config.dart';
import 'package:book_finder/modules/details/infra/datasources/book_details_datasource.dart';
import 'package:book_finder/modules/discover_books/domain/services/connectivity_service.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/favourite_book_usecase.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/get_favourites_use_case.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/search_books_use_case.dart';
import 'package:get_it/get_it.dart';
import '../../modules/details/data/datasources/book_details_datasource.dart';
import '../../modules/discover_books/data/datasources/books_datasource.dart';
import '../../modules/discover_books/domain/usecases/remove_from_favourites_usecase.dart';
import '../../modules/discover_books/infra/datasources/search_books_datasource.dart';
import '../../modules/discover_books/infra/services/connectivity_service.dart';
import '../commom/data/local_storage.dart';
import '../commom/infra/local_storage.dart';
import '../http/http_client.dart';
import 'service_locator.dart';

class ServiceLocatorImp implements ServiceLocator {
  ServiceLocatorImp._internal();
  static final I = ServiceLocatorImp._internal();

  final _getIt = GetIt.instance;

  @override
  void setupLocator() async {
    // http
    _getIt.registerFactory<HttpClient>(() => HttpClient(dioApp));

    // datasources
    _getIt.registerSingleton<LocalStorage>(LocalStorageImp());

    _getIt.registerFactory<BooksDatasource>(() => BooksDatasourceImp(
          httpClient: _getIt(),
          localStorage: _getIt(),
        ));

    _getIt.registerFactory<BookDetailsDatasource>(() => BookDetailsDatasourceImp(_getIt()));

    // services
    _getIt.registerFactory<ConnectivityService>(() => ConnectivityServiceImp());

    // usecase
    _getIt.registerFactory<SearchBooksUseCase>(() => SearchBooksUseCaseImp(
          datasource: _getIt(),
          connectivityService: _getIt(),
        ));

    _getIt.registerFactory<SaveFavoriteBookUseCase>(
        () => SaveFavoriteBookUseCaseImp(datasource: _getIt()));

    _getIt.registerFactory<RemoveFavouritesUseCase>(
        () => RemoveFavouritesUseCaseImp(datasource: _getIt()));

    _getIt
        .registerFactory<GetFavouritesUseCase>(() => GetFavouritesUseCaseImp(datasource: _getIt()));

    // // controller
    // _getIt.registerLazySingleton<LoginController>(
    //   () => LoginController(loginUseCase: _getIt()),
    // );
  }

  @override
  T get<T extends Object>() => _getIt.get<T>();
}
