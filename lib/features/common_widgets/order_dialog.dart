import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/normal_text.dart';
import 'package:cash_app/features/common_widgets/normal_textformfield.dart';
import 'package:cash_app/features/common_widgets/order_phone_textformfield.dart';
import 'package:cash_app/features/common_widgets/small_image.dart';
import 'package:cash_app/features/products/data/models/orders.dart';
import 'package:cash_app/features/products/data/models/products.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_bloc.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_event.dart';
import 'package:cash_app/features/products/presentation/blocs/products/products_state.dart';
import 'package:cash_app/features/products/presentation/widgets/company_name_textformfield.dart';
import 'package:cash_app/features/products/presentation/widgets/phone_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:phone_form_field/phone_form_field.dart';

Widget orderDialog({required BuildContext context, required Products product}) {

  bool isSuccessful = false;

  return BlocConsumer<OrdersBloc, OrdersState>(builder: (_, state){
    if(state is PostOrdersLoadingState){
      return buildDialogInput(context: context, product: product, isLoading: true);
    } else{
      return isSuccessful ? buildSuccessfulDialog(context: context) : buildDialogInput(context: context, product: product, isLoading: false);
    }
  }, listener: (_, state){
    if(state is PostOrdersFailedState){
      buildErrorLayout(context: context, message: state.errorType);
    }
    if(state is PostOrdersSuccessfulState){
      isSuccessful = true;
    }
  });
}

final phoneController = PhoneController(null);
final fullNameController = TextEditingController();
final companyNameController = TextEditingController();

final orderFormKey = GlobalKey<FormState>();

Widget buildDialogInput({required BuildContext context, required Products product, required bool isLoading}) {

  final _prefs = PrefService();

  return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
          width: MediaQuery.of(context).size.width < 500 ? null : 430,
      height: MediaQuery.of(context).size.height - 60,
  child: SingleChildScrollView(
    child: Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, top: 10),
            child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                    onTap: isLoading ? null : (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.close, size: 23, color: onBackgroundColor,))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
          child: Form(
            key: orderFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                product.mainImage!.path == "null"
                    ? Container(
                  height: 138,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    image: DecorationImage(
                        image: AssetImage("images/default.png"),
                        fit: BoxFit.cover),
                  ),
                )
                    : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: smallImage(urlImage: "$baseUrl${product.mainImage!.path}")),
                SizedBox(
                  height: 10,
                ),
                Text(
                  product.productName,
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
                  "${product.price} ETB",
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
                SizedBox(
                  height: 10,
                ),
                Text(
                  "You are about to order the above product, we will contact you back via your phone.",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                normalTextFormField(
                    type: RichText(
                      text: TextSpan(
                        text: 'Full Name',
                        style: GoogleFonts.quicksand(
                            fontSize: defaultFontSize,
                          color: onBackgroundColor,
                          fontWeight: FontWeight.bold
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: '*', style: TextStyle(color: primaryColor, fontSize: 20)),
                        ],
                      ),
                    ),
                    hint: "Enter your full name",
                    controller: fullNameController),
                SizedBox(
                  height: 10,
                ),
                orderPhoneTextFormField(
                    type: RichText(
                      text: TextSpan(
                        text: 'Phone',
                        style: GoogleFonts.quicksand(
                            fontSize: defaultFontSize,
                          color: onBackgroundColor,
                          fontWeight: FontWeight.bold
                        ),
                        children: const <TextSpan>[
                          TextSpan(text: '*', style: TextStyle(color: primaryColor, fontSize: 20)),
                        ],
                      ),
                    ),
                    hint: "Enter your phone",
                    controller: phoneController),
                SizedBox(
                  height: 10,
                ),
                companyNameTextFormField(
                    type: "Company Name",
                    hint: "Enter your company name",
                    controller: companyNameController),
                SizedBox(
                  height: 20,
                ),
                Divider(
                  color: surfaceColor,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: isLoading ? null : () async {
                        final affLink = await _prefs.readAffiliateLink();
                        if (orderFormKey.currentState!.validate()) {

                          String phone = "+${phoneController.value!.countryCode}${phoneController.value!.nsn}";
                          print(phone);

                          final order = BlocProvider.of<OrdersBloc>(context);
                          if(affLink.toString() != "null"){
                            order.add(PostOrdersEvent(Orders(
                                productId: product.productId!,
                                fullName: fullNameController.text,
                                phone: phone,
                                companyName: companyNameController.text,
                              userId: affLink.toString()
                            )));
                          } else{
                            order.add(PostOrdersEvent(Orders(
                                productId: product.productId!,
                                fullName: fullNameController.text,
                                phone: phone,
                                companyName: companyNameController.text)));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        disabledBackgroundColor: disabledPrimaryColor,
                          backgroundColor: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.symmetric(vertical: 15)),
                      child: isLoading ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: onPrimaryColor,),) : Text(
                        "Submit",
                        style: TextStyle(color: onPrimaryColor, fontSize: 20),
                      )),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  )
      ),
  );
}

Widget buildSuccessfulDialog({required BuildContext context}){
  return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: SizedBox(
      height: 265,
  child: SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: Column(
        children: [
          Center(child: Iconify(Ic.baseline_task_alt, color: primaryColor, size: 50,)),
          SizedBox(height: 10,),
          Center(
              child: Text(
                "Your order has been successfully submitted. We will contact you back via your phone, Thank you!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: onBackgroundColor),
                textAlign: TextAlign.center,
              )),
          SizedBox(height: 30,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: normalText(
                  value: "Ok", size: 16, color: onPrimaryColor),
            ),
          )
        ],
      ),
    ),
  )
      ),
  );
}
