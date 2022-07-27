class UserEntity {
  final String id;
  final String firstName;
  final String lastName;
  final String imgUrl;
  final String email;

  UserEntity(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      required this.imgUrl});

  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
        id: json['id'] ?? "",
        email: json['email'] ?? "",
        firstName: json['firstName'] ?? "",
        lastName: json['lastName'] ?? "",
        imgUrl: json['imgUrl'] ?? "");
  }
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'imgUrl': imgUrl,
      };

  factory UserEntity.empty() => UserEntity(
        id: "",
        firstName: "",
        lastName: "",
        email: "",
        imgUrl: "",
      );

  List<Object?> get props => [id, firstName, lastName, email, imgUrl];
}
