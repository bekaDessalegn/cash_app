import 'package:cash_app/features/contact_us/data/datasources/contact_us_datasource.dart';
import 'package:cash_app/features/contact_us/data/models/contact_us.dart';

class ContactUsRepository {
  ContactUsDataSource contactUsDataSource;
  ContactUsRepository(this.contactUsDataSource);

  Future postContactUs(ContactUs contactUs) async {
    try{
      print("On the way to contact us");
      await contactUsDataSource.postContactUs(contactUs);
    } catch(e){
      print(e);
      throw Exception();
    }
  }
}