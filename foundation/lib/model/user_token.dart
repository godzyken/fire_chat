
class UserToken {
  final String token;
  final String? idUser;

  const UserToken({
    required this.token,
    this.idUser,
  });

  UserToken copy({
    required String token,
    String? idUser,
  }) =>
      UserToken(
        token: token,
        idUser: idUser,
      );


  static UserToken fromJson(Map<String, dynamic> json) => UserToken(
    token: json['token'],
    idUser: json['idUser'],
  );

  Map<String, dynamic> toJson() => {
    'token': token,
    'idUser': idUser,
  };
}
