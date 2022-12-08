import 'package:cash_app/features/affiliate_wallet/data/datasources/transaction_datasource.dart';
import 'package:cash_app/features/affiliate_wallet/data/models/transactions.dart';

class TransactionRepository{
  TransactionDataSource transactionDataSource;
  TransactionRepository(this.transactionDataSource);

  Future<List<Transactions>> getAffiliateTransactions(int skipNumber) async {
    try {
      print("On the way to get transactions");
      final transactions = await transactionDataSource.getAffiliateTransactions(skipNumber);
      return transactions;
    } catch(e){
      print(e);
      throw Exception();
    }
  }
}