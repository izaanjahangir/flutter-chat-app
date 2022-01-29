import 'package:chat_app/providers/user_provider.dart';
import 'package:chat_app/screens/chat/chat.dart';
import 'package:chat_app/screens/home/home.dart';
import 'package:chat_app/screens/login/login.dart';
import 'package:chat_app/screens/register/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => UserProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      builder: EasyLoading.init(),
      routes: {
        '/': (context) => Login(),
        '/home': (context) => Home(),
        '/register': (context) => Register(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/chat') {
          final Map<String, dynamic> args =
              settings.arguments as Map<String, dynamic>;

          return MaterialPageRoute(
              builder: (_) =>
                  Chat(room: args["roomId"], otherUser: args["selectedUser"]));
        }
        return null; // Let `onUnknownRoute` handle this behavior.
      },
    );
  }
}
