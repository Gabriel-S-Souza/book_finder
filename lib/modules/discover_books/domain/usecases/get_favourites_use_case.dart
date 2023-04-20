import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

abstract class GetFavouritesUseCase {
  Future<Result<List<BookEntity>>> call();
}

class GetFavouritesUseCaseImp implements GetFavouritesUseCase {
  final BooksRepository _repository;

  GetFavouritesUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<List<BookEntity>>> call() => _repository.getFavourites();
}
