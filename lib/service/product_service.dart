import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductService {

  static final ProductService instance = ProductService._init();

  ProductService._init();

  Future<void> insertProduct() async {

  }

  Future<List<dynamic>> getProducts() async {
    String url = "https://fakestoreapi.com/products";
    final header = {'Content-Type':'application/json'};
    final response = await http.get(Uri.parse(url), headers: header);
    if(response.statusCode == 200){
      List<dynamic> data = jsonDecode(response.body);
      return data;
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