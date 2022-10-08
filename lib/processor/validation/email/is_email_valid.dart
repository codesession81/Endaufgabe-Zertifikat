import 'package:shopapp/data/global/global_data.dart';

class IsEmailValid{
  bool isEmailValid(String email)=>RegExp(GlobalData.emailPattern!).hasMatch(email);
}