class BookEntity {
  final String id;
  final String title;
  final String? subtitle;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  final int pageCount;
  final List<String> categories;
  final String smallImage;
  final String image;
  final String language;
  final String previewLink;
  final String infoLink;
  final bool forSale;
  final double? price;
  final String? currencyCode;
  final String? buyLink;
  bool isFavourite;

  BookEntity({
    required this.id,
    required this.title,
    this.subtitle,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    required this.pageCount,
    required this.categories,
    required this.smallImage,
    required this.image,
    required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.forSale,
    this.price,
    this.currencyCode,
    this.buyLink,
    this.isFavourite = false,
  });
}
