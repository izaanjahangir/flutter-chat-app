class UserModel {
  String firstName, lastName, email, gender, id;
  String? profileImage;

  UserModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.gender,
      required this.id,
      this.profileImage});
}
