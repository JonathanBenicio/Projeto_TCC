import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hedi/app/model/AlimentoHistorico.dart';
import 'package:hedi/app/model/HistoricoAlimentar.dart';
import 'package:hedi/app/model/Paciente.dart';
import 'package:hedi/app/model/TipoRefeicaos.dart';
import 'package:hedi/app/service/url.dart';
import 'package:hedi/app/view/home/home-page.dart';
import 'package:hedi/app/widgets/text-edit-widget.dart';
import 'package:hedi/styles/colors.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CriarRefeicaoPage extends StatefulWidget {
  final List<AlimentoHistorico> listAlimento;
  final TipoRefeicaos refeicao;
  final Paciente paciente;
  const CriarRefeicaoPage(
      {Key key, this.listAlimento, this.refeicao, this.paciente})
      : super(key: key);
  @override
  _CriarRefeicaoPageState createState() => _CriarRefeicaoPageState();
}

class _CriarRefeicaoPageState extends State<CriarRefeicaoPage> {
  HistoricoAlimentar historicoAlimentar = new HistoricoAlimentar();

  final _formKeyRef = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    historicoAlimentar.carboidratosTotal = 0;
    historicoAlimentar.alimentoHistoricos = widget.listAlimento;
    widget.listAlimento.forEach((v) {
      historicoAlimentar.carboidratosTotal =
          historicoAlimentar.carboidratosTotal + v.carboidratosTotal;
    });

    historicoAlimentar.dataHora =
        DateFormat('HH:mm:ss').format(DateTime.now()) + widget.refeicao.horario;
    historicoAlimentar.glicemiaAlvo = widget.refeicao.glicemiaAlvo;
    historicoAlimentar.fkTipoRefeicaoId = widget.refeicao.id;
    historicoAlimentar.fkPacienteId = widget.paciente.id;
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
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  child: FloatingActionButton(
                      backgroundColor: Colors.white,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xFF03DACB),
                        size: 43,
                      )),
                ),
                Container(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(
                      "Criando Refeição:",
                      style: TextStyle(color: Colors.white, fontSize: 32),
                    )),
                Form(
                    key: _formKeyRef,
                    child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 34),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextEditWidget(
                              text: "Glicemia Obtida",
                              inputType: TextInputType.number,
                              valueSave: (newValue) =>
                                  historicoAlimentar.glicemiaObtida =
                                      double.parse(newValue.toString()),
                            ),
                            TextEditWidget(
                              text:
                                  "Insulina cobre quantas gramas de carboidratos: ",
                              inputType: TextInputType.number,
                              valueSave: (newValue) =>
                                  historicoAlimentar.carboidratosInsulina =
                                      double.parse(newValue.toString()),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      "Glicemia Alvo: " +
                                          widget.refeicao.glicemiaAlvo
                                              .toString(),
                                      style: TextStyle(color: Colors.white)),
                                  Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                          "Quantidade Carboitrados:  " +
                                              historicoAlimentar
                                                  .carboidratosTotal
                                                  .toString() +
                                              " g HC",
                                          style:
                                              TextStyle(color: Colors.white))),
                                  Container(
                                      margin: EdgeInsets.only(top: 20),
                                      child: Text(
                                          "Fator de Sensibilidade: " +
                                              widget.paciente.fatorSensibilidade
                                                  .toString(),
                                          style:
                                              TextStyle(color: Colors.white))),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.white),
                                child: Text(
                                  "Calcular Insulina",
                                  style: TextStyle(color: primary),
                                ),
                                onPressed: () {
                                  if (_formKeyRef.currentState.validate()) {
                                    _formKeyRef.currentState.save();
                                    final correcao = (historicoAlimentar
                                                .glicemiaObtida -
                                            historicoAlimentar.glicemiaAlvo) /
                                        widget.paciente.fatorSensibilidade;
                                    final insuCarbo = historicoAlimentar
                                            .carboidratosTotal /
                                        historicoAlimentar.carboidratosInsulina;
                                    final total = correcao + insuCarbo;
                                    historicoAlimentar.insulinaCalculada =
                                        double.tryParse(
                                            total.toStringAsPrecision(2));
                                    historicoAlimentar.dataHora =
                                        widget.refeicao.horario;

                                    return showDialog(
                                        context: context,
                                        builder: (context) {
                                          return WillPopScope(
                                              onWillPop: () async => false,
                                              child: AlertDialog(
                                                contentPadding:
                                                    EdgeInsets.all(0),
                                                insetPadding: EdgeInsets.all(0),
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
                                                                  "historico_alimentars"),
                                                          headers: {
                                                            "Content-Type":
                                                                "application/json"
                                                          },
                                                          body: jsonEncode(
                                                              historicoAlimentar
                                                                  .toJson()),
                                                        ),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            if (snapshot.data
                                                                    .statusCode ==
                                                                201) {
                                                              return Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 10),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .min,
                                                                    children: [
                                                                      Container(
                                                                          padding: EdgeInsets.only(
                                                                              top:
                                                                                  10),
                                                                          child: Text(
                                                                              "Insulina Calculada",
                                                                              style: TextStyle(color: primary, fontSize: 32))),
                                                                      Container(
                                                                          padding: EdgeInsets.only(
                                                                              top:
                                                                                  10),
                                                                          child:
                                                                              Text(
                                                                            historicoAlimentar.insulinaCalculada.toString() +
                                                                                " Unidades",
                                                                            style:
                                                                                TextStyle(fontSize: 28, color: Colors.green),
                                                                          )),
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.bottomRight,
                                                                        child: TextButton(
                                                                            child: Text("Ok"),
                                                                            onPressed: () {
                                                                              Navigator.of(context).pop();
                                                                              Navigator.of(context).pop();
                                                                              Navigator.of(context).pop();
                                                                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                                  builder: (context) => HomePage(
                                                                                        paciente: widget.paciente,
                                                                                      )));
                                                                            }),
                                                                      )
                                                                    ],
                                                                  ));
                                                            } else {
                                                              return Container(
                                                                  child: Column(
                                                                children: [
                                                                  Container(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              10),
                                                                      child: Text(
                                                                          "Serviço Fora",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                primary,
                                                                            fontSize:
                                                                                32,
                                                                          ))),
                                                                  Container(
                                                                    alignment:
                                                                        Alignment
                                                                            .bottomRight,
                                                                    child: TextButton(
                                                                        child: Text("Ok"),
                                                                        onPressed: () {
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.of(context)
                                                                              .pop();
                                                                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                                              builder: (context) => HomePage(
                                                                                    paciente: widget.paciente,
                                                                                  )));
                                                                        }),
                                                                  )
                                                                ],
                                                              ));
                                                            }
                                                          }
                                                          return Container(
                                                              padding:
                                                                  EdgeInsets
                                                                      .all(20),
                                                              child:
                                                                  CircularProgressIndicator());
                                                        },
                                                      )
                                                    ]),
                                              ));
                                        });
                                  }
                                },
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
