import 'package:book_finder/modules/discover_books/data/models/book_model.dart';

import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';

abstract class BooksRepository {
  Future<Result<List<BookModel>>> searchBooks(String query);
  Future<Result<List<BookModel>>> searchBooksLocally(String query);
  Future<Result<List<BookModel>>> getfavorites();
  Future<Result<bool>> savefavorite(BookEntity book);
  Future<Result<bool>> removefavorite(String bookId);
  Future<Result<bool>> removeAllfavorites();
}
