import '../../../../core/commom/domain/result.dart';
import '../entities/book_details_entity.dart';
import '../repositories/book_details_repository.dart';

abstract class RemovefavoriteFromDetailsUseCase {
  Future<Result<bool>> call(BookDetailsEntity book);
}

class RemovefavoriteFromDetailsUseCaseImp implements RemovefavoriteFromDetailsUseCase {
  final BookDetailsRepository _repository;

  RemovefavoriteFromDetailsUseCaseImp({
    required BookDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookDetailsEntity book) => _repository.removefavorite(book.id);
}
