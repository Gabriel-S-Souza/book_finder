import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';
import 'package:book_finder/modules/discover_books/domain/repositories/book_repository.dart';
import 'package:book_finder/core/commom/domain/services/connectivity_service.dart';

import '../../../../core/commom/domain/result.dart';

abstract class SearchBooksUseCase {
  Future<Result<List<BookEntity>>> call(String query);
}

class SearchBooksUseCaseImp implements SearchBooksUseCase {
  final BooksRepository _repository;
  final ConnectivityService _connectivityService;

  SearchBooksUseCaseImp({
    required BooksRepository repository,
    required ConnectivityService connectivityService,
  })  : _repository = repository,
        _connectivityService = connectivityService;

  @override
  Future<Result<List<BookEntity>>> call(String query) async {
    final hasConnection = await _connectivityService.hasConnection;
    if (hasConnection) {
      return _repository.searchBooks(query);
    } else {
      return _repository.searchBooksLocally(query);
    }
  }
}
