class ProductEntity {
  final int id;
  final String title;
  final String price;
  final String category;
  final String description;
  final String imageUrl;
  final bool isFavorite;

  ProductEntity({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.description,
    required this.imageUrl,
    required this.isFavorite,
  });

  @override
  bool operator ==(covariant ProductEntity other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.price == price &&
        other.category == category &&
        other.description == description &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        price.hashCode ^
        category.hashCode ^
        description.hashCode ^
        imageUrl.hashCode;
  }
}
