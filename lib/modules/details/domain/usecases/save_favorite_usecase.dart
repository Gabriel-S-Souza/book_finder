import '../../../../core/commom/domain/result.dart';
import '../entities/book_details_entity.dart';
import '../repositories/book_details_repository.dart';

abstract class SaveFavoriteFromDetailsUseCase {
  Future<Result<bool>> call(BookDetailsEntity book);
}

class SaveFavoriteFromDetailsUseCaseImp implements SaveFavoriteFromDetailsUseCase {
  final BookDetailsRepository _repository;

  SaveFavoriteFromDetailsUseCaseImp({
    required BookDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<bool>> call(BookDetailsEntity book) async {
    return _repository.savefavorite(book);
  }
}
