import '../../../../core/utils/currency_code_formatter.dart';
import '../../domain/entities/book_details_entity.dart';

class BookDetailsModel extends BookDetailsEntity {
  BookDetailsModel({
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
          image: image,
          language: language,
          previewLink: previewLink,
          infoLink: infoLink,
          forSale: forSale,
          price: price,
          currencyCode: currencyCode,
          buyLink: buyLink,
          isfavorite: isfavorite,
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

  factory BookDetailsModel.fromLocalJson(Map<String, dynamic> json) {
    return BookDetailsModel(
      id: json['id'],
      title: json['title'],
      subtitle: json['subtitle'],
      authors: List<String>.from(json['authors']),
      publisher: json['publisher'],
      publishedDate: json['publishedDate'],
      description: json['description'],
      pageCount: json['pageCount'],
      categories: List<String>.from(json['categories']),
      smallImage: json['smallImage'],
      image: json['image'],
      language: json['language'],
      previewLink: json['previewLink'],
      infoLink: json['infoLink'],
      forSale: json['forSale'],
      price: json['price'],
      currencyCode: json['currencyCode'],
      buyLink: json['buyLink'],
      isfavorite: json['isfavorite'],
    );
  }

  factory BookDetailsModel.fromEntity(BookDetailsEntity entity) {
    return BookDetailsModel(
      id: entity.id,
      title: entity.title,
      subtitle: entity.subtitle,
      authors: entity.authors,
      publisher: entity.publisher,
      publishedDate: entity.publishedDate,
      description: entity.description,
      pageCount: entity.pageCount,
      categories: entity.categories,
      image: entity.image,
      language: entity.language,
      previewLink: entity.previewLink,
      infoLink: entity.infoLink,
      forSale: entity.forSale,
      price: entity.price,
      currencyCode: entity.currencyCode,
      buyLink: entity.buyLink,
      isfavorite: entity.isfavorite,
      smallImage: entity.smallImage,
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
