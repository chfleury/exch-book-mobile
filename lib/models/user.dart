class User {
  late int id;
  late String email;
  late String phone;
  late String name;
  late String password;
  late String location;

  User(
      {required this.id,
      required this.email,
      required this.phone,
      required this.name,
      required this.password,
      required this.location});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id']!;
    email = json['email']!;
    phone = json['phone']!;
    name = json['name']!;
    password = json['password']!;
    location = json['location']!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['password'] = this.password;
    data['location'] = this.location;
    return data;
  }
}
