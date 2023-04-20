import 'package:book_finder/modules/discover_books/domain/services/connectivity_service.dart';

import '../../../../core/commom/domain/result.dart';
import '../../data/models/book_model.dart';
import '../../infra/datasources/search_books_datasource.dart';

abstract class SearchBooksUseCase {
  Future<Result<List<BookModel>>> call(List<String> query);
}

class SearchBooksUseCaseImp implements SearchBooksUseCase {
  final BooksDatasource _datasource;
  final ConnectivityService _connectivityService;

  SearchBooksUseCaseImp({
    required BooksDatasource datasource,
    required ConnectivityService connectivityService,
  })  : _datasource = datasource,
        _connectivityService = connectivityService;

  @override
  Future<Result<List<BookModel>>> call(List<String> query) async {
    final hasConnection = await _connectivityService.hasConnection;
    if (hasConnection) {
      return _datasource.searchBooks(query);
    } else {
      return _datasource.searchBooksLocally(query);
    }
  }
}
