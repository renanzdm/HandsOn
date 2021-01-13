import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:handson/app/modules/loja/domain/usecases/product_operations.dart';
import 'package:handson/app/modules/loja/external/datasource/product_datasource.dart';
import 'package:handson/app/modules/loja/infra/repositories/product_repository.dart';
import 'package:handson/app/modules/loja/presenter/pages/controller/product_operations_controller.dart';

final inject = GetIt.instance;

void setupProjectDependencies() async {
  await Firebase.initializeApp();
  inject.registerLazySingleton(() => FirebaseFirestore.instance);
  inject.registerSingleton<ProductDataSource>(
      ProductDataSource(inject.get<FirebaseFirestore>()));
  inject.registerLazySingleton<ProductRepository>(
      () => ProductRepository(inject.get<ProductDataSource>()));
  inject.registerLazySingleton<ProductOperations>(
      () => ProductOperations(inject.get<ProductRepository>()));
  inject.registerLazySingleton<ProductOperationsController>(
      () => ProductOperationsController(inject.get<ProductOperations>()));
}
