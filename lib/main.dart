import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rita_firebase/screens/Products.dart';
import 'package:rita_firebase/cubit/product_cubit.dart';
import 'screens/login.dart';

void main() async {
 // by using firebase core we intialize firebase in main 
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCdDPxbIPssl9fl8eM2SknQTmiutmkSu7s",
      appId: "1:534307538138:android:eeef2ba6c6896070d811e3",
      messagingSenderId: "534307538138",
      projectId: "fir-auth-intern",
    ),
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProductCubit()..FetchProduct()),
      ],
      child: MaterialApp(
        initialRoute: '/', 
        routes: {
          '/': (context) => const Login(),
          '/home': (context) => const ProductScreen(),
        },
      ),
    );
  }
}
