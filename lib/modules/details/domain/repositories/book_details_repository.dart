import '../../../../core/commom/domain/result.dart';
import '../../data/models/book_details_model.dart';
import '../entities/book_details_entity.dart';

abstract class BookDetailsRepository {
  Future<Result<BookDetailsModel>> getBookDetails(String bookId);
  Future<Result<bool>> saveFavourite(BookDetailsEntity book);
  Future<Result<bool>> removeFavourite(String bookId);
}
