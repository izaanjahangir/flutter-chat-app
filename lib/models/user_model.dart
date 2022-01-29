class UserModel {
  late String firstName, lastName, email, gender, id;
  late String? profileImage;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.gender,
      required this.id,
      this.profileImage});

  UserModel.fromMap(Map<String, dynamic> userData) {
    firstName = userData["firstName"];
    lastName = userData["lastName"];
    email = userData["email"];
    gender = userData["gender"];
    id = userData["id"];
    profileImage = userData["profileImage"];
  }

  String get fullName {
    return firstName + " " + lastName;
  }

  void updateWith(Map<String, dynamic> userData) {
    firstName = userData["firstName"] ?? firstName;
    lastName = userData["lastName"] ?? lastName;
    gender = userData["gender"] ?? gender;
    profileImage = userData["profileImage"] ?? profileImage;
  }
}
