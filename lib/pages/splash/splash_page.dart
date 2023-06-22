import 'package:dictionary/pages/home/home_page.dart';
import 'package:dictionary/pages/intro/intro_page.dart';
import 'package:dictionary/pages/login/login_page.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:dictionary/utils/prefs.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:flutter/services.dart' show rootBundle;

class SplashPage extends StatefulWidget {

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  Future<Map<String, dynamic>?> readJsonFile(String filePath) async {
    try {
      // Read the contents of the JSON file
      String contents = await rootBundle.loadString(filePath);

      // Parse the JSON data
      Map<String, dynamic> jsonData = convert.jsonDecode(contents);

      // Return the parsed JSON data
      return jsonData;
    } catch (e) {
      print('Error reading JSON file: $e');
      return null;
    }
  }


  @override
  void initState() {
    super.initState();

    final futureDelay = Future.delayed(Duration(seconds: 3));
    final futureFirstOpen = Prefs.getBool('firstOpen');
    Future.wait([futureDelay, futureFirstOpen]).then((value) {
      if(FirebaseAuth.instance.currentUser != null) {
        push(context, HomePage(), replace: true);
      } else {
        if (value[1] || kIsWeb) {
          readJsonFile('assets/json/words_dictionary.json').then((jsonData) {
            push(context, IntroPage(jsonData: jsonData!), replace: true);
          });
        } else {
          push(context, LoginPage(), replace: true);
        }
      }
    });



  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        ),
        body: _body(),
     );
  }

  _body() {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo_app.png', height: kIsWeb ? 480 : 250,),
            const SizedBox(height: 32),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
