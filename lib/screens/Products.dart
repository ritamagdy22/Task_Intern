import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rita_firebase/cubit/product_cubit.dart';
import 'package:rita_firebase/cubit/product_state.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProductCubit>().FetchProduct(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Search")),
      body: Column(
        children: [
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: const InputDecoration(
                labelText: "Search Product...",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (query) {
                context.read<ProductCubit>().searchProduct(query);
              },
            ),
          ),

          // 📋 عرض المنتجات
          Expanded(
            child: BlocBuilder<ProductCubit, ProductState>(
              builder: (context, state) {
                if (state is ProductLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ProductLoadedSucessfully) {
                  return ListView.builder(
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];
                      return ListTile(
                        leading: Image.network(product.image, width: 50, height: 50),
                        title: Text(product.title),
                        subtitle: Text("\$${product.price}"),
                      );
                    },
                  );
                } else if (state is ProductFailed) {
                  return Center(child: Text("Error: ${state.ErrorInLoadingProducts}"));
                }
                return Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}
