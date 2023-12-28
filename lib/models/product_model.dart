class Product {
  final String imgUrl;
  final String name;
  final String type;
  final String price;
  final String discount;
  final String rating;
  final String sold;
  final String description;

  Product({
    required this.imgUrl,
    required this.name,
    required this.type,
    required this.price,
    required this.discount,
    required this.rating,
    required this.sold,
    required this.description,
  });

  Map<String, dynamic> toJson() => {
        'imgUrl': imgUrl,
        'name': name,
        'type': type,
        'price': price,
        'discount': discount,
        'rating': rating,
        'sold': sold,
        'description': description,
      };
}
