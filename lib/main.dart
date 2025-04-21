import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor_ns/flutter_statusbarcolor_ns.dart';
import 'package:provider/provider.dart';
import 'package:switchly/core/constants/colors.dart';
import 'package:switchly/features/product/data/datasources/product_local_datasource.dart';
import 'package:switchly/features/product/domain/repositories/product_repository_impl.dart';
import 'package:switchly/features/product/domain/usecases/get_products.dart';
import 'package:switchly/features/product/presentation/providers/product_provider.dart';
import 'package:switchly/features/product/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
  FlutterStatusbarcolor.setStatusBarColor(AppColors.background);
  FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductProvider(
            GetProducts(
              ProductRepositoryImpl(ProductLocalDataSource()),
            ),
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Switchly',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
