import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:project19/service/user_service.dart';
import 'package:project19/view/service_desk/service_desk.dart';
import 'package:project19/view/service_requests/service_request_page.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:geolocator/geolocator.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    //printPackageInfo();
    //printDeviceInfo();
    //determineAndPrintPosition();
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
            child: Text("Bağlantıya Git"),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Scaffold(
                      appBar: AppBar(),
                      body: WebView(
                        initialUrl: "https://www.google.com/",
                        javascriptMode: JavascriptMode.unrestricted,
                        javascriptChannels: {
                          JavascriptChannel(
                              name: 'Print1',
                              onMessageReceived: (JavascriptMessage message) {
                                print(message.message);
                              }),
                          JavascriptChannel(
                              name: 'Print2',
                              onMessageReceived: (JavascriptMessage message) {
                                print(message.message);
                              })
                        },
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () {
                          print("Google");
                        },
                      )),
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

  Future<void> determineAndPrintPosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    print("_determineAndPrintPosition is executed");

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    print("_determineAndPrintPosition step1");

    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.

      return Future.error('Location services are disabled.');
    }
    print("_determineAndPrintPosition step2");

    permission = await Geolocator.checkPermission();
    print("_determineAndPrintPosition step3");

    if (permission == LocationPermission.denied) {
      print("_determineAndPrintPosition step4");

      permission = await Geolocator.requestPermission();
      print("_determineAndPrintPosition step5");

      if (permission == LocationPermission.deniedForever) {
        print("_determineAndPrintPosition step6");

        // Permissions are denied forever, handle appropriately.
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
      print("_determineAndPrintPosition step7");

      if (permission == LocationPermission.denied) {
        print("_determineAndPrintPosition step8");

        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    print("_determineAndPrintPosition step9");

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var curPosition = await Geolocator.getCurrentPosition();
    print(curPosition);
  }
}
