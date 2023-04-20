import 'package:book_finder/core/commom/domain/failure.dart';
import 'package:book_finder/modules/details/domain/entities/book_details_entity.dart';

import '../../../../core/commom/domain/result.dart';
import '../../../../core/commom/domain/services/connectivity_service.dart';
import '../repositories/book_details_repository.dart';

abstract class GetDetailsUseCase {
  Future<Result<BookDetailsEntity>> call(String bookId);
}

class GetDetailsUseCaseImp implements GetDetailsUseCase {
  final BookDetailsRepository _repository;
  final ConnectivityService _connectivityService;

  GetDetailsUseCaseImp({
    required BookDetailsRepository repository,
    required ConnectivityService connectivityService,
  })  : _repository = repository,
        _connectivityService = connectivityService;

  @override
  Future<Result<BookDetailsEntity>> call(String bookId) async {
    final hasConnection = await _connectivityService.hasConnection;
    if (hasConnection) {
      return _repository.getBookDetails(bookId);
    } else {
      return Result.failure(OfflineFailure());
    }
  }
}
