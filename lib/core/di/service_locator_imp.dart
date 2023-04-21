import 'package:book_finder/core/http/dio_config.dart';
import 'package:book_finder/locale_service.dart';
import 'package:book_finder/modules/details/domain/usecases/get_details_use_case.dart';
import 'package:book_finder/modules/details/infra/datasources/book_details_datasource.dart';
import 'package:book_finder/modules/details/presenter/controllers/book_details_controller.dart';
import 'package:book_finder/core/commom/domain/services/connectivity_service.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/save_favorite_usecase.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/get_favorites_use_case.dart';
import 'package:book_finder/modules/discover_books/domain/usecases/search_books_use_case.dart';
import 'package:book_finder/modules/discover_books/presenter/controllers/discover_books_controller.dart';
import 'package:get_it/get_it.dart';
import '../../modules/details/data/datasources/book_details_datasource.dart';
import '../../modules/details/domain/repositories/book_details_repository.dart';
import '../../modules/details/infra/repositories/book_details_repository.dart';
import '../../modules/discover_books/data/datasources/books_datasource.dart';
import '../../modules/discover_books/domain/repositories/book_repository.dart';
import '../../modules/discover_books/domain/usecases/remove_favorite_usecase.dart';
import '../../modules/details/domain/usecases/remove_favorite_from_details_usecase.dart';
import '../../modules/details/domain/usecases/save_favorite_usecase.dart';
import '../../modules/discover_books/infra/datasources/books_datasource.dart';
import '../../modules/discover_books/infra/repositories/books_repository.dart';
import '../commom/data/local_storage.dart';
import '../commom/infra/datasources/local_storage.dart';
import '../commom/infra/services/connectivity_service.dart';
import '../http/http_client.dart';
import 'service_locator.dart';

class ServiceLocatorImp implements ServiceLocator {
  ServiceLocatorImp._internal();
  static final I = ServiceLocatorImp._internal();

  final _getIt = GetIt.instance;

  @override
  void setupLocator() async {
    // locale
    _getIt.registerSingleton<LocaleService>(LocaleService());

    // http
    _getIt.registerFactory<HttpClient>(() => HttpClient(dioApp));

    // datasources
    _getIt.registerSingleton<LocalStorage>(LocalStorageImp());

    _getIt.registerFactory<BooksDatasource>(() => BooksDatasourceImp(
          httpClient: _getIt(),
          localStorage: _getIt(),
          localeService: _getIt(),
        ));

    _getIt.registerFactory<BookDetailsDatasource>(() => BookDetailsDatasourceImp(
          httpClient: _getIt(),
          localStorage: _getIt(),
        ));

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

    _getIt.registerFactory<SaveFavoriteBookUseCase>(
        () => SaveFavoriteBookUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<RemovefavoritesUseCase>(
        () => RemovefavoritesUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<GetfavoritesUseCase>(() => GetfavoritesUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<GetDetailsUseCase>(() => GetDetailsUseCaseImp(
          repository: _getIt(),
          connectivityService: _getIt(),
        ));

    _getIt.registerFactory<SaveFavoriteFromDetailsUseCase>(
        () => SaveFavoriteFromDetailsUseCaseImp(repository: _getIt()));

    _getIt.registerFactory<RemovefavoriteFromDetailsUseCase>(
        () => RemovefavoriteFromDetailsUseCaseImp(repository: _getIt()));

    // controllers
    _getIt.registerSingleton<DiscoverBooksController>(
      DiscoverBooksController(
        searchBooksUseCase: _getIt(),
        getfavoritesUseCase: _getIt(),
        saveFavoriteBookUseCase: _getIt(),
        removeFromfavoritesUseCase: _getIt(),
      ),
    );

    _getIt.registerSingleton<BookDetailsController>(
      BookDetailsController(
        getDetailsUseCase: _getIt(),
        saveFavoriteBookUseCase: _getIt(),
        removeFromfavoritesUseCase: _getIt(),
      ),
    );
  }

  @override
  T get<T extends Object>() => _getIt.get<T>();

  @override
  void registerFactory<T extends Object>(T Function() factory) {
    _getIt.registerFactory<T>(factory);
  }

  @override
  void registerSingleton<T extends Object>(T instance) {
    _getIt.registerSingleton<T>(instance);
  }
}
