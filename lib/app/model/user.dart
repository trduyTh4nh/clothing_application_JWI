class User {
  String? idNumber;
  String? accountId;
  String? fullName;
  String? phoneNumber;
  String? imageURL;
  String? birthDay;
  String? gender;
  String? schoolYear;
  String? schoolKey;
  String? dateCreated;
  bool? status;

  User({
    required this.idNumber,
    required this.accountId,
    required this.fullName,
    required this.phoneNumber,
    required this.imageURL,
    required this.birthDay,
    required this.gender,
    required this.schoolYear,
    required this.schoolKey,
    required this.dateCreated,
    required this.status,
  });
  static User userEmpty() {
    return User(
        idNumber: '',
        accountId: '',
        fullName: '',
        phoneNumber: '',
        imageURL: '',
        birthDay: '',
        gender: '',
        schoolYear: '',
        schoolKey: '',
        dateCreated: '',
        status: false);
  }

  factory User.fromJson(Map<String, dynamic> json) => User(
        idNumber: json["idNumber"],
        accountId: json["accountID"],
        fullName: json["fullName"],
        phoneNumber: json["phoneNumber"],
        imageURL: json["imageURL"] == null || json["imageURL"] == ''
            ? ""
            : json['imageURL'],
        birthDay: json["birthDay"],
        gender: json["gender"],
        schoolYear: json["schoolYear"],
        schoolKey: json["schoolKey"],
        dateCreated: json["dateCreated"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idNumber'] = idNumber;
    data['accountId'] = accountId;
    data['gender'] = gender;
    data['fullName'] = fullName;
    data['gender'] = gender;
    data['phoneNumber'] = phoneNumber;
    data['imageURL'] = imageURL;
    data['birthDay'] = birthDay;
    data['schoolYear'] = schoolYear;
    data['schoolKey'] = schoolKey;

    return data;
  }
}
