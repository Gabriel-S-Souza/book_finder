import 'package:book_finder/core/commom/domain/result.dart';

import '../../../../core/commom/domain/failure.dart';
import '../../../../core/http/http_client.dart';
import '../../../../core/utils/api_routes.dart';
import '../../infra/datasources/book_details_datasource.dart';
import '../models/book_details_model.dart';

class BookDetailsDatasourceImp implements BookDetailsDatasource {
  final HttpClient _httpClient;

  BookDetailsDatasourceImp(this._httpClient);
  @override
  Future<Result<BookDetailsModel>> getBookDetails(String bookId) async {
    try {
      final response = await _httpClient.get('${ApiRoutes.detailsBook}$bookId');
      final book = BookDetailsModel.fromJson(response.data);
      return Result.success(book);
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(NotFoundFailure(e.toString()));
    }
  }
}
