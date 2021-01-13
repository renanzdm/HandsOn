import 'package:dartz/dartz.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/domain/failures/ProductFailures.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';


abstract class IProductRepository{
  Future<Either<ProductFailures, String>> create(ProductModel product);
  Future<Either<ProductFailures, String>> remove(String id);
  Future<Either<ProductFailures, List<Product>>> fetchProducts();



}