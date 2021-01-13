import 'package:flutter/cupertino.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/domain/failures/ProductFailures.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';
import 'package:handson/app/modules/loja/presenter/usecases/i_product_operations.dart';

enum ProductState {initial,
loading,loaded
}
class ProductOperationsController {
ProductOperationsController(this._operations);

final IProductOperations _operations;
String title;
String description;
double price;
var dropDownMenuValueCategory = ValueNotifier<String>('');
List<String> listOfCategory = ['Pães', 'Bolos', 'Doces', 'Salgados'];
var listProducts = ValueNotifier<List<Product>>([]);
var state = ValueNotifier<ProductState>(ProductState.initial);

getProducts() async {
  state.value = ProductState.loading;

var res = await _operations.fetchProducts();

res.fold((l) => FetchProductError('Error'), (r) => listProducts.value = r);
  state.value = ProductState.loaded;


}
void deleteProduct(Product product)async{
await _operations.remove(product.id);
await getProducts();

}
void createProduct() {
var product = ProductModel(
title, description, price, dropDownMenuValueCategory.value);
_operations.create(product);
}


}
