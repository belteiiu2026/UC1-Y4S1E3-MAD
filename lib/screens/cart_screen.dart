import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mad/main.dart';
import 'package:mad/widgets/app_color.dart' as appColor;
import 'package:path_provider/path_provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<String> data = [];

  @override
  void initState() {
    super.initState();
    _getOrderProduct();
  }

  bool isShipping = true;

  double _calculateSubTotal() {
    return data.length * 2;
  }

  double _calculateVat() {
    return (data.length * 2) * (10 / 100);
  }


  double _calculateTotal() {
    return _calculateSubTotal() + _calculateVat() + (isShipping ? 5 : 0);
  }

  Future<void> _getOrderProduct() async {
    final appDoc = await getApplicationDocumentsDirectory();
    String path = appDoc.path;
    final  file = File("${path}/visitme.txt");
    List<String> data2 =  await file.readAsLines();
    // print("data $data");
    List<String> dataOrder = [];
    for(String s in data2){
      print("Items : $s");
      dataOrder.add(s);
    }
    setState(() {
      data = dataOrder;
    });
  }

  @override
  Widget build(BuildContext context) {
    dynamic orderList = data.map((m) {
      return SizedBox(
        child: Row(
          children: [
            Image.asset("assets/images/cocacola.jpeg", width: 50, height: 100),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${m}", style: TextStyle(fontSize: 18)),
                      Icon(Icons.delete, color: Colors.red, size: 18),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("2\$"),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.add_circle_outline, size: 16),
                            ),
                          ),
                          Text("1", style: TextStyle(fontSize: 18)),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.remove_circle_outline, size: 16),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList();

    final subTotal = SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Sub-Total"), Text("\$ ${_calculateSubTotal()}")],
        ),
      ),
    );

    orderList.add(subTotal);

    final vat = SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("VAT (%)"), Text("\$ ${_calculateVat()}")],
        ),
      ),
    );

    orderList.add(vat);

    final shippingFee = SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [Text("Shipping Fee"), Text("\$ ${isShipping ? 5 : 0}")],
        ),
      ),
    );

    orderList.add(shippingFee);

    final total = SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "\$ ${_calculateTotal()}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );

    orderList.add(SizedBox(child: Divider()));
    orderList.add(total);

    final checkoutBtn = SizedBox(
      child: Padding(
        padding: EdgeInsets.only(left: 8, right: 8, bottom: 16),
        child: SizedBox(
          height: 50,
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: appColor.app_background,
            ),
            onPressed: () {},
            child: Text("Checkout", style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(elevation: 3, title: Text("Cart"), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(child: ListView(children: orderList)),
            ),
            checkoutBtn,
          ],
        ),
      ),
    );
  }
}
