class USER_BASKET {
  num? totalPrice;
  num? totalDiscountPrice;
  num? totalFinalPrice;
  List<Items>? items;

  USER_BASKET(
      {this.totalPrice,
      this.totalDiscountPrice,
      this.totalFinalPrice,
      this.items});

  USER_BASKET.fromJson(Map<String, dynamic> json) {
    totalPrice = json['totalPrice'];
    totalDiscountPrice = json['totalDiscountPrice'];
    totalFinalPrice = json['totalFinalPrice'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalPrice'] = this.totalPrice;
    data['totalDiscountPrice'] = this.totalDiscountPrice;
    data['totalFinalPrice'] = this.totalFinalPrice;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  num? count;
  num? fee;
  num? price;
  num? discountPercent;
  num? discountPrice;
  num? finalPrice;
  String? productTitle;
  String? productImage;
  int? productId;

  Items(
      {this.count,
      this.fee,
      this.price,
      this.discountPercent,
      this.discountPrice,
      this.finalPrice,
      this.productTitle,
      this.productImage,
      this.productId});

  Items.fromJson(Map<String, dynamic> json) {
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

class PAYMENT {
  int? factorCode;
  String? receiverFullName;
  String? receiverPhoneNumber;
  String? receiverPostalCode;
  String? receiverAddress;
  String? createDate;

  PAYMENT({
    this.factorCode,
    this.receiverFullName,
    this.receiverPhoneNumber,
    this.receiverPostalCode,
    this.receiverAddress,
    this.createDate,
  });

  PAYMENT.fromJson(Map<String, dynamic> json) {
    factorCode = json['factorCode'];
    receiverFullName = json['receiverFullName'];
    receiverPhoneNumber = json['receiverPhoneNumber'];
    receiverPostalCode = json['receiverPostalCode'];
    receiverAddress = json['receiverAddress'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['factorCode'] = this.factorCode;
    data['receiverFullName'] = this.receiverFullName;
    data['receiverPhoneNumber'] = this.receiverPhoneNumber;
    data['receiverPostalCode'] = this.receiverPostalCode;
    data['receiverAddress'] = this.receiverAddress;
    data['createDate'] = this.createDate;

    return data;
  }
}
