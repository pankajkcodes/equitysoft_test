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

  // Initial Selected Value
  String dropdownvalue = 'Item 1';

  // List of items in our dropdown menu
  var items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Add Products",
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
              DropdownButton(
                value: dropdownvalue,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                  });
                },
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    labelText: "Product Name",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    labelText: "Product Name",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    labelText: "Product Name",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              Container(child: Text("Upload Image"),),
              Container(
                width: width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: bodyText1small(color: Colors.white)),
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
