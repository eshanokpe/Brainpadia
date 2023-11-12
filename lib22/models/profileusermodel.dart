// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);
import 'dart:convert';

ProfileUserModel usermodelFromJson(String str) =>
    ProfileUserModel.fromJson(json.decode(str));
String usermodelToJson(ProfileUserModel data) => json.encode(data.toJson());

class ProfileUserModel {
  ProfileUserModel({
    this.profileId,
    this.firstName,
    this.surName,
    this.middleName,
    this.nickName,
    this.aboutMe,
    this.address,
    this.email,
    this.phoneNumber,
    this.experience,
    this.projectCompleted,
    this.freeLance,
    this.profession,
    this.gender,
    this.imageUrl,
    this.imageFile,
    this.country,
    this.state,
    this.city,
    this.dateOfBirth,
    this.facebook,
    this.twitter,
    this.instagram,
    this.youtube,
    this.linkedIn,
    this.github,
    this.isBlogger,
    this.fullName,
    this.dateCreated,
    this.userCreated,
    this.dateModified,
    this.userModified,
  });

  final int? profileId;
  final String? firstName;
  final String? surName;
  final String? middleName;
  final String? nickName;
  final String? aboutMe;
  final String? address;
  final String? email;
  final String? phoneNumber;
  final int? experience;
  final int? projectCompleted;
  final int? freeLance;
  final String? profession;
  final String? gender;
  final String? imageUrl;
  final String? imageFile;
  final String? country;
  final String? state;
  final String? city;
  final String? dateOfBirth;
  final String? facebook;
  final String? twitter;
  final String? instagram;
  final String? youtube;
  final String? linkedIn;
  final String? github;
  final bool? isBlogger;
  final String? fullName;
  final String? dateCreated;
  final String? userCreated;
  final String? dateModified;
  final String? userModified;

  factory ProfileUserModel.fromJson(Map<String, dynamic> json) =>
      ProfileUserModel(
          profileId: json['profileId'],
          firstName: json['firstName'],
          surName: json['surName'],
          middleName: json['middleName'],
          nickName: json['nickName'],
          aboutMe: json['aboutMe'],
          address: json['address'],
          email: json['email'],
          phoneNumber: json['phoneNumber'],
          experience: json['experience'],
          projectCompleted: json['projectCompleted'],
          freeLance: json['freeLance'],
          profession: json['profession'],
          gender: json['gender'],
          imageUrl: json['imageUrl'],
          imageFile: json['imageFile'],
          country: json['country'],
          state: json['state'],
          city: json['city'],
          dateOfBirth: json['dateOfBirth'],
          facebook: json['facebook'],
          twitter: json['twitter'],
          instagram: json['instagram'],
          youtube: json['youtube'],
          linkedIn: json['linkedIn'],
          github: json['github'],
          isBlogger: json['isBlogger'],
          fullName: json['fullName'],
          dateCreated: json['dateCreated'],
          userCreated: json['userCreated'],
          dateModified: json['dateModified'],
          userModified: json['userModified']);

  Map<String, dynamic> toJson() => {
        'profileId': profileId,
        'firstName': firstName,
        'surName': surName,
        'middleName': middleName,
        'nickName': nickName,
        'aboutMe': aboutMe,
        'address': address,
        'email': email,
        'phoneNumber': phoneNumber,
        'experience': experience,
        'projectCompleted': projectCompleted,
        'freeLance': freeLance,
        'profession': profession,
        'gender': gender,
        'imageUrl': imageUrl,
        'imageFile': imageFile,
        'country': country,
        'state': state,
        'city': city,
        'dateOfBirth': dateOfBirth,
        'facebook': facebook,
        'twitter': twitter,
        'instagram': instagram,
        'youtube': youtube,
        'linkedIn': linkedIn,
        'github': github,
        'isBlogger': isBlogger,
        'fullName': fullName,
        'dateCreated': dateCreated,
        'userCreated': userCreated,
        'dateModified': dateModified,
        'userModified': userModified,
      };
}
