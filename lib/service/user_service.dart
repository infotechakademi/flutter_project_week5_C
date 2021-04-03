import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:project19/model/user_model.dart' as ServiceRequest;

enum UserStatus {
  login,
  logout,
  inProgress,
}

class UserService extends ChangeNotifier {
  ServiceRequest.User? user;

  UserStatus userStatus = UserStatus.logout;

  login(String email, String password) async {
    userStatus = UserStatus.inProgress;
    notifyListeners();
    //
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    // ...

    if (userCredential.user != null) {
      user?.id = userCredential.user?.uid;
      userStatus = UserStatus.login;
    } else
      userStatus = UserStatus.logout;
    notifyListeners();
  }

  register() {
    //
    notifyListeners();
  }

  signout() async {
    userStatus = UserStatus.inProgress;
    notifyListeners();
    // ...
    await Future.delayed(Duration(milliseconds: 500));

    if (true) userStatus = UserStatus.logout;
    //else userStatus = UserStatus.login;
    notifyListeners();
  }
}
