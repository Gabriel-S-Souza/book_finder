import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';

import '../../../../core/commom/domain/result.dart';
import '../repositories/book_repository.dart';

abstract class RemovefavoritesUseCase {
  Future<Result<bool>> call(BookEntity book);
  Future<Result<bool>> removeAll();
}

class RemovefavoritesUseCaseImp implements RemovefavoritesUseCase {
  final BooksRepository _repository;

  RemovefavoritesUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookEntity book) => _repository.removefavorite(book.id);

  @override
  Future<Result<bool>> removeAll() => _repository.removeAllfavorites();
}
