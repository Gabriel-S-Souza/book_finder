import '../../../../core/commom/domain/result.dart';
import '../repositories/book_repository.dart';

abstract class RemoveFavouritesUseCase {
  Future<Result<bool>> call(String bookId);
  Future<Result<bool>> removeAll();
}

class RemoveFavouritesUseCaseImp implements RemoveFavouritesUseCase {
  final BooksRepository _repository;

  RemoveFavouritesUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(String bookId) => _repository.removeFavourite(bookId);

  @override
  Future<Result<bool>> removeAll() => _repository.removeAllFavourites();
}
