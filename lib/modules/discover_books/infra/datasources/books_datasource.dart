import 'package:book_finder/modules/discover_books/data/models/book_model.dart';

import '../../../../core/commom/domain/result.dart';
import '../../domain/entities/book_entity.dart';

abstract class BooksDatasource {
  Future<Result<List<BookModel>>> searchBooks(String query);
  Future<Result<List<BookModel>>> searchBooksLocally(String query);
  Future<Result<List<BookModel>>> getfavorites();
  Future<Result<bool>> savefavorite(BookEntity book);
  Future<Result<bool>> removefavorite(String bookId);
  Future<Result<bool>> removeAllfavorites();
}
