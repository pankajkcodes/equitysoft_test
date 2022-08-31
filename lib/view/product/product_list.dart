import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft_test/constants/constants.dart';
import 'package:equitysoft_test/view/product/add_product.dart';
import 'package:equitysoft_test/view/product/details_screen.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List list = [];

  _fetchProductData() {
    FirebaseFirestore.instance.collection("products").get().then((value) {
      list.clear();
      for (var doc in value.docs) {
        setState(() {
          list.add(doc.data());
        });
      }
    });
  }

  _deleteProductData(String docId) {
    FirebaseFirestore.instance.collection("products").doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    _fetchProductData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products",
          style: bodyText1(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductScreen(
                              type: 'add',docId: '',
                            )));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SizedBox(
        height: height(context),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DetailScreen())),
                child: Container(
                  margin: const EdgeInsets.all(5),
                  height: height(context) * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Container(
                        width: width(context) * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.black38,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(
                            top: 21, right: 10, left: 10, bottom: 21),
                      ),
                      Container(
                        width: width(context) * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(top: 21, bottom: 21),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${list[index]['name']}"),
                            Text("${list[index]['category']}"),
                            Text("${list[index]['quantity']}"),
                          ],
                        ),
                      ),
                      Container(
                        width: width(context) * 0.3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.only(top: 21, bottom: 21),
                        child: Column(
                          children: [
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black38),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AddProductScreen(
                                                type: 'edit',
                                                docId: list[index]['id'],
                                              )));
                                },
                                child: Text(
                                  "   Edit   ",
                                  style: bodyText1(color: Colors.white),
                                )),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black38),
                                ),
                                onPressed: () {},
                                child: Text(
                                  "Delete",
                                  style: bodyText1(color: Colors.white),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
