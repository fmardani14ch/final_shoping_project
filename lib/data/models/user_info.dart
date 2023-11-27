class USER_INFO {
  String? fullName;
  String? email;
  String? phoneNumber;
  String? registrationDate;

  USER_INFO(
      {this.fullName, this.email, this.phoneNumber, this.registrationDate});

  USER_INFO.fromJson(Map<String, dynamic> json) {
    fullName = json['fullName'];
    email = json['email'];
    phoneNumber = json['phoneNumber'];
    registrationDate = json['registrationDate'];
  }
}

class MY_COMMENTS {
  int? id;
  String? subject;
  String? text;
  String? userFullName;
  String? userEmail;
  int? productId;
  String? createDate;
  String? productTitle;
  String? productImage;

  MY_COMMENTS(
      {this.id,
      this.subject,
      this.text,
      this.userFullName,
      this.userEmail,
      this.productId,
      this.createDate,
      this.productTitle,
      this.productImage});

  MY_COMMENTS.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    text = json['text'];
    userFullName = json['userFullName'];
    userEmail = json['userEmail'];
    productId = json['productId'];
    createDate = json['createDate'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
  }
}

class SUCCESS_PAYMENT {
  int? factorCode;
  String? receiverFullName;
  String? receiverPhoneNumber;
  String? receiverPostalCode;
  String? receiverAddress;
  String? createDate;
  List<PAYMENT_FACTOR>? payment_factor;

  SUCCESS_PAYMENT(
      {this.factorCode,
      this.receiverFullName,
      this.receiverPhoneNumber,
      this.receiverPostalCode,
      this.receiverAddress,
      this.createDate,
      this.payment_factor});

  SUCCESS_PAYMENT.fromJson(Map<String, dynamic> json) {
    factorCode = json['factorCode'];
    receiverFullName = json['receiverFullName'];
    receiverPhoneNumber = json['receiverPhoneNumber'];
    receiverPostalCode = json['receiverPostalCode'];
    receiverAddress = json['receiverAddress'];
    createDate = json['createDate'];
    if (json['invoiceDetails'] != null) {
      payment_factor = <PAYMENT_FACTOR>[];
      json['invoiceDetails'].forEach((v) {
        payment_factor!.add(new PAYMENT_FACTOR.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['factorCode'] = this.factorCode;
    data['receiverFullName'] = this.receiverFullName;
    data['receiverPhoneNumber'] = this.receiverPhoneNumber;
    data['receiverPostalCode'] = this.receiverPostalCode;
    data['receiverAddress'] = this.receiverAddress;
    data['createDate'] = this.createDate;
    if (this.payment_factor != null) {
      data['invoiceDetails'] =
          this.payment_factor!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PAYMENT_FACTOR {
  int? count;
  num? fee;
  num? price;
  num? discountPercent;
  num? discountPrice;
  num? finalPrice;
  String? productTitle;
  String? productImage;
  int? productId;

  PAYMENT_FACTOR(
      {this.count,
      this.fee,
      this.price,
      this.discountPercent,
      this.discountPrice,
      this.finalPrice,
      this.productTitle,
      this.productImage,
      this.productId});

  PAYMENT_FACTOR.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    fee = json['fee'];
    price = json['price'];
    discountPercent = json['discountPercent'];
    discountPrice = json['discountPrice'];
    finalPrice = json['finalPrice'];
    productTitle = json['productTitle'];
    productImage = json['productImage'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['fee'] = this.fee;
    data['price'] = this.price;
    data['discountPercent'] = this.discountPercent;
    data['discountPrice'] = this.discountPrice;
    data['finalPrice'] = this.finalPrice;
    data['productTitle'] = this.productTitle;
    data['productImage'] = this.productImage;
    data['productId'] = this.productId;
    return data;
  }
}
