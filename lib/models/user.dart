// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);
import 'dart:convert';

User usermodelFromJson(String str) => User.fromJson(json.decode(str));
String usermodelToJson(User data) => json.encode(data.toJson());

Regdetails regmodelFromJson(String str) =>
    Regdetails.fromJson(json.decode(str));
String regmodelToJson(Regdetails data) => json.encode(data.toJson());

Editdetails editmodelFromJson(String str) =>
    Editdetails.fromJson(json.decode(str));
String editmodelToJson(Editdetails data) => json.encode(data.toJson());

Error errorFromJson(String str) => Error.fromJson(json.decode(str));
String errorToJson(Error data) => json.encode(data.toJson());

class User {
  User(
      {this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.phoneNumber,
      this.token,
      this.profileId,
      this.tokenExpiration});
  String? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  String? token;
  int? profileId;
  String? tokenExpiration;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json['userId'],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json['phoneNumber'],
        profileId: json['profileId'],
        token: json['token'],
        tokenExpiration: json['tokenExpiration'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        'phoneNumber': phoneNumber,
        'token': token,
        "profileId": profileId,
        "tokenExpiration": tokenExpiration,
      };
}

class Regdetails {
  User user;
  String token;
  Regdetails({required this.user, required this.token});
  factory Regdetails.fromJson(Map<String, dynamic> json) => Regdetails(
        user: json['user'],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        'user': user,
        "token": token,
      };
}

class Editdetails {
  Map<String, dynamic> user;
  Editdetails({required this.user});
  factory Editdetails.fromJson(Map<String, dynamic> json) => Editdetails(
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'user': user,
      };
}

class Error {
  String error;
  Error({required this.error});
  factory Error.fromJson(Map<String, dynamic> json) => Error(
        error: json['error'],
      );

  Map<String, dynamic> toJson() => {
        'error': error,
      };
}
