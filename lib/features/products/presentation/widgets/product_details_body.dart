import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/list_image.dart';
import 'package:cash_app/features/common_widgets/share_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailsBody extends StatefulWidget {

  Products product;
  ProductDetailsBody({required this.product});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {

  var productDescriptionController = quill.QuillController.basic();
  var emptyController = quill.QuillController.basic();

  List images = [];
  int activeIndex = 0;

  @override
  void initState() {
    var productDescriptionJSON = jsonDecode(widget.product.description!);
    productDescriptionController = quill.QuillController(
        document: quill.Document.fromJson(productDescriptionJSON),
        selection: TextSelection.collapsed(offset: 0));
    if(widget.product.mainImage!.path != "null"){
      images.add(widget.product.mainImage!.path);
    }
    for(var image in widget.product.moreImages!){
      images.add(image['path']);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  images.isEmpty
                      ? Container(
                    width: double.infinity,
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                          image: AssetImage("images/default.png"),
                          fit: BoxFit.cover),
                    ),
                  ) :
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CarouselSlider.builder(
                        options: CarouselOptions(height: 300,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) => setState(() => activeIndex = index),
                        ),
                        itemCount: images.length,
                        itemBuilder: (context, index, realIndex){
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: shareImage(urlImage: "$baseUrl${images[index]}"));
                        },
                      ),
                      SizedBox(height: 10,),
                      buildIndicator(),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.product.productName}",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${widget.product.price} ETB",
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Divider(
                    color: surfaceColor,
                    thickness: 1.0,
                  ),
                  widget.product.description == null
                      ? SizedBox()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Description",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          height: 0,
                          child: quill.QuillEditor.basic(controller: emptyController, readOnly: true)),
                      quill.QuillEditor.basic(controller: productDescriptionController, readOnly: true),
                      Divider(
                        color: surfaceColor,
                        thickness: 1.0,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(){
    return AnimatedSmoothIndicator(
      effect: WormEffect(
        dotWidth: 10,
        dotHeight: 10,
        activeDotColor: primaryColor,
        dotColor: surfaceColor
      ),
      activeIndex: activeIndex,
      count: images.length,);
  }
}