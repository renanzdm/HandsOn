
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';

abstract class IProductDataSource{
  Future<String> create(ProductModel product);
  Future<String> remove(String id);
  Future<List<Product>> fetchProducts();

}