import 'package:flutter/material.dart';
import 'package:shopapp/data/consts/errors/error_fields.dart';
import 'package:shopapp/processor/authentication/auth_service.dart';
import 'package:shopapp/processor/validation/email/is_email_empty.dart';
import 'package:shopapp/processor/validation/email/is_email_valid.dart';
import 'package:shopapp/processor/validation/password/is_length_valid.dart';
import 'package:shopapp/processor/validation/password/is_pw_empty.dart';
import 'package:shopapp/visible/loading/loading.dart';
import 'package:shopapp/visible/pages/authentication/registration.dart';
import 'package:shopapp/visible/pages/private/home.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final IsEmailValid _isEmailValid = IsEmailValid();
  final IsEmailEmpty _isEmailEmpty = IsEmailEmpty();
  final IsPwLengthValid _isPwLengthValid = IsPwLengthValid();
  final IsPwEmpty _isPwEmpty = IsPwEmpty();
  final AuthService _authService = AuthService();

  bool loading = false;
  String? _email,_password;

  @override
  Widget build(BuildContext context) {
    return loading? const Loading(): Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Login zur Shopping-App",style: TextStyle(color: Colors.grey),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30,50,30,50),
          child: Form(
            key: _loginFormKey,
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
                ElevatedButton(
                    onPressed: ()async{
                      if(_loginFormKey.currentState!.validate()){
                        setState(() {
                          loading = true;
                        });
                        dynamic loginResult = await _authService.loginWithEmailAndPassword(_email!, _password!);
                        if(loginResult!=null){
                          setState(() {
                            loading= false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder:(context)=> const Home()));
                        }
                      }
                    },
                    child: const Text("Login")
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: ()=>  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const Registration())),
                    child: const Text("Registrierung abschließen")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
