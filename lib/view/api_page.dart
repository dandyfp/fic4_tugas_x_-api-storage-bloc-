import 'package:flutter/material.dart';

import '../crud_rest_api/album.dart';
import '../crud_rest_api/network_manager.dart';
import '../json_serialization/lesson/product_model.dart';

class ApiPage extends StatefulWidget {
  const ApiPage({super.key});

  @override
  State<ApiPage> createState() => _ApiPageState();
}

class _ApiPageState extends State<ApiPage> {
  @override
  void initState() {
    super.initState();
    futureAlbum = NetworkManager().fetchAllAlbum();
    productModel = NetworkManager().fetchProduct();
  }

  late Future<ProductModel> productModel;
  late Future<List<Album>> futureAlbum;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Http Example')),
      body: FutureBuilder<ProductModel>(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
                child: Column(
              children: [
                Text(snapshot.data!.title),
                Image.network(snapshot.data!.images[0]),
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: productModel,
      ),
    );
  }
}
