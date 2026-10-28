class Product {
  final String id;
  final String name;
  final int price;
  final String image; // path di folder assets
  final int stock;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.stock,
  });
}
