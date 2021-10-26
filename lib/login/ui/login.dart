import 'package:earbo/resources/InputFields/CustomTextField.dart';
import 'package:earbo/resources/earbo.dart';
import 'package:earbo/src/login/bloc/bloc.dart';
import 'package:earbo/src/login/ui/retrivePass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  late BlocLogin bloc = BlocLogin(formkey: _formkey);
  bool passView = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(
            "assets/login_img.png",
            fit: BoxFit.cover,
            width: double.maxFinite,
            alignment: Alignment.topCenter,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(top: 25, bottom: 50),
                decoration: const BoxDecoration(
                  color: Color(0xff47633E),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/white_logo.png", scale: 1.5),
                    const SizedBox(height: 40),
                    buildForm,
                    Align(
                      alignment: Alignment.lerp(
                          Alignment.center, Alignment.bottomRight, 0.7)!,
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.all(0)),
                        onPressed: () => Navigator.of(context).pushNamed(
                          '/retrieve',
                          arguments: RecuperarSenha(
                            initEmail: bloc.login.value.email,
                          ),
                        ),
                        child: Text(
                          "Esqueci minha senha",
                          style: GoogleFonts.roboto(
                              fontSize: 16,
                              color: Color(0xffDDE08D),
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Earbo.button(
                      "Entrar",
                      action: () async {
                        if (await bloc.logIn()) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              "/home", (route) => false);
                        }
                      },
                      width: 200,
                      height: 50,
                      fontSize: 19,
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Form get buildForm {
    const color = const Color(0xffDDE08D);
    const style = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        width: 1.2,
        color: color,
      ),
    );
    return Form(
      key: _formkey,
      child: Column(
        children: [
          CustomTextField(
            label: "E-mail",
            onChanges: bloc.changeEmail,
            width: 320,
            fillColors: Colors.transparent,
            colorLabel: color,
            colorFont: color,
            style: style,
          ),
          SizedBox(height: 20),
          CustomTextField(
            label: "Senha",
            pass: !passView,
            onChanges: bloc.changePass,
            fillColors: Colors.transparent,
            colorLabel: color,
            colorFont: color,
            style: style,
            width: 320,
            textAlignVertical: TextAlignVertical.center,
            suffixIcon: IconButton(
              icon: Icon(
                passView ? FeatherIcons.eye : FeatherIcons.eyeOff,
                color: color,
              ),
              onPressed: () {
                passView = !passView;
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
