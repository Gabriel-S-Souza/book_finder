class BookDetailsEntity {
  final String id;
  final String title;
  final String? subtitle;
  final List<String> authors;
  String? publisher;
  String? publishedDate;
  String? description;
  int? pageCount;
  final List<String> categories;
  String? smallImage;
  final String image;
  final String language;
  final String previewLink;
  final String infoLink;
  final bool forSale;
  final double? price;
  final String? currencyCode;
  final String? buyLink;
  bool isfavorite;

  BookDetailsEntity({
    required this.id,
    required this.title,
    this.subtitle,
    required this.authors,
    this.publisher,
    this.publishedDate,
    this.description,
    this.pageCount,
    required this.categories,
    this.smallImage,
    required this.image,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.forSale,
    this.price,
    this.currencyCode,
    this.buyLink,
    this.isfavorite = false,
  });
}
