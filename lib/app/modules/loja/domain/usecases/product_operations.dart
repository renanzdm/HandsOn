import 'package:dartz/dartz.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/domain/failures/ProductFailures.dart';
import 'package:handson/app/modules/loja/domain/repositories/i_product_repository.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';
import 'package:handson/app/modules/loja/presenter/usecases/i_product_operations.dart';

class ProductOperations implements IProductOperations {
  final IProductRepository repository;

  ProductOperations(this.repository);

  @override
  Future<Either<ProductFailures, String>> create(ProductModel product) async {
    var result = await repository.create(product);
   return result.fold((l) => left(InsertProductFailure('Error')), (r) => right('Cadastrado'));
  }

  @override
  Future<Either<ProductFailures, String>> remove(String id) async {
    var result = await repository.remove(id);
 return  result.fold((l) => left(RemoveProductFailure('Error')), (r) => right('Removido'));
  }

  @override
  Future<Either<ProductFailures, List<Product>>> fetchProducts() async {
    var result = await repository.fetchProducts();
       List<Product> list;
  return result.fold((l) => left(FetchProductError('Error')), (r) => right(list=r));

  }
}
