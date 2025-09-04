class UserDetail {
  final String firstName;
  final String lastName;
  final String email;

  UserDetail({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        firstName: json['first_name'],
        lastName: json['last_name'],
        email: json['email'],
      );
}
