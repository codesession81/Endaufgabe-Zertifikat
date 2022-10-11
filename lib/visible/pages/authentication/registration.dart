import 'package:flutter/material.dart';
import 'package:shopapp/data/consts/errors/error_fields.dart';
import 'package:shopapp/processor/authentication/auth_service.dart';
import 'package:shopapp/processor/validation/age/is_age_empty.dart';
import 'package:shopapp/processor/validation/age/is_age_valid.dart';
import 'package:shopapp/processor/validation/email/is_email_empty.dart';
import 'package:shopapp/processor/validation/email/is_email_valid.dart';
import 'package:shopapp/processor/validation/password/is_length_valid.dart';
import 'package:shopapp/processor/validation/password/is_pw_empty.dart';
import 'package:shopapp/visible/loading/loading.dart';
import 'package:shopapp/visible/pages/authentication/login.dart';


class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {


  String? _email,_confirm_email,_vorname,_nachname,_alter,_strasse,_hausnr,_stadt,_password,_confirm_pwd;
  bool loading = false;

  AuthService? _authService;
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final IsEmailValid _isEmailValid = IsEmailValid();
  final IsEmailEmpty _isEmailEmpty = IsEmailEmpty();
  final IsPwLengthValid _isPwLengthValid = IsPwLengthValid();
  final IsPwEmpty _isPwEmpty = IsPwEmpty();
  final IsAgeValid _isAgeValid = IsAgeValid();
  final IsAgeEmpty _isAgeEmpty = IsAgeEmpty();


  @override
  void initState() {
    super.initState();
    _authService = AuthService();
  }

  @override
  Widget build(BuildContext context) {
    return loading? const Loading():Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.grey, //change your color here
        ),
        backgroundColor: Colors.white,
        title: const Text("Registrierung",style: TextStyle(color: Colors.grey),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,50,30,50),
          child: Form(
            key: _registerFormKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Emailadresse",
                  ),
                  validator: (val){
                    if(_isEmailEmpty.isEmailEmpty(val!)){
                      return ErrorFields.requiredField;
                    }else if(!_isEmailValid.isEmailValid(val)){
                      return ErrorFields.inValidEmail;
                    }else{
                      setState(() {
                        _email = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: "Emailadresse bestätigen",
                  ),
                  validator: (val){
                    if(_isEmailEmpty.isEmailEmpty(val!)){
                      return ErrorFields.requiredField;
                    }else if(!_isEmailValid.isEmailValid(val)){
                      return ErrorFields.inValidEmail;
                    }else if(val!=_email){
                     return ErrorFields.emailsNotEqual;
                    }else{
                    setState(() {
                    _confirm_email = val;
                    });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Vorname",
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return ErrorFields.requiredField;
                    }else{
                      setState(() {
                        _vorname = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Nachname",
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return ErrorFields.requiredField;
                    }else{
                      setState(() {
                        _nachname = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Strasse",
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return ErrorFields.requiredField;
                    }else{
                      setState(() {
                        _strasse = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  maxLength: 4,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Hausnr",
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return ErrorFields.requiredField;
                    }else{
                      setState(() {
                        _hausnr = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: "Stadt",
                  ),
                  validator: (val){
                    if(val!.isEmpty){
                      return ErrorFields.requiredField;
                    }else{
                      setState(() {
                        _stadt = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: const InputDecoration(
                    counterText: "",
                    hintText: "Alter",
                  ),
                  validator: (val){
                    if(_isAgeEmpty.isAgeEmpty(val!)){
                      return ErrorFields.requiredField;
                    }else if(_isAgeValid.isAgeValid(val)){
                      return ErrorFields.invalidAge;
                    }else{
                      setState(() {
                        _alter = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                  validator: (val){
                    if(_isPwEmpty.isPwEmpty(val!)){
                      return ErrorFields.requiredField;
                    }else if(!_isPwLengthValid.isLengthValid(val)){
                      return ErrorFields.invalidPwLength;
                    }else{
                      setState(() {
                        _password = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password bestätigen",
                  ),
                  validator: (val){
                    if(_isPwEmpty.isPwEmpty(val!)){
                      return ErrorFields.requiredField;
                    }else if(!_isPwLengthValid.isLengthValid(val)){
                      return ErrorFields.invalidPwLength;
                    }else if(val!=_password){
                      return ErrorFields.notEqualPw;
                    }else{
                      setState(() {
                        _confirm_pwd = val;
                      });
                    }
                  },
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: ()async{
                      if(_registerFormKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic regResult = await _authService!.createAccountWithEmailAndPassword(_email!,_vorname!,_nachname!,_alter!,_strasse!,_hausnr!,_stadt!,_password!);
                        if(regResult!=null){
                          setState(() {
                            loading = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>const Login(),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text("Absenden")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

