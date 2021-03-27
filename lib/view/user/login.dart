import 'package:flutter/material.dart';
import 'package:project19/service/user_service.dart';
import 'package:project19/view/service_requests/service_request_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<UserService>(
      builder: (context, service, _) {
        var status = service.userStatus;
        switch (status) {
          case UserStatus.inProgress:
            return Center(child: CircularProgressIndicator());
          case UserStatus.login:
            return logoutScreen();
          case UserStatus.logout:
            return loginForm();
        }
      },
    ));
  }

  Widget logoutScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Giriş Başarılı"),
          SizedBox(height: 20),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text("Servis İsteklerim"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceRequestPage(),
                ),
              );
            },
          ),
          ElevatedButton(
            child: Text("Çıkış Yap"),
            onPressed: () {
              Provider.of<UserService>(context, listen: false).signout();
            },
          ),
        ],
      ),
    );
  }

  Widget loginForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Kullanıcı Adı"),
          ),
          TextField(
            decoration: InputDecoration(
              fillColor: Colors.teal.shade100,
              filled: true,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Şifre"),
          ),
          TextField(
            decoration: InputDecoration(
              fillColor: Colors.teal.shade100,
              filled: true,
            ),
          ),
          ElevatedButton(
            child: Text("Giriş"),
            onPressed: () {
              Provider.of<UserService>(context, listen: false)
                  .login("test@test.com", "abc123");
            },
          ),
        ],
      ),
    );
  }
}
