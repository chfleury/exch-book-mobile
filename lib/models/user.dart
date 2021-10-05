class User {
  String email = '';
  String phone = '';
  String name = '';
  String password = '';
  String city = '';

  User(this.email, this.phone, this.name, this.password, this.city);

  User.fromJson(Map<String, dynamic> json) {
    email = json['email']!;
    phone = json['phone']!;
    name = json['name']!;
    password = json['password']!;
    city = json['city']!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['name'] = this.name;
    data['password'] = this.password;
    data['city'] = this.city;
    return data;
  }
}
