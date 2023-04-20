import '../../../../core/commom/domain/result.dart';
import '../../data/models/book_model.dart';
import '../../domain/entities/book_entity.dart';
import '../../domain/repositories/book_repository.dart';
import '../datasources/books_datasource.dart';

class BooksRepositoryImp implements BooksRepository {
  final BooksDatasource _datasource;

  BooksRepositoryImp({
    required BooksDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Result<List<BookModel>>> getFavourites() => _datasource.getFavourites();

  @override
  Future<Result<bool>> removeAllFavourites() => _datasource.removeAllFavourites();

  @override
  Future<Result<bool>> removeFavourite(String bookId) => _datasource.removeFavourite(bookId);

  @override
  Future<Result<bool>> saveFavourite(BookEntity book) => _datasource.saveFavourite(book);

  @override
  Future<Result<List<BookModel>>> searchBooks(List<String> query) => _datasource.searchBooks(query);

  @override
  Future<Result<List<BookModel>>> searchBooksLocally(List<String> query) =>
      _datasource.searchBooksLocally(query);
}
