abstract class ProductFailures implements Exception{

}
class InsertProductFailure extends ProductFailures{
  final String error;

  InsertProductFailure(this.error);


}

class RemoveProductFailure extends ProductFailures{
  final String error;

  RemoveProductFailure(this.error);
}

class FetchProductError extends ProductFailures{
  final String error;

  FetchProductError(this.error);

}
