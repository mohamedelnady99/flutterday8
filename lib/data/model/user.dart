class Users {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  Users({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  // Factory constructor to parse JSON into User
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }
}
