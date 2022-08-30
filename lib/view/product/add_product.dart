import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft_test/constants/constants.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  String randomId = DateTime.now().microsecondsSinceEpoch.toString();

  _addNewProduct(String catName) {
    FirebaseFirestore.instance
        .collection("companies")
        .doc(randomId)
        .set({"name": catName, "id": randomId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Products",
          style: bodyText1(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(width(context) * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    labelText: "Product Name",
                    labelStyle: bodyText1(color: Colors.grey)),
              ),
              Container(
                width: width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: bodyText1(color: Colors.white)),
                  onPressed: () {
                    if (_nameController.text.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Can't be empty")));
                    } else {
                      _addNewProduct(_nameController.text.trim());
                    }
                  },
                  child: Text(
                    'Add',
                    style: bodyText1(color: Colors.white),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
