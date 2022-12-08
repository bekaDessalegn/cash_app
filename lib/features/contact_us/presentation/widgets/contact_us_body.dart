import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/footer.dart';
import 'package:cash_app/features/common_widgets/mobile_header.dart';
import 'package:cash_app/features/common_widgets/normal_textformfield.dart';
import 'package:cash_app/features/common_widgets/success_flashbar.dart';
import 'package:cash_app/features/contact_us/data/models/contact_us.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_bloc.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_event.dart';
import 'package:cash_app/features/contact_us/presentation/blocs/contact_us_state.dart';
import 'package:cash_app/features/contact_us/presentation/widgets/contact_us_normal_textformfield.dart';
import 'package:cash_app/features/contact_us/presentation/widgets/email_box.dart';
import 'package:cash_app/features/contact_us/presentation/widgets/message_box.dart';
import 'package:cash_app/features/products/presentation/widgets/phone_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:phone_form_field/phone_form_field.dart';

class ContactUsBody extends StatefulWidget {
  const ContactUsBody({Key? key}) : super(key: key);

  @override
  State<ContactUsBody> createState() => _ContactUsBodyState();
}

class _ContactUsBodyState extends State<ContactUsBody> {
  final contactUsFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final phoneController = PhoneController(null);
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  final messageController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    fullNameController.dispose();
    emailController.dispose();
    addressController.dispose();
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactUsBloc, ContactUsState>(builder: (_, state) {
      if (state is PostContactUsLoading) {
        return buildInitialInput(isLoading: true);
      } else {
        return buildInitialInput(isLoading: false);
      }
    }, listener: (_, state) {
      if (state is PostContactUsSuccessful) {
        buildSuccessLayout(
            context: context, message: "Successfully sent your message");
        fullNameController.clear();
        emailController.clear();
        addressController.clear();
        messageController.clear();
      }
      if (state is PostContactUsFailed) {
        buildErrorLayout(context: context, message: state.errorType);
      }
    });
  }

  Widget buildInitialInput({required isLoading}) {
    return SingleChildScrollView(
      child: Form(
        key: contactUsFormKey,
        child: Column(
          children: [
            buildMobileHeader(context: context),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Contact us",
                    style: TextStyle(
                        color: onBackgroundColor,
                        fontSize: 28,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  contactUsNormalTextFormField(
                      type: "Full Name",
                      hint: "Enter your full name",
                      controller: fullNameController),
                  SizedBox(
                    height: 20,
                  ),
                  phoneTextFormField(
                      type: "Phone",
                      hint: "Enter your phone",
                      controller: phoneController),
                  SizedBox(
                    height: 20,
                  ),
                  emailTextFormField(
                      type: "Email",
                      hint: "Enter your email",
                      controller: emailController),
                  SizedBox(
                    height: 20,
                  ),
                  contactUsNormalTextFormField(
                      type: "Address",
                      hint: "Enter your address",
                      controller: addressController),
                  SizedBox(
                    height: 20,
                  ),
                  messageTextFormField(
                      type: RichText(
                        text: TextSpan(
                          text: 'Message',
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
                      hint: "Enter your message",
                      controller: messageController),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: isLoading ? null : () {
                          if (contactUsFormKey.currentState!.validate()) {

                            String phone = "null";
                            print("YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYyy");
                            print(phoneController.value.toString());
                            if(phoneController.value.toString() != "null"){
                              phone = "+${phoneController.value!.countryCode}${phoneController.value!.nsn}";
                            }

                            final contactUs =
                                BlocProvider.of<ContactUsBloc>(context);
                            contactUs.add(PostContactUsEvent(ContactUs(
                                fullName: fullNameController.text.isEmpty ? "null" : fullNameController.text,
                                phone: phone == "null" ? "null" : phone,
                                email: emailController.text.isEmpty ? "null" : emailController.text,
                                address: addressController.text.isEmpty ? "null" : addressController.text,
                                message: messageController.text)));
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
            SizedBox(
              height: 30,
            ),
            footer(context: context)
          ],
        ),
      ),
    );
  }
}
