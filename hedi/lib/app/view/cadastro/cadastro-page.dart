import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hedi/app/model/Login.dart';
import 'package:hedi/app/model/Nutricionista.dart';
import 'package:hedi/app/model/Paciente.dart';
import 'package:hedi/app/service/url.dart';
import 'package:hedi/app/widgets/text-edit-widget.dart';
import 'package:hedi/styles/colors.dart';
import 'package:http/http.dart' as http;

class CadastroPage extends StatefulWidget {
  @override
  _CadastroPageState createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();
  Paciente pac = new Paciente();

  String tipo = "Tipo 1";
  @override
  Widget build(BuildContext context) {
    pac.login = new Login();
    pac.nutricionista = new Nutricionista();
    pac.nutricionista.login = new Login();
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: color_backBlue)),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.close,
                        color: Color(0xFF03DACB),
                        size: 43,
                      )),
                ),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Realize seu Cadastro:",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    )),
                Form(
                    key: _formKey,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: Column(
                          children: [
                            TextEditWidget(
                              text: "Nome Completo:",
                              inputType: TextInputType.name,
                              valueSave: (newValue) {
                                pac.nome = newValue;
                              },
                            ),
                            TextEditWidget(
                              text: "Email:",
                              valueSave: (newValue) {
                                pac.login.email = newValue.toString();
                              },
                            ),
                            TextEditWidget(
                              text: "Telefone:",
                              inputType: TextInputType.phone,
                              valueSave: (newValue) {
                                pac.telefone = newValue;
                              },
                            ),
                            TextEditWidget(
                              text: "Senha:",
                              sizeText: 6,
                              oculta: true,
                              valueSave: (newValue) {
                                pac.login.senha = newValue;
                              },
                            ),
                            TextEditWidget(
                              text: "Email do Nutricionista:",
                              inputType: TextInputType.emailAddress,
                              valueSave: (newValue) {
                                pac.nutricionista.login.email =
                                    newValue.toString();
                              },
                            ),
                            TextEditWidget(
                              text: "Fator de Sensibilidade:",
                              inputType: TextInputType.number,
                              valueSave: (newValue) {
                                pac.fatorSensibilidade =
                                    double.parse(newValue.toString());
                              },
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Tipo de Diabetes:",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          )),
                                      DropdownButtonFormField(
                                        elevation: 16,
                                        isExpanded: true,
                                        onSaved: (newValue) {
                                          if (newValue == 'Tipo 1') {
                                            pac.tipoDiabetes = 1;
                                          }
                                          if (newValue == 'Tipo 2') {
                                            pac.tipoDiabetes = 2;
                                          }
                                          if (newValue == 'Gestacional') {
                                            pac.tipoDiabetes = 3;
                                          }
                                          if (newValue == 'Pré-Diabetes') {
                                            pac.tipoDiabetes = 4;
                                          }
                                        },
                                        style: TextStyle(
                                            color: primary, fontSize: 25),
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        16.0),
                                                borderSide: BorderSide(
                                                  color: primary,
                                                )),
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        16.0),
                                                borderSide: BorderSide(
                                                  color: primary,
                                                )),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        16.0),
                                                borderSide: BorderSide.none)
                                            //fillColor: Colors.green
                                            ),
                                        onChanged: (String newValue) {
                                          setState(() {
                                            tipo = newValue;
                                          });
                                        },
                                        items: <String>[
                                          'Tipo 1',
                                          'Tipo 2',
                                          'Gestacional',
                                          'Pré-Diabetes'
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      )
                                    ])),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: 38),
                                  backgroundColor: Colors.white,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    _formKey.currentState.deactivate();
                                    _formKey.currentState.save();
                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return WillPopScope(
                                              onWillPop: () async => false,
                                              child: AlertDialog(
                                                  contentPadding:
                                                      EdgeInsets.all(0),
                                                  insetPadding:
                                                      EdgeInsets.all(0),
                                                  scrollable: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15.0)),
                                                  content: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        FutureBuilder(
                                                            future: http.post(
                                                                Uri.http(
                                                                    api,
                                                                    link +
                                                                        "pacientes"),
                                                                headers: {
                                                                  "Content-Type":
                                                                      "application/json"
                                                                },
                                                                body: jsonEncode(pac
                                                                    .toJson())),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .done) {
                                                                if (snapshot
                                                                        .data
                                                                        ?.statusCode ==
                                                                    201) {
                                                                  return Container(
                                                                    padding: EdgeInsets.only(
                                                                        top: 10,
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                    child: Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize
                                                                                .max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Text(
                                                                            "Cadastrado com Sucesso",
                                                                            style:
                                                                                TextStyle(color: Colors.green, fontSize: 30),
                                                                          ),
                                                                          Container(
                                                                              child: ElevatedButton(
                                                                                  style: TextButton.styleFrom(
                                                                                    shape: RoundedRectangleBorder(
                                                                                      borderRadius: BorderRadius.circular(4),
                                                                                    ),
                                                                                    padding: EdgeInsets.symmetric(horizontal: 38),
                                                                                    backgroundColor: Colors.white,
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.of(context).pop();
                                                                                    Navigator.of(context).pop();
                                                                                  },
                                                                                  child: Text(
                                                                                    "LOGAR",
                                                                                    style: TextStyle(color: color_btn),
                                                                                  ))),
                                                                        ]),
                                                                  );
                                                                } else {
                                                                  return Container(
                                                                      child:
                                                                          Column(
                                                                    children: [
                                                                      Container(
                                                                          padding: EdgeInsets.all(
                                                                              10),
                                                                          child: Text(
                                                                              "Serviço Fora",
                                                                              style: TextStyle(
                                                                                color: Colors.red,
                                                                                fontSize: 32,
                                                                              ))),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.bottomRight,
                                                                        child: TextButton(
                                                                            child: Text("Ok"),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                              Navigator.of(context).pop();
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ));
                                                                }
                                                              }
                                                              return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              20),
                                                                  child:
                                                                      CircularProgressIndicator());
                                                            })
                                                      ])));
                                        });
                                  }
                                },
                                child: Text(
                                  "CADASTRA-SE",
                                  style: TextStyle(color: color_btn),
                                ),
                              ),
                            )
                          ],
                        ))),
              ],
            )
          ],
        ),
      )),
    );
  }
}
