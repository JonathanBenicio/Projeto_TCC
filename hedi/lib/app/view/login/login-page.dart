import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hedi/app/model/Login.dart';
import 'package:hedi/app/model/Paciente.dart';
import 'package:hedi/app/service/url.dart';
import 'package:hedi/app/view/cadastro/cadastro-page.dart';
import 'package:hedi/app/view/home/home-page.dart';
import 'package:http/http.dart' as http;
import 'package:hedi/app/widgets/text-edit-widget.dart';
import 'package:hedi/styles/colors.dart';
import 'package:hedi/styles/icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = LoginController();
  final _formKey = GlobalKey<FormState>();

  String erro = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.37,
              child: Image.asset(
                iconApp,
                scale: 1.35,
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: color_backBlue),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(45),
                    topRight: Radius.circular(45)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black45,
                      blurRadius: 10.0,
                      offset: Offset(1, 0))
                ],
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 49),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: Column(
                        children: [
                          TextEditWidget(
                            text: "Email",
                            inputType: TextInputType.emailAddress,
                            valueSave: (newValue) =>
                                controller.email = newValue,
                          ),
                          TextEditWidget(
                            text: "Senha",
                            sizeText: 3,
                            oculta: true,
                            valueSave: (newValue) =>
                                controller.senha = newValue,
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Text(erro),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 700),
                                  barrierDismissible: true,
                                  opaque: false,
                                  pageBuilder:
                                      (BuildContext context, __, ___) =>
                                          CadastroPage()));
                            },
                            child: Text(
                              "CADASTRA-SE",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Container(
                          child: ElevatedButton(
                            style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 38),
                                backgroundColor: Colors.white),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                _formKey.currentState.save();
                                _formKey.currentState.deactivate();
                                controller.logar(context);
                              }
                            },
                            child: Text(
                              "ENTRAR",
                              style: TextStyle(color: color_btn),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginController {
  String email;
  dynamic senha;

  Future<void> logar(BuildContext context) async {
    try {
      var login =
          new Login(email: email.toLowerCase(), senha: senha.toLowerCase())
              .toJson();
      print(login);
      final response = http.post(Uri.http(api, link + "logins/paciente"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(login));
      response.then((v) {
        if (v.statusCode == 200) {
          Map<dynamic, dynamic> user = jsonDecode(v.body);
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        paciente: new Paciente.fromJson(user),
                      )));
        } else {
          print(v.body);
          Map<String, dynamic> erro = jsonDecode(v.body);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return WillPopScope(
                onWillPop: () async => false,
                child: AlertDialog(
                  title: Text("Login"),
                  content: Text(erro['message']),
                  actions: <Widget>[
                    TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                ),
              );
            },
          );
        }
      }).catchError((v) {
        return showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                title: Text("Login"),
                content: Text("Serviço Fora"),
                actions: <Widget>[
                  TextButton(
                      child: Text("Ok"),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
            );
          },
        );
      });
    } catch (e) {
      print(e.toString());
      print("dd");
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return WillPopScope(
            onWillPop: () async => false,
            child: AlertDialog(
              title: Text("Login"),
              content: Text("Fora Serviço"),
              actions: <Widget>[
                TextButton(
                    child: Text("Ok"),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ],
            ),
          );
        },
      );
    }
  }
}
