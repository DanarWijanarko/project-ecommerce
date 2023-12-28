class Product {
  String id;
  final String imgName;
  final String imgUrl;
  final String name;
  final String type;
  final String price;
  final String discount;
  final String rating;
  final String sold;
  final String description;

  Product({
    this.id = '',
    required this.imgName,
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
        'id': id,
        'imgName': imgName,
        'imgUrl': imgUrl,
        'name': name,
        'type': type,
        'price': price,
        'discount': discount,
        'rating': rating,
        'sold': sold,
        'description': description,
      };

  static Product fromJson(Map<String, dynamic> json) => Product(
        id: json['id'],
        imgName: json['imgName'],
        imgUrl: json['imgUrl'],
        name: json['name'],
        type: json['type'],
        price: json['price'],
        discount: json['discount'],
        rating: json['rating'],
        sold: json['sold'],
        description: json['description'],
      );
}
