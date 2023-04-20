import 'package:book_finder/core/utils/currency_code_formatter.dart';

import '../../domain/entities/book_entity.dart';

class BookModel extends BookEntity {
  BookModel({
    required String id,
    required String title,
    required String? subtitle,
    required List<String> authors,
    String? publisher,
    String? publishedDate,
    String? description,
    int? pageCount,
    required List<String> categories,
    String? smallImage,
    required String image,
    required String language,
    required String previewLink,
    required String infoLink,
    required bool forSale,
    double? price,
    String? currencyCode,
    String? buyLink,
    bool isfavorite = false,
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
          smallImage: smallImage,
          image: image,
          language: language,
          previewLink: previewLink,
          infoLink: infoLink,
          forSale: forSale,
          price: price,
          currencyCode: currencyCode,
          buyLink: buyLink,
          isfavorite: isfavorite,
        );

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id'],
      title: json['volumeInfo']['title'],
      subtitle: json['volumeInfo']['subtitle'],
      authors: List<String>.from(json['volumeInfo']['authors'] ?? []),
      publisher: json['volumeInfo']['publisher'],
      publishedDate: json['volumeInfo']['publishedDate'],
      description: json['volumeInfo']['description'],
      pageCount: json['volumeInfo']['pageCount'],
      categories: List<String>.from(json['volumeInfo']['categories'] ?? []),
      smallImage: json['volumeInfo']['imageLinks']?['smallThumbnail'],
      image: json['volumeInfo']['imageLinks']?['thumbnail'] ??
          'https://img.freepik.com/free-vector/red-exclamation-mark-symbol-attention-caution-sign-icon-alert-danger-problem_40876-3505.jpg?w=2000',
      language: json['volumeInfo']['language'],
      previewLink: json['volumeInfo']['previewLink'],
      infoLink: json['volumeInfo']['infoLink'],
      forSale: json['saleInfo']['saleability'] == 'FOR_SALE',
      price: json['saleInfo']['saleability'] == 'FOR_SALE'
          ? json['saleInfo']['listPrice']['amount'].toDouble()
          : null,
      currencyCode: json['saleInfo']['saleability'] == 'FOR_SALE'
          ? currencyCodeFormatter(json['saleInfo']['listPrice']['currencyCode'])
          : null,
      buyLink: json['saleInfo']['buyLink'],
    );
  }

  factory BookModel.fromEntity(BookEntity entity) {
    return BookModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      authors: entity.authors,
      publisher: entity.publisher,
      publishedDate: entity.publishedDate,
      description: entity.description,
      pageCount: entity.pageCount,
      categories: entity.categories,
      smallImage: entity.smallImage,
      image: entity.image,
      language: entity.language,
      previewLink: entity.previewLink,
      infoLink: entity.infoLink,
      forSale: entity.forSale,
      price: entity.price,
      currencyCode: entity.currencyCode,
      buyLink: entity.buyLink,
      isfavorite: entity.isfavorite,
    );
  }

  factory BookModel.fromLocalJson(Map<String, dynamic> map) {
    return BookModel(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
      authors: List<String>.from(map['authors']),
      publisher: map['publisher'],
      publishedDate: map['publishedDate'],
      description: map['description'],
      pageCount: map['pageCount'],
      categories: List<String>.from(map['categories']),
      smallImage: map['smallImage'],
      image: map['image'],
      language: map['language'],
      previewLink: map['previewLink'],
      infoLink: map['infoLink'],
      forSale: map['forSale'],
      price: map['price'],
      currencyCode: map['currencyCode'],
      buyLink: map['buyLink'],
      isfavorite: map['isfavorite'],
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
      'smallImage': smallImage,
      'image': image,
      'language': language,
      'previewLink': previewLink,
      'infoLink': infoLink,
      'forSale': forSale,
      'price': price,
      'currencyCode': currencyCode,
      'buyLink': buyLink,
      'isfavorite': isfavorite,
    };
  }
}
