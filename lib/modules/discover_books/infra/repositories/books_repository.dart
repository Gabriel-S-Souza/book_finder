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
  Future<Result<List<BookModel>>> getfavorites() => _datasource.getfavorites();

  @override
  Future<Result<bool>> removeAllfavorites() => _datasource.removeAllfavorites();

  @override
  Future<Result<bool>> removefavorite(String bookId) => _datasource.removefavorite(bookId);

  @override
  Future<Result<bool>> savefavorite(BookEntity book) => _datasource.savefavorite(book);

  @override
  Future<Result<List<BookModel>>> searchBooks(String query) => _datasource.searchBooks(query);

  @override
  Future<Result<List<BookModel>>> searchBooksLocally(String query) =>
      _datasource.searchBooksLocally(query);
}
