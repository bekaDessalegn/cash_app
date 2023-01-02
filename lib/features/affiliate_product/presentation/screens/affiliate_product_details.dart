import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_product/presentation/widgets/affiliate_product_details_body.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/error_box.dart';
import 'package:cash_app/features/common_widgets/loading_box.dart';
import 'package:cash_app/features/common_widgets/share_product_dialog.dart';
import 'package:cash_app/features/common_widgets/socket_error_widget.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_event.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
class MobileAffiliateProductDetails extends StatefulWidget {

  String productId;
  MobileAffiliateProductDetails({required this.productId});

  @override
  State<MobileAffiliateProductDetails> createState() => _MobileAffiliateProductDetailsState();
}

class _MobileAffiliateProductDetailsState extends State<MobileAffiliateProductDetails> {

  @override
  void initState() {
    final productDetails = BlocProvider.of<SingleProductBloc>(context);
    productDetails.add(GetSingleProductEvent(widget.productId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(child: mobileAffiliateHeader(context: context), preferredSize: Size.fromHeight(60)),
      body: BlocBuilder<SingleProductBloc, SingleProductState>(builder: (_, state) {
        if (state is GetSingleProductSuccessful) {
          return AffiliateProductDetailsBody(product: state.product);
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
                    return shareProductDialog(context: context, product: product);
                  });
            },
            child: Text(
              "Share",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: onPrimaryColor,
                  fontSize: 20),
            )),
      ),
    );
  }
}
