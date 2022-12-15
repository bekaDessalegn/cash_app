import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/common_widgets/list_image.dart';
import 'package:cash_app/features/common_widgets/share_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class ProductDetailsBody extends StatefulWidget {

  Products product;
  ProductDetailsBody({required this.product});

  @override
  State<ProductDetailsBody> createState() => _ProductDetailsBodyState();
}

class _ProductDetailsBodyState extends State<ProductDetailsBody> {

  var productDescriptionController = quill.QuillController.basic();
  var emptyController = quill.QuillController.basic();

  @override
  void initState() {
    var productDescriptionJSON = jsonDecode(widget.product.description!);
    productDescriptionController = quill.QuillController(
        document: quill.Document.fromJson(productDescriptionJSON),
        selection: TextSelection.collapsed(offset: 0));
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
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.product.mainImage!.path == "null"
                      ? Container(
                    width: double.infinity,
                    height: 172,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      image: DecorationImage(
                          image: AssetImage("images/default.png"),
                          fit: BoxFit.cover),
                    ),
                  )
                      : ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: shareImage(urlImage: "$baseUrl${widget.product.mainImage!.path}")),
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
                    height: 10,
                  ),
                  widget.product.moreImages!.length == 0
                      ? SizedBox()
                      : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Images",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 120,
                        child: ListView.builder(
                            itemCount: widget.product.moreImages!.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: (){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return Dialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                                        child: Image.network("$baseUrl${widget.product.moreImages![index]['path']}", fit: BoxFit.cover,),
                                      );
                                    });
                                  },
                                  child: listImage(urlImage: "$baseUrl${widget.product.moreImages![index]['path']}"),
                                ),
                              );
                            }),
                      ),
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
}