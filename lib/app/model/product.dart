class ProductModel {
  int? id;
  String? name;
  String? description;
  String? imageURL;
  int? price;
  int? categoryID;
  String? categoryName;

  ProductModel(
      {this.id,
      this.name,
      this.description,
      this.imageURL,
      this.price,
      this.categoryID,
      this.categoryName});

  static ProductModel productEmpty() {
    return ProductModel(
        id: 0,
        name: "",
        description: "",
        imageURL: "",
        price: 0,
        categoryID: 0,
        categoryName: "");
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageURL: json["imageURL"] == null || json["imageURL"] == ''
            ? ""
            : json['imageURL'],
        price: json["price"],
        categoryID: json["categoryID"],
        categoryName: json["categoryName"],
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['imageURL'] = imageURL;
    data['price'] = price;
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;

    return data;

  }





}
