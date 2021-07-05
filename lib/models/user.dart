class User {
  String? id;
  String? fname;
  String? lname;
  String? email;
  String? password;
  String? role;
  DateTime? createdAt;

  User({
    this.email,
    this.fname,
    this.id,
    this.lname,
    this.password,
    this.role,
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fname: json['fname'],
      lname: json['lname'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
