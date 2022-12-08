import 'package:cash_app/features/contact_us/data/models/contact_us.dart';

abstract class ContactUsEvent {}

class PostContactUsEvent extends ContactUsEvent {
  ContactUs contactUs;
  PostContactUsEvent(this.contactUs);
}