import 'package:cash_app/features/about_us/data/datasources/remote/about_us_datasource.dart';
import 'package:cash_app/features/about_us/data/models/about_content.dart';

class AboutUsRepository{
  AboutUsDataSource aboutUsDataSource;
  AboutUsRepository(this.aboutUsDataSource);

  Future getAboutUsContent() async{
    try{
      final aboutUsContent = await aboutUsDataSource.getAboutUsContent();
      return aboutUsContent;
    } catch(e){
      print(e);
      throw Exception();
    }
  }
}