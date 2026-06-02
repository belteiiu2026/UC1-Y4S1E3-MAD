import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:mad/model/product.dart';

class ProductService {

  static final ProductService instance = ProductService._init();

  ProductService._init();

  Future<void> insertProduct() async {

  }

  Future<List<Product>> getProducts() async {
    String url = "https://fakestoreapi.com/products";
    final header = {'Content-Type':'application/json'};
    final response = await http.get(Uri.parse(url), headers: header);
    if(response.statusCode == 200){
      final data = jsonDecode(response.body) as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    }else{
      print(response.statusCode);
      throw("Internal Server Error");
    }
  }

  Future<void> updateProduct() async {

  }

  Future<void> deleteProduct() async {

  }
}