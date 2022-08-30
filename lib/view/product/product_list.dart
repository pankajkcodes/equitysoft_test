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
  @override
  Widget build(BuildContext context) {
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
                        builder: (context) => const AddProductScreen()));
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      body: SizedBox(
        height: height(context),
        child: ListView.builder(itemBuilder: (context, index) {
          return InkWell(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen())),
            child: Container(
              margin: const EdgeInsets.all(5),
              height: height(context) * 0.2,
              decoration: BoxDecoration(
                  color: Colors.white70, borderRadius: BorderRadius.circular(5)),
              child: Row(
                children: [
                  Container(
                    width: width(context) * 0.3,
                    decoration: BoxDecoration(
                        color: Colors.black38,
                        borderRadius: BorderRadius.circular(5)),
                    margin:
                        const EdgeInsets.only(top: 21, right: 10, left: 10, bottom: 21),
                  ),
                  Container(
                    width: width(context) * 0.3,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(top: 21, bottom: 21),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Product name"),
                        Text("Category"),
                        Text("Quantity"),
                      ],
                    ),
                  ),
                  Container(
                    width: width(context) * 0.3,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(5)),
                    margin: const EdgeInsets.only(top: 21, bottom: 21),
                    child: Column(
                      children: [
                        ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.black38),
                            ),
                            onPressed: () {},
                            child: Text(
                              "   Edit   ",
                              style: bodyText1(color: Colors.white),
                            )),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(Colors.black38),
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
