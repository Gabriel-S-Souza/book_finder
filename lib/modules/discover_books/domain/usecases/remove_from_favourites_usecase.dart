import 'package:book_finder/modules/discover_books/domain/entities/book_entity.dart';

import '../../../../core/commom/domain/result.dart';
import '../repositories/book_repository.dart';

abstract class RemoveFavouritesUseCase {
  Future<Result<bool>> call(BookEntity book);
  Future<Result<bool>> removeAll();
}

class RemoveFavouritesUseCaseImp implements RemoveFavouritesUseCase {
  final BooksRepository _repository;

  RemoveFavouritesUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookEntity book) => _repository.removeFavourite(book.id);

  @override
  Future<Result<bool>> removeAll() => _repository.removeAllFavourites();
}
