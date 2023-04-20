import 'package:book_finder/modules/discover_books/infra/datasources/search_books_datasource.dart';

import '../../../../core/commom/domain/result.dart';

abstract class RemoveFavouritesUseCase {
  Future<Result<bool>> call(String bookId);
  Future<Result<bool>> removeAll();
}

class RemoveFavouritesUseCaseImp implements RemoveFavouritesUseCase {
  final BooksDatasource _datasource;

  RemoveFavouritesUseCaseImp({
    required BooksDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Result<bool>> call(String bookId) => _datasource.removeFavourite(bookId);

  @override
  Future<Result<bool>> removeAll() => _datasource.removeAllFavourites();
}
