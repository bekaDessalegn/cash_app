import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/common_widgets/success_flashbar.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:clipboard/clipboard.dart';

Widget promoLinkBox({required BuildContext context, required TextEditingController promoController}){
  return Container(
    height: 40,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 0.5, color: textInputBorderColor)
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: promoController,
            enabled: false,
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.center,
            style: TextStyle(color: primaryColor),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(8),
              filled: true,
              fillColor: backgroundColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                  borderSide: BorderSide.none),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () async {
              await FlutterClipboard.copy(promoController.text);

              buildSuccessLayout(context: context, message: "Text copied!");
            },
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: onBackgroundInactiveColor,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(10))
              ),
              child: Iconify(Ep.copy_document, color: onPrimaryColor, size: 24,),
            ),
          ),
        ),
      ],
    ),
  );
}