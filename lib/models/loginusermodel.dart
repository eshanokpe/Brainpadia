// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);
import 'dart:convert';

Loginusermodel usermodelFromJson(String str) =>
    Loginusermodel.fromJson(json.decode(str));
String usermodelToJson(Loginusermodel data) => json.encode(data.toJson());

Regdetails regmodelFromJson(String str) =>
    Regdetails.fromJson(json.decode(str));
String regmodelToJson(Regdetails data) => json.encode(data.toJson());

Editdetails editmodelFromJson(String str) =>
    Editdetails.fromJson(json.decode(str));
String editmodelToJson(Editdetails data) => json.encode(data.toJson());

Error errorFromJson(String str) => Error.fromJson(json.decode(str));
String errorToJson(Error data) => json.encode(data.toJson());

class Loginusermodel {
  Loginusermodel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
  });
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;

  factory Loginusermodel.fromJson(Map<String, dynamic> json) => Loginusermodel(
        userId: json['userId'],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        phoneNumber: json['phoneNumber'],
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        'phoneNumber': phoneNumber
      };
}

class Regdetails {
  Loginusermodel user;
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
