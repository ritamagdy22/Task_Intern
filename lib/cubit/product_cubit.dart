import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rita_firebase/models/product_response.dart';
import 'package:rita_firebase/cubit/product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  List<Product> allProducts = [];  
  List<Product> filteredProducts = [];

  Future<void> FetchProduct() async {
    try {
      emit(ProductLoading());
      print("Fetching products...");

      final response = await Dio().get('https://fakestoreapi.com/products');

      if (response.statusCode == 200) {
        List<Product> products = (response.data as List)
            .map((productData) => Product.fromJson(productData))
            .toList();

        allProducts = products;  // ✅ تخزين كل المنتجات هنا لاستخدامها في البحث
        filteredProducts = products; // ✅ عرض المنتجات في البداية

        emit(ProductLoadedSucessfully(products: filteredProducts));
      } else {
        emit(ProductFailed(ErrorInLoadingProducts: "Error in loading products"));
      }
    } catch (e) {
      emit(ProductFailed(ErrorInLoadingProducts: "Something went wrong. Please try again later."));
    }
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      filteredProducts = allProducts; // ✅ استرجاع جميع المنتجات عند مسح البحث
    } else {
      filteredProducts = allProducts.where((product) =>
          product.title.toLowerCase().contains(query.toLowerCase())).toList();
    }
    emit(ProductLoadedSucessfully(products: filteredProducts));
  }
}
