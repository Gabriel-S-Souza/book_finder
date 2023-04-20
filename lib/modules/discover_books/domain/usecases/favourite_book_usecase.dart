import 'package:book_finder/modules/discover_books/infra/datasources/search_books_datasource.dart';

import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';

abstract class SaveFavoriteBookUseCase {
  Future<Result<bool>> call(BookEntity book);
}

class SaveFavoriteBookUseCaseImp implements SaveFavoriteBookUseCase {
  final BooksDatasource _datasource;

  SaveFavoriteBookUseCaseImp({
    required BooksDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Result<bool>> call(BookEntity book) async {
    return _datasource.saveFavourite(book);
  }
}
