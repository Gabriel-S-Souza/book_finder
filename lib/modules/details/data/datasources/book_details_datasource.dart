import 'dart:convert';

import 'package:book_finder/core/commom/domain/result.dart';
import 'package:book_finder/modules/details/domain/entities/book_details_entity.dart';

import '../../../../core/commom/domain/failure.dart';
import '../../../../core/commom/infra/datasources/local_storage.dart';
import '../../../../core/http/http_client.dart';
import '../../../../core/utils/api_routes.dart';
import '../../../../core/utils/storage_keys.dart';
import '../../infra/datasources/book_details_datasource.dart';
import '../models/book_details_model.dart';

class BookDetailsDatasourceImp implements BookDetailsDatasource {
  final HttpClient _httpClient;
  final LocalStorage _localStorage;

  BookDetailsDatasourceImp({
    required HttpClient httpClient,
    required LocalStorage localStorage,
  })  : _httpClient = httpClient,
        _localStorage = localStorage;

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

  @override
  Future<Result<bool>> savefavorite(BookDetailsEntity bookEntity) async {
    try {
      final bookToSave = BookDetailsModel.fromEntity(bookEntity);
      final booksJson = _localStorage.getList(StorageKeys.favoriteBooks) ?? [];

      final List<Map<String, dynamic>> decodedJsonList = List<Map<String, dynamic>>.from(
          booksJson.map((bookEncoded) => jsonDecode(bookEncoded)).toList());
      final books =
          decodedJsonList.map((bookMap) => BookDetailsModel.fromLocalJson(bookMap)).toList();
      final bookExists = books.any((element) => element.id == bookToSave.id);
      if (!bookExists) {
        books.add(bookToSave);
        final booksStringList = books.map((book) => jsonEncode(book)).toList();
        final result =
            await _localStorage.setList(key: StorageKeys.favoriteBooks, value: booksStringList);
        return Result.success(result);
      } else {
        return const Result.success(true);
      }
    } on Failure catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(Failure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> removefavorite(String bookId) async {
    try {
      final favorites = _localStorage.getList(StorageKeys.favoriteBooks) ?? [];
      bool removed = false;
      favorites.removeWhere((element) {
        final book = BookDetailsModel.fromLocalJson(jsonDecode(element));
        if (book.id == bookId) {
          removed = true;
          return true;
        } else {
          return false;
        }
      });
      await _localStorage.setList(key: StorageKeys.favoriteBooks, value: favorites);
      return Result.success(removed);
    } catch (e) {
      return Result.failure(Failure('Error removing from favorites'));
    }
  }
}
