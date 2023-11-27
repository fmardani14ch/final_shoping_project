class HOME_MODEL {
  List<PRODUCT>? news;
  List<Slides>? slides;
  List<PRODUCT>? mostVisited;

  HOME_MODEL({this.news, this.slides, this.mostVisited});

  HOME_MODEL.fromJson(Map<String, dynamic> json) {
    if (json['news'] != null) {
      news = <PRODUCT>[];
      json['news'].forEach((v) {
        news!.add(new PRODUCT.fromJson(v));
      });
    }
    if (json['slides'] != null) {
      slides = <Slides>[];
      json['slides'].forEach((v) {
        slides!.add(new Slides.fromJson(v));
      });
    }
    if (json['mostVisited'] != null) {
      mostVisited = <PRODUCT>[];
      json['mostVisited'].forEach((v) {
        mostVisited!.add(new PRODUCT.fromJson(v));
      });
    }
  }
}

class PRODUCT {
  int? id;

  String? title;

  num? price;

  num? discountPrice;

  bool? hasDiscount;

  num? discountPercent;

  String? image;

  PRODUCT(
      {this.id,
      this.title,
      this.price,
      this.discountPrice,
      this.hasDiscount,
      this.discountPercent,
      this.image});

  PRODUCT.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    discountPrice = json['discountPrice'];
    hasDiscount = json['hasDiscount'];
    discountPercent = json['discountPercent'];
    image = json['image'];
  }
}

class Slides {
  String? title;
  String? image;
  String? url;

  Slides({this.title, this.image, this.url});

  Slides.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    image = json['image'];
    url = json['url'];
  }
}
