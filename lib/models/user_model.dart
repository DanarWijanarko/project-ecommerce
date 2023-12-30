class User {
  String id;
  final bool isAdmin;
  final String imgName;
  final String imgUrl;
  final String username;
  final String email;
  final String address;
  final String phone;
  final String birthDate;

  User({
    this.id = '',
    required this.isAdmin,
    required this.imgName,
    required this.imgUrl,
    required this.username,
    required this.email,
    required this.address,
    required this.phone,
    required this.birthDate,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'isAdmin': isAdmin,
        'imgName': imgName,
        'imgUrl': imgUrl,
        'username': username,
        'email': email,
        'address': address,
        'phone': phone,
        'birthDate': birthDate,
      };

  static User fromJson(Map<String, dynamic> json) => User(
        isAdmin: json['isAdmin'],
        imgName: json['imgName'],
        imgUrl: json['imgUrl'],
        username: json['username'],
        email: json['email'],
        address: json['address'],
        phone: json['phone'],
        birthDate: json['birthDate'],
      );
}
