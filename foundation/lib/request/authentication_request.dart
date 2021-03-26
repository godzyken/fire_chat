
class AuthenticationRequest {
  final String idUser;

  const AuthenticationRequest({
    required this.idUser,
  });

  AuthenticationRequest copy({
    required String idUser,
  }) =>
      AuthenticationRequest(
        idUser: idUser,
      );

  static AuthenticationRequest fromJson(Map<String, dynamic> json) =>
      AuthenticationRequest(
        idUser: json['idUser'],
      );

  Map<String, dynamic> toJson() => {
    'idUser': idUser,
  };

  @override
  String toString() => 'AuthenticationRequest{idUser: $idUser}';
}