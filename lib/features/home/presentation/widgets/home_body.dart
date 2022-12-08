import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/features/about_us/presentation/widgets/who_we_are_frame.dart';
import 'package:cash_app/features/common_widgets/all_products_box.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/error_failed_widget.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/footer.dart';
import 'package:cash_app/features/common_widgets/mobile_end_drawer.dart';
import 'package:cash_app/features/common_widgets/mobile_header.dart';
import 'package:cash_app/features/common_widgets/products_box.dart';
import 'package:cash_app/features/common_widgets/youtube_error_layout.dart';
import 'package:cash_app/features/home/data/models/home_content.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:cash_app/features/home/presentation/widgets/bullet_list.dart';
import 'package:cash_app/features/home/presentation/widgets/home_iframe.dart';
import 'package:cash_app/features/products/data/models/product_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  var heroDescriptionController = quill.QuillController.basic();
  var whyUsDescriptionController = quill.QuillController.basic();

  @override
  void initState() {
    final homeContent = BlocProvider.of<HomeContentBloc>(context);
    homeContent.add(GetHomeContentEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeContentBloc, HomeContentState>(
        listener: (_, state) {
      if (state is GetHomeContentSuccessfulState) {
        var heroDescriptionJSON = jsonDecode(state.homeContent.heroDescription);
        heroDescriptionController = quill.QuillController(
            document: quill.Document.fromJson(heroDescriptionJSON),
            selection: TextSelection.collapsed(offset: 0));
        var whyUsDescriptionJSON =
            jsonDecode(state.homeContent.whyUsDescription);
        whyUsDescriptionController = quill.QuillController(
            document: quill.Document.fromJson(whyUsDescriptionJSON),
            selection: TextSelection.collapsed(offset: 0));
      }
    }, builder: (_, state) {
      if (state is GetHomeContentLoadingState) {
        return Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      } else if (state is GetHomeContentSuccessfulState) {
        return homeBody(homeContent: state.homeContent);
      } else if (state is GetHomeContentFailedState) {
        return Center(
          child: SizedBox(
            height: 220,
            child: errorBox(onPressed: () {
              final homeContent = BlocProvider.of<HomeContentBloc>(context);
              homeContent.add(GetHomeContentEvent());
            }),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }

  Widget homeBody({required HomeContent homeContent}) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMobileHeader(context: context),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Image.network(
              "$baseUrl${homeContent.heroImage.path}",
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
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  homeContent.heroShortTitle,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 17,
                  ),
                ),
                Text(
                  homeContent.heroLongTitle,
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 33,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15,
                ),
                quill.QuillEditor.basic(
                    controller: heroDescriptionController, readOnly: true),
                SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        context.go(APP_PAGE.product.toPath);
                      },
                      child: Text(
                        "Shop Now",
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
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: backgroundColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: primaryColor)),
                      ),
                      onPressed: () {
                        context.go(APP_PAGE.signup.toPath);
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
          BlocBuilder<NewInStoreBloc, NewInStoreState>(builder: (_, state) {
            if (state is NewInStoreSuccessful) {
              return state.products.length == 0
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 70,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "New in store",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: onBackgroundColor,
                                fontSize: 20),
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                  SizedBox(
                    height: 70,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "New in store",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onBackgroundColor,
                          fontSize: 20),
                    ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Reliable",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onBackgroundColor,
                          fontSize: 15),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Affordable",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onBackgroundColor,
                          fontSize: 15),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Ontime",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onBackgroundColor,
                          fontSize: 15),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Warranty",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: onBackgroundColor,
                          fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  height: 35,
                ),
                Text(
                  "why us",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 18,
                  ),
                ),
                Text(
                  homeContent.whyUsTitle,
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                quill.QuillEditor.basic(
                    controller: whyUsDescriptionController, readOnly: true),
                SizedBox(
                  height: 10,
                ),
                Image.network(
                  "$baseUrl${homeContent.whyUsImage.path}",
                  width: double.infinity,
                  height: 187,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 187,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(color: surfaceColor)),
                    );
                  },
                ),
                BlocBuilder<TopSellerBloc, TopSellerState>(builder: (_, state) {
                  if (state is FilterTopSellerStateSuccessful) {
                    return state.products.length == 0
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                "Top seller products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 21,
                                    fontWeight: FontWeight.bold),
                              ),
                              featured(products: state.products),
                            ],
                          );
                  } else if (state is FilterTopSellerStateFailed) {
                    return Center(
                      child: errorBox(onPressed: () {
                        final products =
                            BlocProvider.of<TopSellerBloc>(context);
                        products.add(FilterTopSellerEvent());
                      }),
                    );
                  } else if (state is FilterTopSellerStateLoading) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 35,
                        ),
                        Text(
                          "Top seller products",
                          style: TextStyle(
                              color: onBackgroundColor,
                              fontSize: 21,
                              fontWeight: FontWeight.bold),
                        ),
                        loadingFeatured()
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
                  "What Makes Us Unique?",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
                ListView.builder(
                    itemCount: homeContent.whatMakesUsUnique.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return bulletList(
                          text: "${homeContent.whatMakesUsUnique[index]}");
                    }),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    context.go(APP_PAGE.product.toPath);
                  },
                  child: Text(
                    "Browse Our Products",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      fontSize: 18,
                    ),
                  ),
                ),
                BlocBuilder<FeaturedBloc, FeaturedState>(builder: (_, state) {
                  if (state is FilterFeatureStateSuccessful) {
                    return state.products.length == 0
                        ? SizedBox()
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 35,
                              ),
                              Text(
                                "Our favourites",
                                style: TextStyle(
                                  color: onBackgroundColor,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Featured Products",
                                style: TextStyle(
                                    color: onBackgroundColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                              featured(products: state.products),
                            ],
                          );
                  } else if (state is FilterFeatureStateFailed) {
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
                          height: 35,
                        ),
                        Text(
                          "Our favourites",
                          style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          "Featured Products",
                          style: TextStyle(
                              color: onBackgroundColor,
                              fontSize: 24,
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
                SizedBox(
                  height: 35,
                ),
                GridView.builder(
                    itemCount: homeContent.brands.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5, mainAxisExtent: 50),
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5),
                        child: brandsSection(
                            brandImageLink:
                                "$baseUrl${homeContent.brands[index]["logoImage"]["path"]}",
                            brandUrl: "${homeContent.brands[index]["link"]}"),
                      );
                    }),
                SizedBox(
                  height: 30,
                ),
                // videoPlayerWidget(controller: controller)
              ],
            ),
          ),
          footer(context: context)
        ],
      ),
    );
  }

  Widget brandsSection(
      {required String brandImageLink, required String brandUrl}) {
    return GestureDetector(
        onTap: () async {
          final url = Uri.parse(brandUrl);

          if (await canLaunchUrl(url)) {
            await launchUrl(url);
          }
        },
        child: Image.network(
          brandImageLink,
          fit: BoxFit.fill,
          loadingBuilder: (BuildContext context, Widget child,
              ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: surfaceColor)
              ),
            );
          },
        ));
  }

  Widget newInStore({required List<Products> products}) {
    return Container(
      height: 318,
      margin: EdgeInsets.only(left: 20),
      child: ListView.builder(
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return productsBox(context: context, product: products[index]);
          }),
    );
  }

  Widget featured({required List<Products> products}) {
    return MediaQuery.of(context).size.width > 500
        ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 350),
            itemCount: products.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child:
                    allProductsBox(context: context, product: products[index]),
              );
            })
        : ListView.builder(
            itemCount: products.length,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return allProductsBox(context: context, product: products[index]);
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

  Widget loadingFeatured() {
    return ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Divider(
                color: surfaceColor,
                thickness: 1.0,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 285,
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.all(Radius.circular(0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
