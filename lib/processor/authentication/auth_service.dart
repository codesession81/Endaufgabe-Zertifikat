import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopapp/data/global/global_data.dart';
import 'package:shopapp/data/network/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService _db = DatabaseService();

  //Create acount with email and password and set the referenced customer registration data to the database
  Future<User?> createAccountWithEmailAndPassword(String email,String vorname,String nachname,String alter,String strasse,String hausnr,String stadt,String password)async{
   try{
     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     final User? user = userCredential.user;
     _db.setCustomerRegistrationData(userCredential.user!.uid,email,password, vorname, nachname, alter, strasse, hausnr, stadt);
     return user;
   }catch(error){
     print(error.toString());
   }
  }

  //Login with email and password
  Future<User?> loginWithEmailAndPassword(String email,String password)async{
    try{
      UserCredential loginResult = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user = loginResult.user;
      GlobalData.currentUserId = user!.uid;
      return user;
    }catch(error){
      print(error.toString());
    }
  }

  //Logout
  Future logout()async{
    try{
      GlobalData.currentUserId = null;
      return await _auth.signOut();
    }catch(error){
      print(error.toString());
    }
  }
}