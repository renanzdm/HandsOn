import 'package:handson/app/modules/loja/domain/entities/product.dart';

class ProductModel extends Product {
  final String title;
  final String description;
  final double price;
  final String category;

  ProductModel(this.title, this.description, this.price, this.category)
      : super(title: title, description: description, price: price,category: category);

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};

    map["title"] = title;
    map["description"] = description;
    map["price"] = price;
    map["category"] = category;
    return map;
  }
}


