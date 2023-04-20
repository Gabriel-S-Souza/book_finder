import '../../../../core/commom/domain/result.dart';
import '../../infra/datasources/search_books_datasource.dart';
import '../entities/book_entity.dart';

abstract class GetFavouritesUseCase {
  Future<Result<List<BookEntity>>> call();
}

class GetFavouritesUseCaseImp implements GetFavouritesUseCase {
  final BooksDatasource _datasource;

  GetFavouritesUseCaseImp({
    required BooksDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Result<List<BookEntity>>> call() async {
    return _datasource.getFavourites();
  }
}
