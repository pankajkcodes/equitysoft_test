import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equitysoft_test/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Map<String, dynamic>? map;

  _fetchProductData() {
    FirebaseFirestore.instance.collection("products").get().then((value) {
      for (var doc in value.docs) {
        setState(() {
          setState(() {
            map = doc.data();
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchProductData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Details Screen",
          style: bodyText1(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SliderWidget(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Product name",
                        style: bodyText1Bigger(color: Colors.grey),
                      ),
                      Text(
                        "${map!["category"]}",
                        style: bodyText1small(color: Colors.grey),
                      ),
                      Text(
                        "${map!["company"]}",
                        style: bodyText1Bigger(color: Colors.grey),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price ${map!["price"]}",
                        style: bodyText1small(color: Colors.grey),
                      ),
                      Text(
                        "Quantity ${map!["quantity"]}",
                        style: bodyText1small(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.08),
              child: Text(
                "Description\n",
                style: bodyText1(color: Colors.grey),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.08),
              height: height(context) * 0.3,
              /*  child: Text(
              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s",
              style: bodyText1small(color: Colors.grey),
            ),*/
              child: Text(
                map!["description"],
                style: bodyText1small(color: Colors.grey),
              ),
            ),
        /*    Container(
              margin: EdgeInsets.symmetric(horizontal: width(context) * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width(context) * 0.4,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black38),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Edit",
                          style: bodyText1(color: Colors.white),
                        )),
                  ),
                  Container(
                    width: width(context) * 0.4,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.black38),
                        ),
                        onPressed: () {},
                        child: Text(
                          "Delete",
                          style: bodyText1(color: Colors.white),
                        )),
                  ),
                ],
              ),
            )*/
          ],
        ),
      ),
    );
  }
}

class SliderWidget extends StatefulWidget {
  const SliderWidget({Key? key}) : super(key: key);

  @override
  State<SliderWidget> createState() => _SliderWidgetState();
}

class _SliderWidgetState extends State<SliderWidget> {
  List imageList = [];
  final _carouselController = CarouselController();

  int _current = 0;
  Map<String, dynamic>? map;

  _fetchProductData() {
    FirebaseFirestore.instance.collection("products")
        .get().then((value) {
      imageList.clear();
      for (var doc in value.docs) {
        setState(() {
          // log(doc.data()['images'][0]["image1"].toString());
          imageList.add(doc.data()['images'][0]['image'].toString());
          setState(() {
            map = doc.data();
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _fetchProductData();
    return Padding(
      padding: const EdgeInsets.only(
        top: 0,
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            margin: const EdgeInsets.all(21),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                  viewportFraction: 1,
                  autoPlay: true,
                  height: MediaQuery.of(context).size.height * 0.24,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  }),
              items: imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 1,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: Colors.white),
                      child: ClipRRect(
                        child: Image.network(
                          i,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Positioned(
            bottom: height(context) * 0.05,
            child: buildPage(),
          )
        ],
      ),
    );
  }

  Widget buildPage() => AnimatedSmoothIndicator(
      activeIndex: _current,
      count: imageList.length,
      effect: const WormEffect(
          activeDotColor: Colors.white, dotHeight: 8, dotWidth: 8));
}
