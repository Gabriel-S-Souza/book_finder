import '../../../../core/commom/domain/result.dart';
import '../../data/models/book_details_model.dart';

abstract class BookDetailsRepository {
  Future<Result<BookDetailsModel>> getBookDetails(String bookId);
}
