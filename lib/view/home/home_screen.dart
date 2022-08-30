import 'package:equitysoft_test/constants/constants.dart';
import 'package:equitysoft_test/view/category/add_category.dart';
import 'package:equitysoft_test/view/company/add_company.dart';
import 'package:equitysoft_test/view/product/product_list.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Home",
          style: bodyText1(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductListScreen()));
              },
              child: Container(
                height: height(context) * 0.23,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(height(context) * 0.02),
                child: Center(
                  child: Text(
                    "Products",
                    style: bodyText1(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddCategoryScreen()));
              },
              child: Container(
                height: height(context) * 0.23,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(height(context) * 0.02),
                child: Center(
                  child: Text(
                    "Manage Category",
                    style: bodyText1(color: Colors.white),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddCompanyScreen()));
              },
              child: Container(
                height: height(context) * 0.23,
                decoration: BoxDecoration(
                    color: Colors.grey, borderRadius: BorderRadius.circular(5)),
                margin: EdgeInsets.all(height(context) * 0.02),
                child: Center(
                  child: Text(
                    "Manage Company",
                    style: bodyText1(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
