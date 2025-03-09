class UserCreationReq {
  String? email;
  String? password;
  String? name;
  String? birthDate;
  String? favorite;
  int? gender;

  UserCreationReq({
    this.email,
    this.password,
    this.name,
    this.birthDate,
    this.favorite,
    this.gender,
  });
}
