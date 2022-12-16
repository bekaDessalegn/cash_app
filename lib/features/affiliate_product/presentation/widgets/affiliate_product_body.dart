import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_product/data/models/selected_affiliate_categories.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_all_product_box.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_product_box.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_search_widget.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/error_failed_widget.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/loading_box.dart';
import 'package:cash_app/features/common_widgets/no_data_box.dart';
import 'package:cash_app/features/common_widgets/product_search_widget.dart';
import 'package:cash_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:cash_app/features/home/presentation/blocs/home_event.dart';
import 'package:cash_app/features/home/presentation/blocs/home_state.dart';
import 'package:cash_app/features/products/data/models/categories.dart';
import 'package:cash_app/features/products/data/models/product_image.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:cash_app/features/products/data/models/selectedCategory.dart';
import 'package:cash_app/features/products/presentation/blocs/categories/categories_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/categories/categories_event.dart';
import 'package:cash_app/features/products/presentation/blocs/categories/categories_state.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_event.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/mi.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class AffiliateProductBody extends StatefulWidget {
  const AffiliateProductBody({Key? key}) : super(key: key);

  @override
  State<AffiliateProductBody> createState() => _AffiliateProductBodyState();
}

class _AffiliateProductBodyState extends State<AffiliateProductBody> {

  final _prefs = PrefService();

  String? value;

  List<String> filter = ["Latest", "Old"];

  bool isCategoryLoading = false;

  final searchController = TextEditingController();

  late ScrollController _allProductsController;
  late ScrollController scrollController;

  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool _isFirstLoadRunning = false;

  int _allProductsIndex = 0;
  int _skip = 9;

  List<Products> _allProducts = [];
  List fetchedProducts = [];

  final categoryScrollController = ItemScrollController();
  final categoryItemListener = ItemPositionsListener.create();
  int categoryItemPosition = 0;
  int categoryLast = 0;

  List<Categories> categoryList = [Categories(categoryName: "All products")];
  int selectedCategoryIndex = 0;

  void loadMore() async {
    print("The fetched products");
    print(fetchedProducts.length);
    print(_allProductsIndex);
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        _allProductsController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _allProductsIndex += 1;
      final skipNumber = _allProductsIndex * _skip;
      final moreProducts = BlocProvider.of<ProductsBloc>(context);

      if (categoryList[selectedCategoryIndex].categoryName == "All products") {
        moreProducts.add(GetMoreProductsForListEvent(skipNumber));
      } else {
        moreProducts.add(FilterMoreProductsByCategoryEvent(
            categoryList[selectedCategoryIndex].categoryName, skipNumber));
      }

      if (fetchedProducts.isNotEmpty) {
        print("adfGHJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJjjj");
        print(_allProductsIndex);
        setState(() {});
      } else {
        setState(() {
          _hasNextPage = false;
        });
      }
      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });

    final firstProductsLoad = BlocProvider.of<ProductsBloc>(context);
    firstProductsLoad.add(GetProductsForListEvent(0));

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  void categoryListener() {
    categoryItemListener.itemPositions.addListener(() {
      final indices = categoryItemListener.itemPositions.value
          .where((element) {
        final isRightVisible = element.itemLeadingEdge >= 0;
        final isLeftVisible = element.itemTrailingEdge <= 1;

        return isRightVisible && isLeftVisible;
      })
          .map((e) => e.index)
          .toList();

      setState(() {
        categoryLast = indices.last;
      });
    });
  }

  void welcome() async {
    await Future.delayed(Duration(milliseconds: 50), () {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await showDialog(context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return Dialog(child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset("images/welcome_left.png", width: 80, height: 110,),
                                Image.asset("images/welcome_right.png", width: 80, height: 110,),
                              ],
                            ),
                            SizedBox(height: 10,),
                            Center(
                              child: RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'WELCOME to',
                                  style: GoogleFonts.quicksand(
                                      fontSize: 26,
                                    color: onBackgroundColor
                                  ),
                                  children: const <TextSpan>[
                                    TextSpan(text: ' cash_app Mart', style: TextStyle(color: primaryColor, fontSize: 26,fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 15,),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Congratulations! you have earned',
                                style: GoogleFonts.quicksand(
                                    fontSize: 18,
                                    color: onBackgroundColor
                                ),
                                children: <TextSpan>[
                                  TextSpan(text: ' 100 ETB', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                                  TextSpan(text: ' joining bonus.', style: TextStyle(fontSize: 18)),
                                ],
                              ),
                            ),
                            SizedBox(height: 30,),
                            ElevatedButton(onPressed: () async {
                              isWelcome = false;
                              await _prefs.removeJoiningBonus();
                              Navigator.pop(context);
                            },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primaryColor
                                ),
                                child: Text("Ok, thanks", style: TextStyle(color: onPrimaryColor),))
                          ],
                        ),
                      )
                    ),);
                  }
              );
            });
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    categoryListener();
    _firstLoad();
    _allProductsController = ScrollController()..addListener(loadMore);
    scrollController = ScrollController()..addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        loadMore();
      }});
    final categories = BlocProvider.of<CategoriesBloc>(context);
    categories.add(GetCategoriesEvent());
    if(isWelcome){
      welcome();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10,),
                Text(
                  "Products",
                  style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 28,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          final searchProducts = BlocProvider.of<SearchProductBloc>(context);
                          searchProducts.add(SearchProductEvent(value));
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(color: onBackgroundColor),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(0),
                          filled: true,
                          fillColor: surfaceColor,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none
                          ),
                          hintText: "Search....",
                          hintStyle: TextStyle(
                              color: textInputPlaceholderColor
                          ),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor: textInputPlaceholderColor,
                        ),
                      ),
                    ),
                    // Container(
                    //   width: 40,
                    //   margin: EdgeInsets.only(right: 10),
                    //   child: DropdownButtonHideUnderline(
                    //     child: DropdownButton<String>(
                    //       icon: Visibility(visible: false, child: Icon(Icons.arrow_downward)),
                    //       // value: values,
                    //       isExpanded: true,
                    //       hint: Iconify(Mi.filter, size: 40, color: onBackgroundColor,),
                    //       focusColor: Colors.transparent,
                    //       items: filter.map(buildMenuLocation).toList(),
                    //       onChanged: (value) => setState(() {
                    //         this.value = value;
                    //         print(value);
                    //       }),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          BlocConsumer<SearchProductBloc, SearchState>(builder: (_, state){
            if(state is SearchProductSuccessful){
              if(searchController.text == ""){
                return buildInitialInput(context: context);
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  children: [
                    affiliateSearchProducts(products: state.product),
                    SizedBox(height: MediaQuery.of(context).size.height - 200,)
                  ],
                ),
              );
            }
            else if(state is SearchProductLoading){
              return Column(
                children: [
                  Center(child: CircularProgressIndicator(color: primaryColor,),),
                  SizedBox(height: MediaQuery.of(context).size.height - 200,)
                ],
              );
            }
            else{
              return buildInitialInput(context: context);
            }
          }, listener: (_, state){
            if(state is SearchProductFailed){
              buildErrorLayout(context: context, message: state.errorType);
            }
          }),
          Container(
            height: 6,
            color: primaryColor,
            width: double.infinity,
          )
        ],
      ),
    );
  }

  Widget buildInitialInput({required BuildContext context}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: BlocBuilder<FeaturedBloc, FeaturedState>(builder: (_, state){
                if(state is FilterFeatureStateSuccessful){
                  return state.products.length == 0 ? SizedBox() : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text(
                        "Featured Products",
                        style: TextStyle(
                            color: onBackgroundColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      affiliateFeaturedProducts(products: state.products),
                    ],
                  );
                }
                else if(state is FilterFeatureStateFailed){
                  return Center(
                    child: errorBox(onPressed: (){
                      final products =
                      BlocProvider.of<FeaturedBloc>(context);
                      products.add(FilterFeaturedEvent());
                    }),
                  );
                } else if(state is FilterFeatureStateLoading){
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
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
                }
                else{
                  return Center(child: Text(""),);
                }
              }),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: BlocBuilder<TopSellerBloc, TopSellerState>(builder: (_, state){
            if(state is FilterTopSellerStateSuccessful){
              return state.products.length == 0 ? SizedBox() : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "Top Seller Products",
                    style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  affiliateFeaturedProducts(products: state.products),
                  SizedBox(height: 20,),
                ],
              );
            }
            else if(state is FilterTopSellerStateFailed){
              return Center(child: errorBox(onPressed: (){
                final products =
                BlocProvider.of<TopSellerBloc>(context);
                products.add(FilterTopSellerEvent());
              }),);
            } else if(state is FilterTopSellerStateLoading){
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "Top Seller Products",
                    style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  loadingFeatured(),
                  SizedBox(height: 20,),
                ],
              );
            }
            else{
              return Center(child: Text(""),);
            }
          }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "All products",
                style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  categoryItemPosition == 0
                      ? SizedBox()
                      : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              categoryItemPosition -= 1;
                            });
                            categoryScrollController.scrollTo(
                                index: categoryItemPosition,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Icon(
                            Icons.navigate_before_sharp,
                            color: primaryColor,
                          ))),
                  Expanded(
                    child: BlocConsumer<CategoriesBloc, CategoriesState>(
                        builder: (_, state) {
                          if (state is GetCategoriesSuccessful) {
                            return buildCategories();
                          } else {
                            return buildCategories();
                          }
                        },
                        listener: (_, state) {
                          if(state is GetCategoriesSuccessful){
                            setState(() {
                              categoryList.addAll(state.categories);
                            });
                          }
                        }),
                  ),
                  categoryLast == categoryList.length - 1
                      ? SizedBox()
                      : MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              categoryItemPosition += 1;
                            });
                            categoryScrollController.scrollTo(
                                index: categoryItemPosition,
                                duration: Duration(milliseconds: 500),
                                curve: Curves.easeIn);
                          },
                          child: Icon(
                            Icons.navigate_next_sharp,
                            color: primaryColor,
                          ))),
                ],
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: _isFirstLoadRunning? const Center(
            child: CircularProgressIndicator(color: primaryColor,),
          ): BlocConsumer<ProductsBloc, ProductsState>(
              listener: (_, state){
                if(state is GetProductsSuccessful){
                  _allProducts.addAll(state.products);
                  fetchedProducts = state.products;
                  isCategoryLoading = false;
                } else if(state is GetProductsLoading){
                  isCategoryLoading = true;
                }
              },
              builder: (_, state){
                if(state is GetProductsSuccessful){
                  return _allProducts.isEmpty
                      ? Center(child: noDataBox(text: "No Products!", description: "Products will appear here."))
                      : affiliateAllProducts();
                } else if(state is GetProductsLoading){
                  return Center(child: loadingBox(),);
                }
                else if(state is GetProductsFailed){
                  return Center(
                    child: errorBox(onPressed: (){
                      final products =
                      BlocProvider.of<ProductsBloc>(context);
                      products.add(GetProductsForListEvent(0));
                      final categories = BlocProvider.of<CategoriesBloc>(context);
                      categories.add(GetCategoriesEvent());
                    }),
                  );
                }
                else{
                  return Center(child: Text(""),);
                }
              }),
        ),
        SizedBox(height: 20,)
      ],
    );
  }

  Widget affiliateFeaturedProducts({required List<Products> products}){
    return SizedBox(
      height: 348,
      child: ListView.builder(
          itemCount: products.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return affiliateProductsBox(context: context, product: products[index]);
          }),
    );
  }

  Widget affiliateAllProducts(){
    return Column(
      children: [
        MediaQuery.of(context).size.width > 600
            ? GridView.builder(
            controller: _allProductsController,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 360),
            itemCount: _allProducts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: affiliateAllProductsBox(context: context, product: _allProducts[index]),
              );
            })
            : ListView.builder(
            controller: _allProductsController,
            itemCount: _allProducts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return affiliateAllProductsBox(context: context, product: _allProducts[index]);
            }),
        if (_isLoadMoreRunning == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(color: primaryColor,),
            ),
          ),
      ],
    );
  }

  Widget affiliateSearchProducts({required List<Products> products}){
    return products.isEmpty ? Column(
      children: [
        Center(child: noDataBox(text: "No result found!", description: "please try another name.")),
        SizedBox(height: MediaQuery.of(context).size.height - 200,)
      ],
    ) : MediaQuery.of(context).size.width > 600
        ? GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisExtent: 360),
        itemCount: products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: affiliateAllProductsBox(context: context, product: products[index]),
          );
        })
        : ListView.builder(
        itemCount: products.length,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return affiliateAllProductsBox(context: context, product: products[index]);
        });
  }

  Widget buildCategories() {
    return SizedBox(
      height: 32,
      child: ScrollablePositionedList.builder(
          itemScrollController: categoryScrollController,
          itemPositionsListener: categoryItemListener,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index) {
            return Consumer<SelectedAffiliateCategory>(
              builder: (context, data, child) => MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    if(!isCategoryLoading){
                      _hasNextPage = true;
                      setState(() {
                        selectedCategoryIndex = index;
                      });
                      _allProducts = [];
                      _allProductsIndex = 0;
                      data.selectedIndex(index);
                      final filterProductsByCategory = BlocProvider.of<ProductsBloc>(context);
                      if(categoryList[index].categoryName == "All products"){
                        filterProductsByCategory.add(GetProductsForListEvent(0));
                      }
                      else{
                        print("The index is: ");
                        print(index);
                        filterProductsByCategory.add(FilterProductsByCategoryEvent(categoryList[index].categoryName, 0));
                      }
                    }
                  },
                  child: Container(
                    height: 32,
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: data.index == index
                            ? primaryColor
                            : backgroundColor,
                        border: Border.all(color: primaryColor, width: 1.0),
                        borderRadius: BorderRadius.circular(20)),
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          categoryList[index].categoryName,
                          style: TextStyle(
                              fontSize: 16,
                              color: data.index == index
                                  ? onPrimaryColor
                                  : onBackgroundColor),
                        )),
                  ),
                ),
              ),
            );
          }),
    );
  }

  DropdownMenuItem<String> buildMenuLocation(String filter) => DropdownMenuItem(
    value: filter,
    child: Text(
      filter,
      style: TextStyle(
        color: onBackgroundColor,
        fontSize: 14,
      ),
    ),
  );

  Widget loadingFeatured(){
    return SizedBox(
      height: 348,
      child: ListView.builder(
          itemCount: 6,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Container(
              width: 249,
              height: 285,
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
          }
      ),
    );
  }

}