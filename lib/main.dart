import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project19/service/user_service.dart';
import 'package:project19/state/service_request_state.dart';
import 'package:project19/view/user/login.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ServiceRequestState>(
          create: (_) => ServiceRequestState(),
        ),
        ChangeNotifierProvider<UserService>(
          create: (_) => UserService(),
        ),
      ],
      child: MaterialApp(
        title: 'Service App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: LoginPage(),
      ),

      /* ChangeNotifierProvider<ServiceRequestState>(
        create: (_) => ServiceRequestState(),
        child: ChangeNotifierProvider<UserService>(
          create: (_) => UserService(),
          child: LoginPage(),
        ), */
    );
  }
}
