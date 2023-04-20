import '../../../../core/utils/currency_code_formatter.dart';
import '../../domain/entities/book_details_entity.dart';

class BookDetailsModel extends BookDetailsEntity {
  BookDetailsModel({
    required String id,
    required String title,
    required String? subtitle,
    required List<String> authors,
    required String publisher,
    required String publishedDate,
    required String description,
    required int pageCount,
    required List<String> categories,
    required String image,
    required String language,
    required String previewLink,
    required String infoLink,
    required bool forSale,
    double? price,
    String? currencyCode,
    String? buyLink,
    String? smallImage,
    bool isFavourite = false,
  }) : super(
          id: id,
          title: title,
          subtitle: subtitle,
          authors: authors,
          publisher: publisher,
          publishedDate: publishedDate,
          description: description,
          pageCount: pageCount,
          categories: categories,
          image: image,
          language: language,
          previewLink: previewLink,
          infoLink: infoLink,
          forSale: forSale,
          price: price,
          currencyCode: currencyCode,
          buyLink: buyLink,
          isFavorite: isFavourite,
          smallImage: smallImage,
        );

  factory BookDetailsModel.fromJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['id'],
      title: json['volumeInfo']['title'],
      subtitle: json['volumeInfo']['subtitle'],
      authors: List<String>.from(json['volumeInfo']['authors'] ?? []),
      publisher: json['volumeInfo']['publisher'],
      publishedDate: json['volumeInfo']['publishedDate'],
      description: json['volumeInfo']['description'],
      pageCount: json['volumeInfo']['pageCount'],
      categories: List<String>.from(json['volumeInfo']['categories']),
      image: json['volumeInfo']['imageLinks']['thumbnail'],
      language: json['volumeInfo']['language'],
      previewLink: json['volumeInfo']['previewLink'],
      infoLink: json['volumeInfo']['infoLink'],
      forSale: json['saleInfo']['saleability'] == 'FOR_SALE',
      price: json['saleInfo']['saleability'] == 'FOR_SALE'
          ? json['saleInfo']['listPrice']['amount']
          : null,
      currencyCode: json['saleInfo']['saleability'] == 'FOR_SALE'
          ? currencyCodeFormatter(json['saleInfo']['listPrice']['currencyCode'])
          : null,
      buyLink: json['saleInfo']['buyLink'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'authors': authors,
      'publisher': publisher,
      'publishedDate': publishedDate,
      'description': description,
      'pageCount': pageCount,
      'categories': categories,
      'image': image,
      'language': language,
      'previewLink': previewLink,
      'infoLink': infoLink,
      'forSale': forSale,
      'price': price,
      'currencyCode': currencyCode,
      'buyLink': buyLink,
      'isFavourite': isFavorite,
      'smallImage': smallImage,
    };
  }
}
