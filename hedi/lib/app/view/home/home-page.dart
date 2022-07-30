import 'dart:convert';
import 'package:hedi/app/model/Paciente.dart';
import 'package:hedi/app/model/TipoRefeicaos.dart';
import 'package:hedi/app/service/url.dart';
import 'package:hedi/app/view/alimento/alimento-page.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hedi/app/widgets/text-edit-widget.dart';
import 'package:hedi/styles/colors.dart';
import 'package:hedi/styles/icons.dart';

class HomePage extends StatefulWidget {
  final Paciente paciente;

  HomePage({Key key, this.paciente}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(widget.paciente.toJson());
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: color_btn,
          onPressed: () {
            final newRefeicao = new TipoRefeicaos();
            return showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      scrollable: true,
                      title: Text("Nova Refeição",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      backgroundColor: primary,
                      actions: [
                        TextButton(
                          child: Text(
                            "Cancelar",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          child: Text(
                            "Criar",
                            style: TextStyle(color: primary),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                              newRefeicao.fkPacienteId = widget.paciente.id;
                              print(newRefeicao);
                              try {
                                final response = http.post(
                                    Uri.http(api, link + "tipo_refeicaos"),
                                    headers: {
                                      "Content-Type": "application/json"
                                    },
                                    body: jsonEncode(newRefeicao.toJson()));
                                response.then((value) {
                                  if (value.statusCode == 201) {
                                    Navigator.pop(context);
                                    print("ok");
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            title: Text(
                                              "Cadastrado com Sucesso",
                                              style: TextStyle(
                                                  color: Colors.green),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    print(value.body);
                                    Map<String, dynamic> erro =
                                        jsonDecode(value.body);
                                    print(erro);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async => false,
                                          child: AlertDialog(
                                            title: Text(
                                              "Erro",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pop(context);

                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              } catch (e) {
                                print(e.toString());
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return WillPopScope(
                                      onWillPop: () async => false,
                                      child: AlertDialog(
                                        title: Text("Cadastro de Refeição"),
                                        content: Text("Fora Serviço"),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {});
                                              }),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          },
                        ),
                      ],
                      content: Container(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextEditWidget(
                                    marginTop: 0.0,
                                    text: "Nome",
                                    valueSave: (newValue) =>
                                        newRefeicao.nome = newValue,
                                  ),
                                  TextEditWidget(
                                    time: true,
                                    inputType: TextInputType.datetime,
                                    text: "Horario ",
                                    valueSave: (newValue) =>
                                        newRefeicao.horario = newValue,
                                  ),
                                  TextEditWidget(
                                    inputType: TextInputType.number,
                                    text: "Glicemia Alvo",
                                    valueSave: (newValue) =>
                                        newRefeicao.glicemiaAlvo =
                                            double.parse(newValue.toString()),
                                  )
                                ],
                              ))));
                });
          },
        ),
        body: SafeArea(
            child: Container(
                color: Color(0xFFF5F5F5),
                child: FutureBuilder(
                  future: http.get(Uri.http(
                      api,
                      link +
                          "tipo_refeicaos/paciente/" +
                          widget.paciente.id.toString())),
                  builder: (context, snapshot) {
                    print(snapshot.toString());
                    print(snapshot.data);
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasData) {
                        List<TipoRefeicaos> tipoRefeicaos = [];
                        List<dynamic> newListaRefeicao =
                            jsonDecode(snapshot.data.body);
                        tipoRefeicaos = new List<TipoRefeicaos>();
                        newListaRefeicao.forEach((v) {
                          tipoRefeicaos.add(new TipoRefeicaos.fromJson(v));
                        });
                        return refeicaoList(context, tipoRefeicaos);
                      }
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ))));
  }

  Widget refeicaoList(BuildContext context, List<TipoRefeicaos> listaRefeicao) {
    if (listaRefeicao.isEmpty)
      return Center(
        child: Text("Nehuma refeição cadastrada!"),
      );
    return ListView.builder(
        padding: EdgeInsets.all(15.0),
        itemCount: listaRefeicao.length,
        itemBuilder: (context, index) {
          TipoRefeicaos refeicao = listaRefeicao[index];
          double glicemia = refeicao.glicemiaAlvo;
          String nomeRefeicao = refeicao.nome;
          IconData iconCard;
          Color colorIcon;
          TimeOfDay time = TimeOfDay(
              hour: int.parse(refeicao.horario.substring(0, 2)),
              minute: int.parse(refeicao.horario.substring(3, 5)));

          if (time.hour <= 10) {
            colorIcon = Colors.yellow[700];
            iconCard = Icons.wb_twighlight;
          } else if (time.hour <= 13) {
            iconCard = Icons.wb_sunny;
            colorIcon = Colors.yellow;
          } else if (time.hour <= 18) {
            iconCard = Icons.wb_twighlight;
            colorIcon = Colors.yellow[900];
          } else {
            iconCard = Icons.bedtime;
            colorIcon = Colors.black54;
          }
          return GestureDetector(
              onLongPress: () {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        backgroundColor: Colors.white,
                        title: Text(
                          "Deseja Excluir ?",
                          style: TextStyle(color: primary),
                        ),
                        actions: [
                          TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white),
                            child: Text(
                              "Cancelar",
                              style: TextStyle(color: primary),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          ElevatedButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              "Exluir",
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              try {
                                final response = http.delete(Uri.http(
                                    api,
                                    link +
                                        "tipo_refeicaos/" +
                                        refeicao.id.toString()));
                                response.then((value) {
                                  if (value.statusCode == 200) {
                                    Navigator.pop(context);
                                    print("ok");
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async {
                                            Navigator.pop(context);
                                            setState(() {});
                                            return true;
                                          },
                                          child: AlertDialog(
                                            title: Text(
                                              "Excluido com Sucesso",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            // content: Text(erro['Message']),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    setState(() {});
                                                    Navigator.pop(context);
                                                  }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.pop(context);
                                    print(value.body);
                                    Map<String, dynamic> erro =
                                        jsonDecode(value.body);
                                    print(erro);
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return WillPopScope(
                                          onWillPop: () async {
                                            Navigator.pop(context);
                                            setState(() {});
                                            return true;
                                          },
                                          child: AlertDialog(
                                            title: Text(
                                              "Erro",
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ),
                                            content: Text(erro['Message']),
                                            actions: <Widget>[
                                              TextButton(
                                                  child: Text("Ok"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {});
                                                  }),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }
                                });
                              } catch (e) {
                                print(e.toString());
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return WillPopScope(
                                      onWillPop: () async {
                                        Navigator.pop(context);
                                        setState(() {});
                                        return true;
                                      },
                                      child: AlertDialog(
                                        title: Text(
                                          "Erro",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: Text(e['Message']),
                                        actions: <Widget>[
                                          TextButton(
                                              child: Text("Ok"),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {});
                                              }),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          )
                        ],
                      );
                    });
              },
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AlimentoPage(
                        paciente: widget.paciente, refeicao: refeicao)));
              },
              child: Card(
                  child: Container(
                      height: 80,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Icon(
                              iconCard,
                              size: 80,
                              color: colorIcon,
                            )),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Container(
                                              child: Text(
                                            nomeRefeicao,
                                            style: TextStyle(fontSize: 16),
                                          )),
                                          Container(
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                Container(
                                                    child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.schedule,
                                                      color: primary,
                                                    ),
                                                    Text(
                                                      refeicao.horario
                                                          .substring(0, 5),
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    )
                                                  ],
                                                )),
                                                Container(
                                                    child: Row(children: [
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        right: 3),
                                                    child: Image.asset(
                                                      iconGlic,
                                                      scale: 2,
                                                    ),
                                                  ),
                                                  Text(
                                                    "$glicemia",
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  )
                                                ]))
                                              ]))
                                        ])))
                          ]))));
        });
  }
}
