import 'package:dartz/dartz.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/domain/failures/ProductFailures.dart';
import 'package:handson/app/modules/loja/domain/repositories/i_product_repository.dart';
import 'package:handson/app/modules/loja/infra/datasource/i_product_datasource.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';

class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<Either<ProductFailures, String>> create(ProductModel product) async {
    try {
      await dataSource.create(product);
      return right('Cadastrado com sucesso');
    } on ProductFailures catch (e) {
      return left(InsertProductFailure(e.toString()));
    } catch (e) {
      print(e);
      return left(e);
    }
  }

  @override
  Future<Either<ProductFailures, String>> remove(String id) async {
    try {
      await dataSource.remove(id);
      return right('Excluido com sucesso');
    } on ProductFailures catch (e) {
      return left(RemoveProductFailure(e.toString()));
    } catch (e) {
      print(e);
      return left(e);
    }
  }

  @override
  Future<Either<ProductFailures, List<Product>>> fetchProducts() async {
   try{
  var list =  await dataSource.fetchProducts();
  //print(list.first.title);
  return right(list);
   }on ProductFailures
   catch(e){
   return left(FetchProductError(e.toString()));
   }
  }



}
