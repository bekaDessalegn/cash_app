import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/common_widgets/customer_header.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/loading_box.dart';
import 'package:cash_app/features/common_widgets/order_dialog.dart';
import 'package:cash_app/features/common_widgets/socket_error_widget.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_event.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_state.dart';
import 'package:cash_app/features/products/presentation/widgets/product_details_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class MobileProductDetails extends StatefulWidget {

  String productId;
  MobileProductDetails(this.productId,);

  @override
  State<MobileProductDetails> createState() => _MobileProductDetailsState();
}

class _MobileProductDetailsState extends State<MobileProductDetails> {

  final _prefs = PrefService();

  @override
  void initState() {
    final productDetails = BlocProvider.of<SingleProductBloc>(context);
    productDetails.add(GetSingleProductEvent(widget.productId));
    final affLink = Uri.base.queryParameters['aff'];
    if(affLink.toString() != "null"){
      _prefs.createAffiliateLink(affLink!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: customerHeader(context: context), preferredSize: Size.fromHeight(60)),
      body: WillPopScope(
        onWillPop: () async {
          context.go(APP_PAGE.product.toPath);
          return false;
        },
        child: BlocBuilder<SingleProductBloc, SingleProductState>(builder: (_, state) {
          if (state is GetSingleProductSuccessful) {
            return ProductDetailsBody(product: state.product);
          } else if(state is GetSingleProductSocketError){
            return Center(child: socketErrorWidget(onPressed: (){
              final productDetails = BlocProvider.of<SingleProductBloc>(context);
              productDetails.add(GetSingleProductEvent(widget.productId));
            }),);
          } else if (state is GetSingleProductFailed) {
            return Center(
              child: errorBox(onPressed: (){
                final products =
                BlocProvider.of<SingleProductBloc>(context);
                products.add(GetSingleProductEvent(widget.productId));
              }),
            );
          } else if (state is GetSingleProductLoading) {
            return Center(child: loadingBox(),);
          } else {
            return Center(child: Text(""));
          }
        }),
      ),
      bottomNavigationBar: BlocConsumer<SingleProductBloc, SingleProductState>(builder: (_, state){
        if(state is GetSingleProductSuccessful){
          return bottomNav(product: state.product);
        } else{
          return SizedBox();
        }
      }, listener: (_, state){

      }),
    );
  }

  Widget bottomNav({required Products product}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10))),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context){
                    return orderDialog(context: context, product: product);
                  });
            },
            child: Text(
              "Order",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: onPrimaryColor,
                  fontSize: 20),
            )),
      ),
    );
  }

}
