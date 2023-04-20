import '../../../../core/commom/domain/result.dart';
import '../entities/book_details_entity.dart';
import '../repositories/book_details_repository.dart';

abstract class RemoveFavouriteFromDetailsUseCase {
  Future<Result<bool>> call(BookDetailsEntity book);
}

class RemoveFavouriteFromDetailsUseCaseImp implements RemoveFavouriteFromDetailsUseCase {
  final BookDetailsRepository _repository;

  RemoveFavouriteFromDetailsUseCaseImp({
    required BookDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookDetailsEntity book) => _repository.removeFavourite(book.id);
}
