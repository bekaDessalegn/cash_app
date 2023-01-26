import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/about_us/data/models/about_content.dart';
import 'package:cash_app/features/about_us/data/models/local_about_us.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_bloc.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_event.dart';
import 'package:cash_app/features/about_us/presentation/blocs/about_us_state.dart';
import 'package:cash_app/features/about_us/presentation/widgets/how_affiliate_withus_video.dart';
import 'package:cash_app/features/about_us/presentation/widgets/normal_header.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:cash_app/features/common_widgets/customer_header.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/loading_box.dart';
import 'package:cash_app/features/common_widgets/products_box.dart';
import 'package:cash_app/features/common_widgets/quill_shower.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:cash_app/features/products/data/models/local_products.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:cash_app/features/products/presentation/widgets/local_product_list_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class AboutBody extends StatefulWidget {
  const AboutBody({Key? key}) : super(key: key);

  @override
  State<AboutBody> createState() => _AboutBodyState();
}

class _AboutBodyState extends State<AboutBody> {

  bool isScrolled = false;

  var heroDescriptionController = quill.QuillController.basic();
  var howToBuyFromUsController = quill.QuillController.basic();
  var howToAffiliateWithUsController = quill.QuillController.basic();
  var emptyController = quill.QuillController.basic();

  late ScrollController scrollController;

  static String? convertUrlToId(String url, {bool trimWhitespaces = true}) {
    if (!url.contains("http") && (url.length == 11)) return url;
    if (trimWhitespaces) url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  @override
  void initState() {
    scrollController = ScrollController()..addListener(() {
      if (scrollController.offset >= 120) {
        setState(() {
          isScrolled = true;
        });
      } else {
        setState(() {
          isScrolled = false;
        });
      }
      });
    final aboutUs = BlocProvider.of<AboutUsContentBloc>(context);
    aboutUs.add(GetAboutUsContentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AboutUsContentBloc, AboutUsContentState>(
        listener: (_, state){
          if(state is GetAboutUsContentSuccessfulState){
            var heroDescriptionJSON = jsonDecode(state.aboutUsContent.heroDescription);
            heroDescriptionController = quill.QuillController(
                document: quill.Document.fromJson(heroDescriptionJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToAffiliateWithUsJSON = jsonDecode(state.aboutUsContent.howToAffiliateWithUsDescription);
            howToAffiliateWithUsController = quill.QuillController(
                document: quill.Document.fromJson(howToAffiliateWithUsJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToBuyFromUsJSON = jsonDecode(state.aboutUsContent.howToBuyFromUsDescription);
            howToBuyFromUsController = quill.QuillController(
                document: quill.Document.fromJson(howToBuyFromUsJSON),
                selection: TextSelection.collapsed(offset: 0));
          } else if(state is GetAboutUsContentSocketErrorState){
            var heroDescriptionJSON = jsonDecode(state.aboutUsContent.heroDescription);
            heroDescriptionController = quill.QuillController(
                document: quill.Document.fromJson(heroDescriptionJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToAffiliateWithUsJSON = jsonDecode(state.aboutUsContent.howToAffiliateWithUsDescription);
            howToAffiliateWithUsController = quill.QuillController(
                document: quill.Document.fromJson(howToAffiliateWithUsJSON),
                selection: TextSelection.collapsed(offset: 0));
            var howToBuyFromUsJSON = jsonDecode(state.aboutUsContent.howToBuyFromUsDescription);
            howToBuyFromUsController = quill.QuillController(
                document: quill.Document.fromJson(howToBuyFromUsJSON),
                selection: TextSelection.collapsed(offset: 0));
          }
        },
        builder: (_, state) {
          if (state is GetAboutUsContentLoadingState) {
            return Center(
              child: loadingBox(),
            );
          } else if (state is GetAboutUsContentSuccessfulState) {
            return aboutBody(aboutUsContent: state.aboutUsContent);
          } else if(state is GetAboutUsContentSocketErrorState){
            return localAboutBody(aboutUsContent: state.aboutUsContent);
          } else if (state is GetAboutUsContentFailedState) {
            return Center(
              child: SizedBox(
                height: 220,
                child: errorBox(onPressed: () {
                  final aboutUs = BlocProvider.of<AboutUsContentBloc>(context);
                  aboutUs.add(GetAboutUsContentEvent());
                }),
              ),
            );
          } else {
            return SizedBox();
          }
        });
  }

  Widget aboutBody({required AboutUsContent aboutUsContent}){
    return Column(
      children: [
        isScrolled ? customerHeader(context: context) : SizedBox(),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                isScrolled ? SizedBox() : normalHeader(heroShortTitle: aboutUsContent.heroShortTitle, heroLongTitle: aboutUsContent.heroLongTitle),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Image.network(
                    "$baseUrl${aboutUsContent.heroImage.path}",
                    width: double.infinity,
                    height: 180,
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        height: 180,
                        width: double.infinity,
                        decoration:
                        BoxDecoration(border: Border.all(color: surfaceColor)),
                      );
                    },
                  ),
                ),
                SizedBox(height: 45,),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: primaryColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reliable",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Affordable",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Ontime",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Warranty",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 0,
                          child: quill.QuillEditor.basic(controller: emptyController, readOnly: true)),
                      SizedBox(height: 40,),
                      BlocBuilder<NewInStoreBloc, NewInStoreState>(builder: (_, state) {
                        if (state is NewInStoreSuccessful) {
                          return state.products.length == 0
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New in store",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: onBackgroundColor,
                                    fontSize: 20),
                              ),
                              newInStore(products: state.products),
                            ],
                          );
                        } else if (state is NewInStoreFailed) {
                          return Center(
                            child: errorBox(onPressed: () {
                              final products = BlocProvider.of<NewInStoreBloc>(context);
                              products.add(NewInStoreProductsEvent());
                            }),
                          );
                        } else if (state is NewInStoreLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New in store",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: onBackgroundColor,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              loadingNewInStore(),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(""),
                          );
                        }
                      }),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Who are we?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          "$baseUrl${aboutUsContent.whoAreWeImage.path}",
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 160,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              width: double.infinity,
                              height: 160,
                              decoration: BoxDecoration(
                                  border: Border.all(color: surfaceColor)
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10,),
                      QuillShowerWidget(quillContent: aboutUsContent.whoAreWeDescription,),
                      SizedBox(height: 20,),
                      BlocBuilder<FeaturedBloc, FeaturedState>(builder: (_, state) {
                        if (state is FilterFeatureStateSuccessful) {
                          return state.products.length == 0
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              featuredProducts(products: state.products),
                            ],
                          );
                        } else if(state is FeaturedSocketErrorState){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              localFeaturedProductListView(localProducts: state.localProducts),
                            ],
                          );
                        }
                        else if (state is FilterFeatureStateFailed) {
                          return Center(
                            child: errorBox(onPressed: () {
                              final products = BlocProvider.of<FeaturedBloc>(context);
                              products.add(FilterFeaturedEvent());
                            }),
                          );
                        } else if (state is FilterFeatureStateLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              loadingFeatured(),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(""),
                          );
                        }
                      }),
                      SizedBox(height: 30,),
                      Text(
                        "How to buy from us?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      quill.QuillEditor.basic(controller: howToBuyFromUsController, readOnly: true),
                      SizedBox(height: 40,),
                      Text(
                        "How to affiliate and earn with us?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      quill.QuillEditor.basic(controller: howToAffiliateWithUsController, readOnly: true),
                      SizedBox(height: 10,),
                      Text(
                        "We have a video for it",
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10,),
                      YoutubeVideo(youtubeId: convertUrlToId(aboutUsContent.howToAffiliateWithUsVideoLink)!,),
                      // HowToAffiliateWithUsFrame(url: convertUrlToId(aboutUsContent.howToAffiliateWithUsVideoLink)!, frameHeight: 170, frameWidth: double.infinity,),
                      SizedBox(height: 25,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              context.go(APP_PAGE.product.toPath);
                            },
                            child: Text(
                              "Explore products",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: onPrimaryColor,
                                  fontSize: 20),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: primaryColor)),
                            ),
                            onPressed: () {
                              context.push(APP_PAGE.signup.toPath);
                            },
                            child: Text(
                              "Earn with us",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget newInStore({required List<Products> products}) {
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 260),
        itemBuilder: (context, index) {
          return productsBox(context: context, product: products[index]);
        });
  }

  Widget loadingNewInStore() {
    return Container(
      height: 285,
      margin: EdgeInsets.only(left: 20),
      child: ListView.builder(
          itemCount: 8,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              width: 300,
              height: 200,
              margin: EdgeInsets.fromLTRB(0, 10, 50, 10),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 2.0,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget featuredProducts({required List<Products> products}) {
    return GridView.builder(
        itemCount: products.length,
        shrinkWrap: true,
        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 260),
        itemBuilder: (context, index) {
          return productsBox(context: context, product: products[index]);
        });
  }

  Widget localFeaturedProductListView({required List<LocalProducts> localProducts}) {
    return GridView.builder(
        itemCount: localProducts.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 260),
        itemBuilder: (context, index) {
          return localProductListBox(context: context, product: localProducts[index],);
        });
  }

  Widget loadingFeatured(){
    return GridView.builder(
        itemCount: 6,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 280),
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            height: 220,
            margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 1.0), //(x,y)
                  blurRadius: 2.0,
                ),
              ],
            ),
          );
        }
    );
  }

  Widget localAboutBody({required LocalAboutUsContent aboutUsContent}){
    return Column(
      children: [
        isScrolled ? customerHeader(context: context) : SizedBox(),
        Expanded(
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                isScrolled ? SizedBox() : normalHeader(heroShortTitle: aboutUsContent.heroShortTitle, heroLongTitle: aboutUsContent.heroLongTitle),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BlinkContainer(width: double.infinity, height: 180, borderRadius: 0),
                ),
                SizedBox(height: 45,),
                Container(
                  height: 50,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: primaryColor
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Reliable",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Affordable",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Ontime",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      ),
                      Text(
                        "|",
                        style: TextStyle(
                          color: onPrimaryColor,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        "Warranty",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: onPrimaryColor,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                          height: 0,
                          child: quill.QuillEditor.basic(controller: emptyController, readOnly: true)),
                      SizedBox(height: 40,),
                      BlocBuilder<NewInStoreBloc, NewInStoreState>(builder: (_, state) {
                        if (state is NewInStoreSuccessful) {
                          return state.products.length == 0
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New in store",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: onBackgroundColor,
                                    fontSize: 20),
                              ),
                              newInStore(products: state.products),
                            ],
                          );
                        } else if (state is NewInStoreFailed) {
                          return Center(
                            child: errorBox(onPressed: () {
                              final products = BlocProvider.of<NewInStoreBloc>(context);
                              products.add(NewInStoreProductsEvent());
                            }),
                          );
                        } else if(state is NewInStoreSocketError){
                          return state.products.length == 0
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New in store",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: onBackgroundColor,
                                    fontSize: 20),
                              ),
                              localFeaturedProductListView(localProducts: state.products),
                            ],
                          );
                        } else if (state is NewInStoreLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "New in store",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: onBackgroundColor,
                                    fontSize: 20),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              loadingNewInStore(),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(""),
                          );
                        }
                      }),
                      SizedBox(
                        height: 35,
                      ),
                      Text(
                        "Who are we?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: BlinkContainer(width: double.infinity, height: 160, borderRadius: 0),
                      ),
                      SizedBox(height: 10,),
                      QuillShowerWidget(quillContent: aboutUsContent.whoAreWeDescription,),
                      SizedBox(height: 20,),
                      BlocBuilder<FeaturedBloc, FeaturedState>(builder: (_, state) {
                        if (state is FilterFeatureStateSuccessful) {
                          return state.products.length == 0
                              ? SizedBox()
                              : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              featuredProducts(products: state.products),
                            ],
                          );
                        } else if(state is FeaturedSocketErrorState){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              localFeaturedProductListView(localProducts: state.localProducts),
                            ],
                          );
                        }
                        else if (state is FilterFeatureStateFailed) {
                          return Center(
                            child: errorBox(onPressed: () {
                              final products = BlocProvider.of<FeaturedBloc>(context);
                              products.add(FilterFeaturedEvent());
                            }),
                          );
                        } else if (state is FilterFeatureStateLoading) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              loadingFeatured(),
                            ],
                          );
                        } else {
                          return Center(
                            child: Text(""),
                          );
                        }
                      }),
                      SizedBox(height: 30,),
                      Text(
                        "How to buy from us?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      quill.QuillEditor.basic(controller: howToBuyFromUsController, readOnly: true),
                      SizedBox(height: 40,),
                      Text(
                        "How to affiliate and earn with us?",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10,),
                      quill.QuillEditor.basic(controller: howToAffiliateWithUsController, readOnly: true),
                      SizedBox(height: 10,),
                      Text(
                        "We have a video for it",
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontSize: 22,
                        ),
                      ),
                      SizedBox(height: 10,),
                      YoutubeVideo(youtubeId: convertUrlToId(aboutUsContent.howToAffiliateWithUsVideoLink)!,),
                      // HowToAffiliateWithUsFrame(url: convertUrlToId(aboutUsContent.howToAffiliateWithUsVideoLink)!, frameHeight: 170, frameWidth: double.infinity,),
                      SizedBox(height: 25,),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              context.go(APP_PAGE.product.toPath);
                            },
                            child: Text(
                              "Explore products",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: onPrimaryColor,
                                  fontSize: 20),
                            )),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              backgroundColor: backgroundColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: primaryColor)),
                            ),
                            onPressed: () {
                              context.push(APP_PAGE.signup.toPath);
                            },
                            child: Text(
                              "Earn with us",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                  fontSize: 20),
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,)
              ],
            ),
          ),
        ),
      ],
    );
  }

}