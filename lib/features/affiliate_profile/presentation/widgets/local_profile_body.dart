import 'package:cash_app/core/constants.dart';
import 'package:cash_app/core/global.dart';
import 'package:cash_app/features/affiliate_profile/data/models/local_affiliate.dart';
import 'package:cash_app/features/affiliate_profile/presentation/widgets/promo_link_box.dart';
import 'package:cash_app/features/common_widgets/blink_container.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Widget localBuildInitialInput({required BuildContext context, required LocalAffiliate affiliate, required TextEditingController promoLinkController}){
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
              Center(child: BlinkContainer(width: 120, height: 120, borderRadius: 120)),
              Center(
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
                height: 5,
              ),
              Center(
                child: Text(
                  "${affiliate.phone}",
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: onBackgroundColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
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
                "${affiliate.acceptedRequests} Accepted requests",
                style: TextStyle(
                  color: onBackgroundColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${affiliate.rejectedRequests} Rejected requests",
                style: TextStyle(
                  color: onBackgroundColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${affiliate.totalRequests - (affiliate.acceptedRequests + affiliate.rejectedRequests)} Pending requests",
                style: TextStyle(
                  color: onBackgroundColor,
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "${affiliate.totalRequests} Total requests",
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
            ],
          ),
        ),
      ),
    ),
  );
}