class AUTHENTICATION_MODEL {
  String? fullName;
  String? phoneNumber;
  String? email;
  String? password;
  String? accessToken;

  AUTHENTICATION_MODEL(
      {this.fullName, this.phoneNumber, this.email, this.password});

  AUTHENTICATION_MODEL.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    fullName = json['fullName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fullName'] = this.fullName;
    data['phoneNumber'] = this.phoneNumber;
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}
