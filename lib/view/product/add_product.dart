import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft_test/constants/constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProductScreen extends StatefulWidget {
  final String type;
  final String docId;

  const AddProductScreen({Key? key, required this.type, required this.docId})
      : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _qtyController = TextEditingController();
  String randomId = DateTime.now().microsecondsSinceEpoch.toString();

  final ImagePicker _picker = ImagePicker();
  late final XFile? image;

  _addNewProduct(Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(randomId)
        .set(map);
  }

  String categoryValue = '';
  String companyValue = '';

  var companyList = [];
  var categoryList = [];

  _getCompaniesList() async {
    await FirebaseFirestore.instance
        .collection("companies")
        .get()
        .then((value) {
      companyList.clear();
      for (var doc in value.docs) {
        setState(() {
          companyList.add(doc.data()['name']);
        });
      }
    });
  }

  _getCategoryList() async {
    await FirebaseFirestore.instance
        .collection("categories")
        .get()
        .then((value) {
      categoryList.clear();
      for (var doc in value.docs) {
        setState(() {
          categoryList.add(doc.data()['name']);
        });
      }
    });
  }

  String imgUrl = '';

  _uploadImage(String path) async {
    final storageRef = FirebaseStorage.instance.ref();
    File file = File(path);
    var url =
        storageRef.child("images/${DateTime.now().microsecondsSinceEpoch}");
    await url.putFile(file);
    imgUrl = await url.getDownloadURL();

    log(imgUrl);
  }

  _updateProductData(String docId, Map<String, dynamic> map) async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(docId)
        .update(map);
  }

  Map map = {};

  @override
  void initState() {
    super.initState();
    _getCompaniesList();
    _getCategoryList();
    if (widget.type == "edit") {
      _fetchDataById();
    }
  }

  _fetchDataById() async {
    await FirebaseFirestore.instance
        .collection("products")
        .doc(widget.docId)
        .get()
        .then((value) {
      if (mounted) {
        setState(() {
          map = value.data()!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    log("companyData ${companyList.toString()}");
    log("categoryData ${categoryList.toString()}");

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "${widget.type} Products",
          style: bodyText1(color: Colors.white),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(width(context) * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Product Name',
                    labelText: map['name'] ?? "Product Name",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                child: DropdownButton(
                  // value: "hi",
                  underline: const SizedBox(),
                  hint: const Text("Category"),
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: categoryList.map((dynamic items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      categoryValue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              Container(
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                ),
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  hint: const Text("Company"),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: companyList.map((dynamic items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (dynamic newValue) {
                    setState(() {
                      categoryValue = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: height(context) * 0.01,
              ),
              TextField(
                minLines: 5,
                maxLines: 7,
                controller: _descController,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: map['description'] ?? 'Description',
                    labelText: "Description",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              SizedBox(
                height: height(context) * 0.021,
              ),
              TextField(
                controller: _priceController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: map['price'] ?? 'Price',
                    labelText: "Price",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              SizedBox(
                height: height(context) * 0.021,
              ),
              TextField(
                controller: _qtyController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: map['quantity'] ?? 'Quantity',
                    labelText: "Quantity",
                    labelStyle: bodyText1small(color: Colors.grey)),
              ),
              SizedBox(
                height: height(context) * 0.021,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: const EdgeInsets.all(4),
                      width: width(context) * 0.21,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: IconButton(
                          onPressed: () async {
                            var path = await _picker.pickImage(
                                source: ImageSource.gallery);

                            setState(() {
                              log(path!.path.toString());
                              _uploadImage(path.path.toString());
                            });
                          },
                          icon: const Icon(Icons.add)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(4),
                      width: width(context) * 0.21,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(4),
                      width: width(context) * 0.21,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      margin: const EdgeInsets.all(4),
                      width: width(context) * 0.2,
                      child: IconButton(
                          onPressed: () {}, icon: const Icon(Icons.add)),
                    ),
                  ],
                ),
              ),
              const Text("Upload Image"),
              SizedBox(
                width: width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: bodyText1small(color: Colors.white)),
                  onPressed: () {
                    if (widget.type == "edit") {
                      if (_nameController.text.trim() == "" &&
                          _descController.text.trim() == "" &&
                          _priceController.text.trim() == "" &&
                          imgUrl == "" &&
                          _qtyController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Can't be empty")));
                      } else {
                        _updateProductData(map['id'], {
                          "name": _nameController.text.trim(),
                          "category": categoryValue,
                          "company": categoryValue,
                          "description": _descController.text.trim(),
                          "price": _priceController.text.trim(),
                          "quantity": _qtyController.text.trim(),
                          "images": FieldValue.arrayUnion([
                            {"image": imgUrl},
                          ]),
                          "id": randomId,
                        });
                      }
                    } else {
                      if (_nameController.text.trim() == "" &&
                          _descController.text.trim() == "" &&
                          _priceController.text.trim() == "" &&
                          imgUrl == "" &&
                          _qtyController.text.trim() == "") {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Can't be empty")));
                      } else {
                        _addNewProduct({
                          "name": _nameController.text.trim(),
                          "category": categoryValue,
                          "company": categoryValue,
                          "description": _descController.text.trim(),
                          "price": _priceController.text.trim(),
                          "quantity": _qtyController.text.trim(),
                          "images": FieldValue.arrayUnion([
                            {"image": imgUrl},
                          ]),
                          "id": randomId,
                        });
                      }
                    }
                  },
                  child: Text(
                    widget.type == "edit" ? 'Update' : 'Add',
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
