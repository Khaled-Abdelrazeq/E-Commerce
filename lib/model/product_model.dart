class ProductModel {
  String? category;
  List<String>? color = [];
  List<ProductCommentModel>? comments = [];
  String? description;
  int? discount;
  bool? flashSale;
  List<String>? image = [];
  bool? megaSale;
  String? name;
  int? numberOfSelling;
  double? price;
  double? priceAfterDiscount;
  String? rate;
  List<String>? shown = [];
  List<int>? size = [];
  bool? best;

  ProductModel({
    this.rate,
    this.name,
    this.image,
    this.size,
    this.color,
    this.description,
    this.price,
    this.category,
    this.discount,
    this.comments,
    this.flashSale,
    this.megaSale,
    this.numberOfSelling,
    this.priceAfterDiscount,
    this.shown,
    this.best,
  });

  ProductModel.fromJson(dynamic data) {
    rate = data['rate'];
    name = data['name'];
    description = data['description'];
    priceAfterDiscount = data['priceAfterDiscount'];
    price = data['price'];
    category = data['category'];
    discount = data['discount'];
    flashSale = data['flashSale'];
    megaSale = data['megaSale'];
    numberOfSelling = data['numberOfSelling'];
    best = data['best'];

    if (data['shown'] != null) {
      data['shown'].forEach((element) {
        shown?.add(element);
      });
    }
    if (data['image'] != null) {
      data['image'].forEach((element) {
        image?.add(element);
      });
    }
    if (data['color'] != null) {
      data['color'].forEach((element) {
        color?.add(element);
      });
    }
    if (data['size'] != null) {
      data['size'].forEach((element) {
        size?.add(element);
      });
    }
    if (data['comments'] != null) {
      data['comments'].forEach((element) {
        comments?.add(ProductCommentModel.fromJson(element));
      });
    }
  }

  toJson() {
    int max = comments!.length - 1;
    List<Map> data =
        List.generate(max + 1, (index) => comments![index].toJson());

    return {
      'comments': data,
      'rate': rate,
      'name': name,
      'image': image,
      'size': size,
      'color': color,
      'description': description,
      'price': price,
      'category': category,
      'discount': discount,
      'flashSale': flashSale,
      'megaSale': megaSale,
      'numberOfSelling': numberOfSelling,
      'priceAfterDiscount': priceAfterDiscount,
      'shown': shown,
    };
  }
}

class ProductCommentModel {
  String? comment;
  List<String>? commentImage = [];
  String? date;
  String? name;
  String? profilePic;
  String? rate;

  ProductCommentModel(
      {this.name,
      this.comment,
      this.commentImage,
      this.date,
      this.profilePic,
      this.rate});

  ProductCommentModel.fromJson(dynamic data) {
    if (data == null) return;

    comment = data['comment'];
    date = data['date'];
    name = data['name'];
    profilePic = data['profilePic'];
    rate = data['rate'];

    if (data['commentImgs'] != null) {
      data['commentImgs'].forEach((element) {
        commentImage?.add(element);
      });
    }
  }

  toJson() {
    return {
      'comment': comment,
      'date': date,
      'name': name,
      'profilePic': profilePic,
      'rate': rate,
      'commentImage': commentImage,
    };
  }
}
