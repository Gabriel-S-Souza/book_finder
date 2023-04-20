import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';
import '../repositories/book_repository.dart';

abstract class GetfavoritesUseCase {
  Future<Result<List<BookEntity>>> call();
}

class GetfavoritesUseCaseImp implements GetfavoritesUseCase {
  final BooksRepository _repository;

  GetfavoritesUseCaseImp({
    required BooksRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<List<BookEntity>>> call() => _repository.getfavorites();
}
