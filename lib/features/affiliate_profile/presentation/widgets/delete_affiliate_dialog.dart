import 'dart:convert';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_state.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

final _deleteAffilaiteKey = GlobalKey<FormState>();
final _deleteAffiliateController = TextEditingController();

Widget deleteAffiliateDialog({required BuildContext context}){
  final _prefs = PrefService();
  final authService = Provider.of<AuthService>(context);
  return Dialog(
    child: BlocConsumer<DeleteAffiliateBloc, DeleteAffiliateState>(builder: (_, state){
      if(state is DeleteAffiliateLoadingState){
        return _buildDeleteAffiliateInput(context: context, isLoading: true);
      } else{
        return _buildDeleteAffiliateInput(context: context, isLoading: false);
      }
    }, listener: (_, state){
      if(state is DeleteAffiliateSuccessfulState){
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        context.go(APP_PAGE.home.toPath);
      }
      if(state is DeleteAffiliateFailedState){
        buildErrorLayout(context: context, message: state.errorType);
      }
    }),
  );
}

Widget _buildDeleteAffiliateInput({required BuildContext context, required bool isLoading}){
  return SizedBox(
    height: 230,
    width: MediaQuery.of(context).size.width < 500 ? double.infinity : 300,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
      child: Form(
        key: _deleteAffilaiteKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Delete Account", style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                ),),
                SizedBox(height: 10,),
                Text("Type your password below to delete your account ?", style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16
                ),),
                SizedBox(height: 10,),
                TextFormField(
                  controller: _deleteAffiliateController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "Value can not be empty";
                    }
                    else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    hintStyle: const TextStyle(color: textInputPlaceholderColor),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: textInputBorderColor),
                      borderRadius: BorderRadius.all(
                        Radius.circular(defaultRadius),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: primaryColor),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: dangerColor),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: (){
                  Navigator.pop(context);
                }, child: Text("Cancel", style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16
                ),),),
                SizedBox(width: 10,),
                TextButton(onPressed: (){
                  if(_deleteAffilaiteKey.currentState!.validate()){
                    var bytes = utf8.encode(_deleteAffiliateController.text);
                    var sha512 = sha256.convert(bytes);
                    var hashedPassword = sha512.toString();
                    final deleteAffiliate = BlocProvider.of<DeleteAffiliateBloc>(context);
                    deleteAffiliate.add(DeleteSingleAffiliateEvent(hashedPassword));
                  }
                }, child: isLoading ? SizedBox(width: 16, height: 16, child: CircularProgressIndicator(color: primaryColor)) : Text("Delete", style: TextStyle(
                    color: dangerColor,
                    fontSize: 16
                ),),),
              ],
            )
          ],
        ),
      ),
    ),
  );
}