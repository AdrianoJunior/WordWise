import 'package:dictionary/firebase/firebase_service.dart';
import 'package:dictionary/pages/login/login_page.dart';
import 'package:dictionary/utils/alert.dart';
import 'package:dictionary/utils/nav.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatelessWidget {
  UserAccountsDrawerHeader _header(User ?user) {
    return UserAccountsDrawerHeader(
      accountName: Text(user?.displayName ?? ""),
      accountEmail: Text(user?.email ?? ''),
      currentAccountPicture: const CircleAvatar(
        backgroundImage: AssetImage('assets/images/avatar.png'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            _header(user),
            ListTile(
              leading: const Icon(Icons.info_rounded),
              title: const Text("Info"),
              subtitle: const Text("more info..."),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.pop(context);
                alert(context, "App developed by Adriano Junior\nas part of a Coodesh challenge.");
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Logout"),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () => _onClickLogout(context),
            )
          ],
        ),
      ),
    );
  }

  _onClickLogout(BuildContext context) {
    FirebaseService().logout();
    Navigator.pop(context);
    push(context, LoginPage(), replace: true);
  }
}
