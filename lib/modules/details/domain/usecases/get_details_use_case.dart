import 'package:book_finder/modules/details/domain/entities/book_details_entity.dart';

import '../../../../core/commom/domain/result.dart';
import '../repositories/book_details_repository.dart';

abstract class GetDetailsUseCase {
  Future<Result<BookDetailsEntity>> call(String bookId);
}

class GetDetailsUseCaseImp implements GetDetailsUseCase {
  final BookDetailsRepository _repository;

  GetDetailsUseCaseImp({
    required BookDetailsRepository repository,
  }) : _repository = repository;

  @override
  Future<Result<BookDetailsEntity>> call(String bookId) => _repository.getBookDetails(bookId);
}
