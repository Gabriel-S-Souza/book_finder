import 'package:book_finder/modules/details/domain/entities/book_details_entity.dart';

import '../../../../core/commom/domain/result.dart';
import '../../data/models/book_details_model.dart';

abstract class BookDetailsDatasource {
  Future<Result<BookDetailsModel>> getBookDetails(String bookId);
  Future<Result<bool>> removefavorite(String bookId);
  Future<Result<bool>> savefavorite(BookDetailsEntity book);
}
