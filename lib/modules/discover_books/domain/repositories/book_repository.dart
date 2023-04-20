import 'package:book_finder/modules/discover_books/data/models/book_model.dart';

import '../../../../core/commom/domain/result.dart';
import '../entities/book_entity.dart';

abstract class BooksRepository {
  Future<Result<List<BookModel>>> searchBooks(List<String> query);
  Future<Result<List<BookModel>>> searchBooksLocally(List<String> query);
  Future<Result<List<BookModel>>> getFavourites();
  Future<Result<bool>> saveFavourite(BookEntity book);
  Future<Result<bool>> removeFavourite(String bookId);
  Future<Result<bool>> removeAllFavourites();
}
