import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:project19/service/user_service.dart';
import 'package:project19/view/service_desk/service_desk.dart';
import 'package:project19/view/service_requests/service_request_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    printPackageInfo();
    printDeviceInfo();
    super.initState();
  }

  printPackageInfo() {
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      print("$appName\n$packageName\n$version\n$buildNumber\n");
    });
  }

  printDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    print('Running on ${androidInfo.brand}\n'); // e.g. "Moto G (4)"
  }

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
            child: Text("Servis Masası"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDesk(),
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
