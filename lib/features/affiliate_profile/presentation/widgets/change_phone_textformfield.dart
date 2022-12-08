import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/services/app_service.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ic.dart';
import 'package:provider/provider.dart';

Widget changePhoneTextFormField({required BuildContext context, required String phone, required bool isLoading}){

  TextEditingController changePhoneController = TextEditingController();
  changePhoneController.text = isLoading ? "- - - - - - - - - -" : phone;
  final appService = Provider.of<AppService>(context, listen: false);

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Expanded(
        child: TextFormField(
          controller: changePhoneController,
          validator: (value){
            if(value!.isEmpty){
              return "Value can not be empty";
            }
            else{
              return null;
            }
          },
          onChanged: (value){},
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: textInputBorderColor),
              borderRadius: BorderRadius.all(
                Radius.circular(defaultRadius),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: dangerColor),
            ),
          ),
        ),
      ),
      IconButton(
          onPressed: () {
            final patchPhone = BlocProvider.of<PatchPhoneBloc>(context);
            patchPhone.add(PatchPhoneEvent(changePhoneController.text));
            print(changePhoneController.text);
          },
          icon: isLoading ? SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(color: primaryColor, strokeWidth: 2.0,)) : Iconify(
            Ic.baseline_done,
            size: 24,
            color: primaryColor,
          ))
    ],
  );
}