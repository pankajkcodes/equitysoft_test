import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft_test/constants/constants.dart';
import 'package:flutter/material.dart';

class AddCompanyScreen extends StatefulWidget {
  const AddCompanyScreen({Key? key}) : super(key: key);

  @override
  State<AddCompanyScreen> createState() => _AddCompanyScreenState();
}

class _AddCompanyScreenState extends State<AddCompanyScreen> {
  TextEditingController controller = TextEditingController();
  String randomId = DateTime.now().microsecondsSinceEpoch.toString();

  _addNewCompany(String catName) {
    FirebaseFirestore.instance
        .collection("companies")
        .doc(randomId)
        .set({"name": catName, "id": randomId});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Company",
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
                controller: controller,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Company Name',
                    labelText: "Company Name",
                    labelStyle: bodyText1(color: Colors.grey)),
              ),
              Container(
                width: width(context),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      textStyle: bodyText1(color: Colors.white)),
                  onPressed: () {
                    if (controller.text.trim() == "") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Can't be empty")));
                    } else {
                      _addNewCompany(controller.text.trim());
                    }
                  },
                  child: Text(
                    'Add',
                    style: bodyText1(color: Colors.white),
                  ),
                ),
              ),
              Text(
                "List of companies",
                style: bodyText1(color: Colors.black),
              ),
              SizedBox(
                height: height(context) * 0.68,
                child: ListView.builder(itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(top: 15),
                    height: height(context) * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(5)),
                    child: ListTile(
                      leading: Text(
                        "$index",
                        style: bodyText1(color: Colors.white),
                      ),
                      trailing: IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
