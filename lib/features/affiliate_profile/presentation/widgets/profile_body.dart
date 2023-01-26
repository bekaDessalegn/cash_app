import 'dart:io';

import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/router/route_utils.dart';
import 'package:cash_app/core/services/app_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_profile/data/models/affiliates.dart';
import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';
import 'package:cash_app/features/affiliate_profile/data/models/children.dart';
import 'package:cash_app/features/affiliate_profile/data/models/parent_affiliate.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_state.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/change_full_name_textformfield.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/change_phone_textformfield.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/children_box.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/delete_affiliate_dialog.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/local_profile_body.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/promo_link_box.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/signout_dialog.dart';
import 'package:cash_app/features/common_widgets/bold_text.dart';
import 'package:cash_app/features/common_widgets/error_flashbar.dart';
import 'package:cash_app/features/common_widgets/something_went_wrong_error_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/eva.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:progressive_image/progressive_image.dart';
import 'package:provider/provider.dart';


class ProfileBody extends StatefulWidget {
  const ProfileBody({Key? key}) : super(key: key);

  @override
  State<ProfileBody> createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {

  TextEditingController promoLinkController = TextEditingController();

  int childrenCount = 0;

  File? _pickedImage;
  Uint8List selectedWebImage = Uint8List(8);
  String? contentType;
  List imageType = [];

  Future<void> _pickImage() async {
    if (!kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var webImage = await image.readAsBytes();
        var selected = File(image.path);
        setState(() {
          selectedWebImage = webImage;
          _pickedImage = selected;
          contentType = lookupMimeType(image.path);
          if(contentType.toString() != "null"){
            List type = contentType!.split("/");
            imageType = type;
          }
          final putAvatar = BlocProvider.of<PutAvatarBloc>(context);
          putAvatar.add(PutAvatar(Avatar(path: selectedWebImage.toString()), imageType));
        });
      } else {
        print("No image has been picked");
      }
    } else if (kIsWeb) {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var webImage = await image.readAsBytes();
        var selected = File(image.path);
        setState(() {
          selectedWebImage = webImage;
          _pickedImage = selected;
          contentType = image.mimeType;
          if(contentType.toString() != "null"){
            List type = contentType!.split("/");
            imageType = type;
          }
          final putAvatar = BlocProvider.of<PutAvatarBloc>(context);
          putAvatar.add(PutAvatar(Avatar(path: selectedWebImage.toString()), imageType));
        });
      } else {
        print("No image has been picked");
      }
    } else {
      print("Something went wrong");
    }
  }

  @override
  void initState() {
    final affiliate_details = BlocProvider.of<SingleAffiliateBloc>(context);
    affiliate_details.add(GetSingleAffiliateEvent());
    final children = BlocProvider.of<ChildrenBloc>(context);
    children.add(GetChildrenEvent());
    final parent = BlocProvider.of<ParentAffiliateBloc>(context);
    parent.add(StartGetParentAffiliateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SingleAffiliateBloc, SingleAffiliateState>(
        builder: (_, state){
          if(state is GetSingleAffiliateSuccessfulState){
            return buildInitialInput(affiliate: state.affiliate);
          } else if(state is GetSingleAffiliateSocketErrorState){
            return localBuildInitialInput(context: context, affiliate: state.localAffiliate, promoLinkController: promoLinkController);
          } else if(state is GetSingleAffiliateLoadingState){
            return loadingProfile();
          } else{
            return Center(child: Text(""),);
          }
        },
        listener: (_, state){
          if(state is GetSingleAffiliateFailedState){
            somethingWentWrong(context: context, message: state.errorType, onPressed: (){
              final affiliate_details = BlocProvider.of<SingleAffiliateBloc>(context);
              affiliate_details.add(GetSingleAffiliateEvent());
            });
          }
          if(state is GetSingleAffiliateSuccessfulState){
            print("PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP");
            print(state.affiliate.toJson());
            if(state.affiliate.parentId != null){
              final parent = BlocProvider.of<ParentAffiliateBloc>(context);
              print("This is me");
              print(state.affiliate.fullName);
              parent.add(GetParentAffiliateEvent(state.affiliate.parentId!));
            }
          }
        });
  }

  Widget buildInitialInput({required Affiliates affiliate}){
    final appService = Provider.of<AppService>(context, listen: true);
    promoLinkController.text = "$hostUrl/?aff=${affiliate.userId}";
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SizedBox(
        width: 500,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocConsumer<PutAvatarBloc, PutAvatarState>(
                    builder: (_, state){
                      if(state is PutAvatarStateLoading){
                        return Center(
                          child: Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: surfaceColor,
                                borderRadius: BorderRadius.circular(100),),
                            child: Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: primaryColor,),)),
                          ),
                        );
                      } else if(state is PutAvatarStateSuccessful){
                        print("SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSss");
                        print(state.avatar);
                        return avatarBox(path: state.avatar.path!);
                      } else{
                        return avatarBox(path: affiliate.avatar!.path!);
                      }
                    },
                    listener: (_, state){

                    }),
                BlocConsumer<PatchFullNameBloc, EditFullNameState>(builder: (_, state){
                  if(state is PatchFullNameLoading){
                    return editFullName(affiliate: affiliate, isLoading: true);
                  } else{
                    return editFullName(affiliate: affiliate, isLoading: false);
                  }
                }, listener: (_, state){
                  if(state is PatchFullNameFailed){
                    appService.changeIsEditFullName(false);
                    buildErrorLayout(
                        context: context,
                        message: state.errorType);
                  }
                  if(state is PatchFullNameSuccessful){
                    final affiliate = BlocProvider.of<SingleAffiliateBloc>(context);
                    affiliate.add(GetSingleAffiliateEvent());
                    appService.changeIsEditFullName(false);
                  }
                }),
                SizedBox(
                  height: 5,
                ),
                BlocConsumer<PatchPhoneBloc, EditProfileState>(builder: (_, state){
                  if(state is EditPhoneLoading){
                    return editPhone(affiliate: affiliate, isLoading: true);
                  } else{
                    return editPhone(affiliate: affiliate, isLoading: false);
                  }
                }, listener: (_, state){
                  if(state is EditPhoneFailed){
                    appService.changeIsEditPhone(false);
                    buildErrorLayout(
                        context: context,
                        message: state.errorType);
                  }
                  if(state is EditPhoneSuccessful){
                    final affiliate = BlocProvider.of<SingleAffiliateBloc>(context);
                    affiliate.add(GetSingleAffiliateEvent());
                    appService.changeIsEditPhone(false);
                  }
                }),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "${affiliate.email}",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: onBackgroundColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            context.push(APP_PAGE.editEmail.toPath);
                          },
                          child: Iconify(
                            Eva.edit_2_outline,
                            color: primaryColor,
                            size: 18,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Promo link",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                promoLinkBox(
                    context: context, promoController: promoLinkController),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Requests via your link",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${affiliate.affiliationSummary.acceptedRequests} Accepted requests",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${affiliate.affiliationSummary.rejectedRequests} Rejected requests",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${affiliate.affiliationSummary.totalRequests - (affiliate.affiliationSummary.acceptedRequests + affiliate.affiliationSummary.rejectedRequests)} Pending requests",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${affiliate.affiliationSummary.totalRequests} Total requests",
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
                  "Affiliate chain",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                BlocConsumer<ParentAffiliateBloc, ParentAffiliateState>(builder: (_, state){
                  if(state is GetParentAffiliateSuccessfulState){
                    print("This is the parent");
                    print(state.affiliate);
                    print(state.affiliate.fullName);
                    return affiliateParent(fullName: state.affiliate.fullName);
                  } else {
                    return SizedBox();
                  }
                },
                listener: (_, state){

                },),
                BlocConsumer<ChildrenBloc, ChildrenState>(builder: (_, state){
                  if(state is GetChildrenSuccessfulState){
                    return childrenList(children: state.children);
                  } else if(state is GetSingleAffiliateLoadingState){
                    return Center(child: CircularProgressIndicator(color: primaryColor,),);
                  } else{
                    return Center(child: Text(""),);
                  }
                }, listener: (_, state){
                  if(state is GetChildrenFailedState){
                    somethingWentWrong(context: context, message: state.errorType, onPressed: (){
                      final children = BlocProvider.of<ChildrenBloc>(context);
                      children.add(GetChildrenEvent());
                    });
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: surfaceColor,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    "member since ${DateFormat("dd/MM/yyyy").format(
                      DateTime.parse("${affiliate.memberSince}"),
                    )}",
                    style: TextStyle(
                      color: onBackgroundColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Divider(
                  color: surfaceColor,
                  thickness: 1.0,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Actions",
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        context.push(APP_PAGE.editPassword.toPath);
                      },
                      child: boldText(
                          value: "Change password", size: 16, color: primaryColor)),
                ),
                SizedBox(height: 10,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                          return WillPopScope(
                            onWillPop: () async {
                              return false;
                            },
                            child: Dialog(
                              child: SizedBox(
                                height: 180,
                                width: MediaQuery.of(context).size.width < 500 ? double.infinity : 300,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Remove avatar", style: TextStyle(
                                          color: onBackgroundColor,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold
                                      ),),
                                      SizedBox(height: 10,),
                                      Text("Are you sure you want to delete your avatar ?", style: TextStyle(
                                          color: onBackgroundColor,
                                          fontSize: 16
                                      ),),
                                      SizedBox(height: 20,),
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
                                            final delete = BlocProvider.of<PutAvatarBloc>(context);
                                            delete.add(DeleteAvatar());
                                            Navigator.pop(context);
                                          }, child: Text("Remove", style: TextStyle(
                                              color: dangerColor,
                                              fontSize: 16
                                          ),),),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                      },
                      child: boldText(
                          value: "Remove avatar", size: 16, color: primaryColor)),
                ),
                SizedBox(
                  height: 10,
                ),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context){
                          return signoutDialog(context: context);
                        });
                      },
                      child: boldText(
                          value: "Sign out", size: 16, color: primaryColor)),
                ),
                SizedBox(height: 10,),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          barrierDismissible: false,
                            context: context,
                            builder: (BuildContext context) {
                              return deleteAffiliateDialog(
                                context: context
                              );
                            });
                      },
                      child: boldText(
                          value: "Delete account", size: 16, color: dangerColor)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget childrenList({required List<Children> children}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 5,
        ),
        Text(
          "Children (${children.length})",
          style: TextStyle(
            color: onBackgroundColor,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        ListView.builder(
            itemCount: children.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return childrenWidget(child: children[index]);
            }),
      ],
    );
  }

  Widget avatarBox({required String path}){
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: (){
          _pickImage();
        },
        child: Center(
          child: path == "null" ? Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                image: DecorationImage(
                    image: AssetImage("images/account.jpg"),
                    fit: BoxFit.cover)),
          ) : ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: ProgressiveImage(
              placeholder: AssetImage('images/loading.png'),
              thumbnail: NetworkImage("$baseUrl${path}"),
              image: NetworkImage("$baseUrl${path}"),
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget editPhone({required Affiliates affiliate, required bool isLoading}){
    final appService = Provider.of<AppService>(context, listen: true);
    return appService.isEditPhone
        ? changePhoneTextFormField(
        context: context, phone: affiliate.phone, isLoading: isLoading)
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "${affiliate.phone}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: onBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                print(appService.isEditPhone);
                appService.changeIsEditPhone(true);
                print(appService.isEditPhone);
              },
              child: Iconify(
                Eva.edit_2_outline,
                color: primaryColor,
                size: 18,
              )),
        )
      ],
    );
  }

  Widget affiliateParent({required String fullName}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Parent ",
          style: TextStyle(
            color: onBackgroundColor,
            fontSize: 16,
          ),
        ),
        Flexible(
          child: Text(
            fullName,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget editFullName({required Affiliates affiliate, required bool isLoading}){
    final appService = Provider.of<AppService>(context, listen: true);
    return appService.isEditFullName
        ? changeFullNameTextFormField(
        context: context, fullName: affiliate.fullName, isLoading: isLoading)
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "${affiliate.fullName}",
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: onBackgroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTap: () {
                print(appService.isEditFullName);
                appService.changeIsEditFullName(true);
                print(appService.isEditFullName);
              },
              child: Iconify(
                Eva.edit_2_outline,
                color: primaryColor,
                size: 18,
              )),
        )
      ],
    );
  }

  Widget loadingProfile(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: SizedBox(
        width: 500,
        child: Align(
          alignment: Alignment.center,
          child: SizedBox(
            width: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: loadingColor,
                      borderRadius: BorderRadius.circular(100),
                      ),
                ),),
                SizedBox(height: 5,),
                Center(child: Container(
                  height: 16,
                  width: 180,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),),
                SizedBox(height: 5,),
                Center(child: Container(
                  height: 16,
                  width: 160,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),),
                SizedBox(height: 5,),
                Center(child: Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),),
                SizedBox(height: 20,),
                Container(
                  height: 16,
                  width: 80,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 5,),
                Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  height: 16,
                  width: 180,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 16,
                  width: 160,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 15,),
                Divider(color: surfaceColor, thickness: 1.0,),
                SizedBox(height: 15,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                    Container(
                      height: 16,
                      width: 140,
                      decoration: BoxDecoration(
                          color: loadingColor,
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Divider(color: surfaceColor, thickness: 1.0,),
                SizedBox(height: 10,),
                Center(
                  child: Container(
                    height: 16,
                    width: 220,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Divider(color: surfaceColor, thickness: 1.0,),
                SizedBox(height: 15,),
                Container(
                  height: 16,
                  width: 180,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                  height: 16,
                  width: 160,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 150,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 8,),
                Container(
                  height: 16,
                  width: 140,
                  decoration: BoxDecoration(
                      color: loadingColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
