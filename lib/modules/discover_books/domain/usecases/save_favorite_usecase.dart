import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

abstract class SaveFavoriteBookUseCase {
  Future<Result<bool>> call(BookEntity book);
}

class SaveFavoriteBookUseCaseImp implements SaveFavoriteBookUseCase {
  final BooksRepository _repository;

  SaveFavoriteBookUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookEntity book) async {
    return _repository.savefavorite(book);
  }
}
