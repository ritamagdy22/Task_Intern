import 'package:rita_firebase/models/product_response.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoadedSucessfully extends ProductState {
  final List<Product> products;
  ProductLoadedSucessfully({required this.products});
}

class ProductFailed extends ProductState {
  final String ErrorInLoadingProducts;
  ProductFailed({required this.ErrorInLoadingProducts});
}
