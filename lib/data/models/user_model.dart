// class UserModel{
//   late final String id;
//   late final String firstName;
//   late final String lastName;
//   late final String email;
//   late final String mobile;
//   late final String photo;
//
//
//   UserModel();
//
//
//   /// named constructor
//   UserModel.fromJson(Map<String, dynamic> jsonData){
//     id = jsonData['_id'];
//     email = jsonData['email'];
//     firstName = jsonData['firstName'];
//     lastName = jsonData['lastName'];
//     mobile = jsonData['mobile'];
//     photo = jsonData['photo'];
//   }
// }




class UserModel{
  late final String id;
  late final String firstName;
  late final String lastName;
  late final String email;
  late final String mobile;
  late final String photo;
  late final String createDate;


  // UserModel();


  /// named constructor
  UserModel.fromJson(Map<String, dynamic> jsonData){
    id = jsonData['_id'] ?? '';
    email = jsonData['email'] ?? '';
    firstName = jsonData['firstName'] ?? '';
    lastName = jsonData['lastName'] ?? '';
    mobile = jsonData['mobile'] ?? '';
    photo = jsonData['photo'] ?? '';
    createDate = jsonData['createDate'] ?? '';
  }

  Map<String, dynamic> toJson(){
    return {
      "_id": id,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "photo": photo,
  };
}

  String get fulName {
    return '$firstName $lastName';
  }

}


