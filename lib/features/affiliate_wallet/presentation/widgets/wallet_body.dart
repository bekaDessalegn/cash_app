import 'package:cash_app/core/constants.dart';
import 'package:cash_app/features/affiliate_profile/data/models/affiliates.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_bloc.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_event.dart';
import 'package:cash_app/features/affiliate_profile/presentation/blocs/affiliates_state.dart';
import 'package:cash_app/features/affiliate_wallet/data/models/transactions.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_bloc.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_event.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/blocs/transactions_state.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/widgets/transaction_detail_box.dart';
import 'package:cash_app/features/affiliate_wallet/presentation/widgets/wallet_box.dart';
import 'package:cash_app/features/common_widgets/affiliate_mobile_header.dart';
import 'package:cash_app/features/common_widgets/bottom_navigationbar.dart';
import 'package:cash_app/features/common_widgets/loading_box.dart';
import 'package:cash_app/features/common_widgets/no_data_box.dart';
import 'package:cash_app/features/common_widgets/product_search_widget.dart';
import 'package:cash_app/features/common_widgets/something_went_wrong_error_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletBody extends StatefulWidget {
  const WalletBody({Key? key}) : super(key: key);

  @override
  State<WalletBody> createState() => _WalletBodyState();
}

class _WalletBodyState extends State<WalletBody> {

  late ScrollController _allTransactionsController;
  late ScrollController scrollController;

  bool _hasNextPage = true;
  bool _isLoadMoreRunning = false;
  bool _isFirstLoadRunning = false;

  int _allTransactionsIndex = 0;
  int _skip = 9;

  List<Transactions> _allTransactions = [];
  List fetchedTransactions = [];

  void loadMore() async {
    print("The fetched products");
    print(fetchedTransactions.length);
    print(_allTransactionsIndex);
    if (_hasNextPage == true &&
        _isLoadMoreRunning == false &&
        _allTransactionsController.position.extentAfter < 300) {
      setState(() {
        _isLoadMoreRunning = true;
      });

      _allTransactionsIndex += 1;
      final skipNumber = _allTransactionsIndex * _skip;
      final transaction = BlocProvider.of<AffiliateTransactionsBloc>(context);
      transaction.add(GetMoreAffiliateTransactionsEvent(skipNumber));

      if (fetchedTransactions.isNotEmpty) {
        print("adfGHJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJjjj");
        print(_allTransactionsIndex);
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

    final transaction = BlocProvider.of<AffiliateTransactionsBloc>(context);
    transaction.add(GetAffiliateTransactionsEvent(0));

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  @override
  void initState() {
    _firstLoad();
    _allTransactionsController = ScrollController()..addListener(loadMore);
    scrollController = ScrollController()..addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        loadMore();
      }});
    final affiliate_details = BlocProvider.of<SingleAffiliateBloc>(context);
    affiliate_details.add(GetSingleAffiliateEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: scrollController,
        physics: const ClampingScrollPhysics(),
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocConsumer<SingleAffiliateBloc, SingleAffiliateState>(
              builder: (_, state) {
            if (state is GetSingleAffiliateSuccessfulState) {
              return walletBody(affiliate: state.affiliate);
            } else if (state is GetSingleAffiliateLoadingState) {
              return loadingWallet();
            } else {
              return Center(
                child: Text(""),
              );
            }
          }, listener: (_, state) {
            if (state is GetSingleAffiliateFailedState) {
              somethingWentWrong(
                  context: context,
                  message: state.errorType,
                  onPressed: () {
                    final affiliate_details =
                        BlocProvider.of<SingleAffiliateBloc>(context);
                    affiliate_details.add(GetSingleAffiliateEvent());
                  });
            }
          }),
          Text(
            "Transcations history",
            style: TextStyle(
              color: onBackgroundColor,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          _isFirstLoadRunning
              ? const Center(
            child: CircularProgressIndicator(
              color: primaryColor,
            ),
          )
              : BlocConsumer<AffiliateTransactionsBloc, AffiliateTransactionsState>(
              builder: (_, state) {
                if (state is GetAffiliateTransactionsSuccessfulState) {
                  return _allTransactions.isEmpty
                      ? Center(child: noDataBox(text: "No Transactions!", description: "Transactions will appear here."))
                      : transactionBody();
                } else if(state is GetAffiliateTransactionsLoadingState){
                  return loadingTransactions();
                } else if (state is GetAffiliateTransactionsFailedState) {
                  return somethingWentWrong(
                      context: context,
                      message: state.errorType,
                      onPressed: () {
                        final transaction =
                            BlocProvider.of<AffiliateTransactionsBloc>(context);
                        transaction.add(GetAffiliateTransactionsEvent(0));
                      });
                } else {
                  return Center(
                    child: Text(""),
                  );
                }
              },
              listener: (_, state) {
                if (state is GetAffiliateTransactionsSuccessfulState) {
                  _allTransactions.addAll(state.transactions);
                  fetchedTransactions = state.transactions;
                }
              })
        ],
      ),
    ));
  }

  Widget walletBody({required Affiliates affiliate}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: walletBox(value: "${affiliate.wallet.totalMade.toStringAsFixed(2)}", type: "Earned")),
            SizedBox(
              width: 10,
            ),
            Expanded(child: walletBox(value: "${affiliate.wallet.currentBalance.toStringAsFixed(2)}", type: "Available")),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              onPressed: () {},
              child: Text(
                "Withdraw",
                style: TextStyle(color: onPrimaryColor, fontSize: 20),
              )),
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
      ],
    );
  }

  Widget transactionBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            controller: _allTransactionsController,
            itemCount: _allTransactions.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return transactionByDetailBox(transaction: _allTransactions[index]);
            }),
        if (_isLoadMoreRunning == true)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget loadingWallet(){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                height: 104,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(defaultRadius)
                ),
              ),
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Container(
                height: 104,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(defaultRadius)
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,),
        Container(
          width: double.infinity,
          height: 30,
          decoration: BoxDecoration(
              color: disabledPrimaryColor,
              borderRadius: BorderRadius.circular(10)
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
      ],
    );
  }

  Widget loadingTransactions(){
    return ListView.builder(
        itemCount: 6,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(color: surfaceColor, thickness: 1.0,),
              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 14,
                    width: 40,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 120,
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
                    height: 14,
                    width: 40,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 120,
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
                    height: 14,
                    width: 40,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 120,
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
                    height: 14,
                    width: 40,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                  Container(
                    height: 14,
                    width: 120,
                    decoration: BoxDecoration(
                        color: loadingColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                  ),
                ],
              ),
            ],
          );
        }
    );
  }

}
