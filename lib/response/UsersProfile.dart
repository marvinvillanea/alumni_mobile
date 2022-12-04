class UsersProfile {
  int user_id;
  String email;
  String fullname;
  String contact_no;

  UsersProfile({required this.user_id, required this.email, required this.fullname, required this.contact_no });

  factory UsersProfile.fromJson(Map<String, dynamic> json){
    return UsersProfile(user_id: json["user_id"], email: json["email"], fullname: json["fullname"], contact_no: json["contact_no"]);
  }
}