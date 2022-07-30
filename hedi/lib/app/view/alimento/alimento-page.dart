import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hedi/app/model/Alimento.dart';
import 'package:hedi/app/model/AlimentoHistorico.dart';
import 'package:hedi/app/model/Paciente.dart';
import 'package:hedi/app/model/TipoRefeicaos.dart';
import 'package:hedi/app/service/url.dart';
import 'package:hedi/app/view/refeicao/criar-refeicao-page.dart';
import 'package:hedi/app/widgets/cardAlimento.dart';
import 'package:hedi/styles/colors.dart';
import 'package:http/http.dart' as http;

class AlimentoPage extends StatefulWidget {
  final TipoRefeicaos refeicao;
  final Paciente paciente;
  const AlimentoPage({Key key, this.refeicao, this.paciente}) : super(key: key);
  @override
  _AlimentoPageState createState() => _AlimentoPageState();
}

List<AlimentoHistorico> listAlimentoHistorico = [];

class _AlimentoPageState extends State<AlimentoPage> {
  @override
  void dispose() {
    listAlimentoHistorico = [];
    super.dispose();
  }

  @override
  void setState(fn) {
    listAlimentoHistorico = [];
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.done,
          color: primary,
        ),
        backgroundColor: Colors.white,
        onPressed: () {
          if (listAlimentoHistorico.isNotEmpty) {
            return Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => CriarRefeicaoPage(
                      listAlimento: listAlimentoHistorico,
                      paciente: widget.paciente,
                      refeicao: widget.refeicao,
                    )));
          } else {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text(
                    "Alerta",
                    style: TextStyle(color: Colors.red),
                  ),
                  content: Text("Nenhum alimento adicionado"),
                  actions: <Widget>[
                    TextButton(
                        child: Text("Ok"),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(15.0),
              color: Color(0xFFF5F5F5),
              child: FutureBuilder(
                future: http.get(Uri.http(api, link + "alimentos")),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      List<Alimento> alimentos = [];
                      List<dynamic> newListAlimento =
                          jsonDecode(snapshot.data.body);
                      newListAlimento.forEach((v) {
                        alimentos.add(new Alimento.fromJson(v));
                      });
                      return alimentoList(context, alimentos);
                    }
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ))),
    );
  }
}

Widget alimentoList(BuildContext context, List<Alimento> listaAlimento) {
  if (listaAlimento.isEmpty)
    return Center(
      child: Text("Nenhum alimento cadastrado!"),
    );
  return ListView.builder(
      padding: EdgeInsets.all(0.0),
      itemCount: listaAlimento.length,
      itemBuilder: (context, index) {
        final alimento = listaAlimento[index];
        return CardAlimento(
          alimento: alimento,
          valueSave: (newValue) {
            if (listAlimentoHistorico
                    .any((x) => x.fkAlimentoId == alimento.id) &&
                newValue >= alimento.porcaoQuantidade) {
              final alimentoList = listAlimentoHistorico
                  .firstWhere((element) => element.fkAlimentoId == alimento.id);
              alimentoList.quantidade = newValue;
              alimentoList.carboidratosTotal =
                  (newValue / alimento.porcaoQuantidade) *
                      alimento.porcaoCarboidratos;

              print("Alimento Alt");
            } else if (newValue > 0) {
              listAlimentoHistorico.add(new AlimentoHistorico(
                fkAlimentoId: alimento.id,
                quantidade: alimento.porcaoQuantidade,
                carboidratosTotal: alimento.porcaoCarboidratos,
              ));
              print("Alimento Add");
            } else {
              listAlimentoHistorico.removeWhere(
                  (element) => element.fkAlimentoId == alimento.id);
              print("Alimento Removido");
            }
          },
        );
      });
}
