class Cart {
  String id;
  final String imgName;
  final String imgUrl;
  final String name;
  final String type;
  final String price;
  final String discount;

  Cart({
    this.id = '',
    required this.imgName,
    required this.imgUrl,
    required this.name,
    required this.type,
    required this.price,
    required this.discount,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'imgName': imgName,
        'imgUrl': imgUrl,
        'name': name,
        'type': type,
        'price': price,
        'discount': discount,
      };

  static Cart fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        imgName: json['imgName'],
        imgUrl: json['imgUrl'],
        name: json['name'],
        type: json['type'],
        price: json['price'],
        discount: json['discount'],
      );
}
