import 'package:hive/hive.dart';
part 'product.g.dart';

class PRODUCT_MODEL {
  List<Products>? products;
  num? page;
  num? totalCount;
  num? totalPages;
  num? pageSize;

  PRODUCT_MODEL(
      {this.products,
      this.page,
      this.totalCount,
      this.totalPages,
      this.pageSize});

  PRODUCT_MODEL.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    page = json['page'];
    totalCount = json['totalCount'];
    totalPages = json['totalPages'];
    pageSize = json['pageSize'];
  }
}

@HiveType(typeId: 0)
class Products extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(2)
  num? price;
  @HiveField(3)
  num? discountPrice;
  @HiveField(4)
  bool? hasDiscount;
  @HiveField(5)
  num? discountPercent;
  @HiveField(6)
  String? image;

  Products(
      {this.id,
      this.title,
      this.price,
      this.discountPrice,
      this.hasDiscount,
      this.discountPercent,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    hasDiscount = json['hasDiscount'];
    discountPercent = json['discountPercent'];
    image = json['image'];
  }
}

class COMMENTS {
  String? description;
  String? keyword;
  String? advantages;
  String? disAdvanteges;
  int? visitedStatistics;
  List<String>? images;
  List<Comments>? comments;
  int? id;
  String? title;
  num? price;
  num? discountPrice;
  bool? hasDiscount;
  num? discountPercent;
  String? image;

  COMMENTS(
      {this.description,
      this.keyword,
      this.advantages,
      this.disAdvanteges,
      this.visitedStatistics,
      this.images,
      this.comments,
      this.id,
      this.title,
      this.price,
      this.discountPrice,
      this.hasDiscount,
      this.discountPercent,
      this.image});

  COMMENTS.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    keyword = json['keyword'];
    advantages = json['advantages'];
    disAdvanteges = json['disAdvanteges'];
    visitedStatistics = json['visitedStatistics'];
    images = json['images'].cast<String>();
    if (json['comments'] != null) {
      comments = <Comments>[];
      json['comments'].forEach((v) {
        comments!.add(new Comments.fromJson(v));
      });
    }
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    hasDiscount = json['hasDiscount'];
    discountPercent = json['discountPercent'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['keyword'] = this.keyword;
    data['advantages'] = this.advantages;
    data['disAdvanteges'] = this.disAdvanteges;
    data['visitedStatistics'] = this.visitedStatistics;
    data['images'] = this.images;
    if (this.comments != null) {
      data['comments'] = this.comments!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['discountPrice'] = this.discountPrice;
    data['hasDiscount'] = this.hasDiscount;
    data['discountPercent'] = this.discountPercent;
    data['image'] = this.image;
    return data;
  }
}

class Comments {
  int? id;
  String? subject;
  String? text;
  String? userFullName;
  String? userEmail;
  int? productId;
  String? createDate;

  Comments(
      {this.id,
      this.subject,
      this.text,
      this.userFullName,
      this.userEmail,
      this.productId,
      this.createDate});

  Comments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subject = json['subject'];
    text = json['text'];
    userFullName = json['userFullName'];
    userEmail = json['userEmail'];
    productId = json['productId'];
    createDate = json['createDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['subject'] = this.subject;
    data['text'] = this.text;

    data['productId'] = this.productId;

    return data;
  }
}
