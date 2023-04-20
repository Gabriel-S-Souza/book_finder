import 'package:book_finder/modules/details/data/models/book_details_model.dart';

import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/modules/details/domain/entities/book_details_entity.dart';

import '../../domain/repositories/book_details_repository.dart';
import '../datasources/book_details_datasource.dart';

class BookDetailsRepositoryImp implements BookDetailsRepository {
  final BookDetailsDatasource _datasource;

  BookDetailsRepositoryImp({
    required BookDetailsDatasource datasource,
  }) : _datasource = datasource;

  @override
  Future<Result<BookDetailsModel>> getBookDetails(String bookId) =>
      _datasource.getBookDetails(bookId);

  @override
  Future<Result<bool>> removefavorite(String bookId) => _datasource.removefavorite(bookId);

  @override
  Future<Result<bool>> savefavorite(BookDetailsEntity book) => _datasource.savefavorite(book);
}
