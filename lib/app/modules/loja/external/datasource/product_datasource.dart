import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:handson/app/modules/loja/domain/entities/product.dart';
import 'package:handson/app/modules/loja/domain/failures/ProductFailures.dart';
import 'package:handson/app/modules/loja/infra/datasource/i_product_datasource.dart';
import 'package:handson/app/modules/loja/infra/model/product_model.dart';

class ProductDataSource implements IProductDataSource {
  final FirebaseFirestore firestore;

  ProductDataSource(this.firestore);

  @override
  Future<String> create(ProductModel product) async {
    CollectionReference productCollection = firestore.collection('product');
    try {
      await productCollection.add(product.toJson());
      return 'Cadastrado com sucesso';
    } on ProductFailures catch (e) {
      throw (InsertProductFailure(e.toString()));
    } catch (e) {
      throw (e.error);
    }
  }

  @override
  Future<String> remove(String id) async {
    CollectionReference productCollection = firestore.collection('product');
    try {
      productCollection.doc(id).delete();
    } catch (e) {
      throw(e);
    }
  }

  @override
  Future<List<Product>> fetchProducts() async {
    CollectionReference productCollection = firestore.collection('product');

    return productCollection.get().then((value) => value.docs
        .map((e) => Product(
              id: e.id,
              category: e['category'],
              title: e['title'],
              price: e['price'],
              description: e['description'],
            ))
        .toList());
  }
}
