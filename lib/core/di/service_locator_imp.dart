import 'package:book_finder/core/http/dio_config.dart';
import 'package:book_finder/modules/details/domain/usecases/get_details_use_case.dart';
import 'package:book_finder/modules/details/infra/datasources/book_details_datasource.dart';
import 'package:book_finder/modules/discover_books/domain/services/connectivity_service.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/favourite_book_usecase.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/get_favourites_use_case.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/search_books_use_case.dart';
import 'package:book_finder/modules/discover_books/presenter/controllers/discover_books_controller.dart';
import 'package:get_it/get_it.dart';
import '../../modules/details/data/datasources/book_details_datasource.dart';
import '../../modules/details/domain/repositories/book_details_repository.dart';
import '../../modules/details/infra/repositories/book_details_repository.dart';
import '../../modules/discover_books/data/datasources/books_datasource.dart';
import '../../modules/discover_books/domain/repositories/book_repository.dart';
import '../../modules/discover_books/domain/usecases/remove_from_favourites_usecase.dart';
import '../../modules/discover_books/infra/datasources/books_datasource.dart';
import '../../modules/discover_books/infra/repositories/books_repository.dart';
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

    // repositories
    _getIt.registerFactory<BooksRepository>(() => BooksRepositoryImp(datasource: _getIt()));

    _getIt.registerFactory<BookDetailsRepository>(
        () => BookDetailsRepositoryImp(datasource: _getIt()));

    // usecase
    _getIt.registerFactory<SearchBooksUseCase>(() => SearchBooksUseCaseImp(
          repository: _getIt(),
          connectivityService: _getIt(),
        ));

    _getIt.registerFactory<GetDetailsUseCase>(() => GetDetailsUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<SaveFavoriteBookUseCase>(
        () => SaveFavoriteBookUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<RemoveFavouritesUseCase>(
        () => RemoveFavouritesUseCaseImp(repository: _getIt()));

    _getIt
        .registerFactory<GetFavouritesUseCase>(() => GetFavouritesUseCaseImp(repository: _getIt()));

    _getIt.registerSingleton<DiscoverBooksController>(DiscoverBooksController(
      searchBooksUseCase: _getIt(),
      getFavouritesUseCase: _getIt(),
      saveFavoriteBookUseCase: _getIt(),
      removeFromFavouritesUseCase: _getIt(),
    ));
  }

  @override
  T get<T extends Object>() => _getIt.get<T>();
}
