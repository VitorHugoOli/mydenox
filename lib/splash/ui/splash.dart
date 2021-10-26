import 'package:MyDenox/modals/user.dart';
import 'package:earbo/src/login/modal/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      redirectPage(context);
    });
  }

  Future<void> redirectPage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    User user = await User.fromPrefs(); //todo:verificar o que acontece quando não tem user no fromPrefs
    await Future.delayed(Duration(milliseconds: 20));

    if (user.id != null && prefs.containsKey("token")) {
      Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // linear-gradient(180deg, # 0%, #381A4A 100%)
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff321E3E),Color(0xff381A4A)],
        )
      ),
      child: Scaffold(
        backgroundColor: const Color(0xff47633E),
        body: Center(child: Image.asset("assets/logo.png",scale: 1.5)),
      ),
    );
  }
}
