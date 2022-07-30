// import 'package:flutter/material.dart';
// import 'package:hedi/app/widgets/text-edit-widget.dart';

// class a extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//               onWillPop: () async => false,
//               child: AlertDialog(
//                 contentPadding: EdgeInsets.all(0),
//                 insetPadding: EdgeInsets.all(0),
//                 scrollable: true,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0)),
//                 content: Column(mainAxisSize: MainAxisSize.min, children: [
//                   FutureBuilder(
//                     future: http.post(
//                       Uri.http(api, link + "historico_alimentars"),
//                       headers: {"Content-Type": "application/json"},
//                       body: jsonEncode(historicoAlimentar.toJson()),
//                     ),
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.done) {
//                         if (snapshot.data.statusCode == 201) {
//                           return Container(
//                               padding: EdgeInsets.only(top: 10),
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Container(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Text("Insulina Calculada",
//                                           style: TextStyle(
//                                               color: primary, fontSize: 32))),
//                                   Container(
//                                       padding: EdgeInsets.only(top: 10),
//                                       child: Text(
//                                         historicoAlimentar.insulinaCalculada
//                                                 .toString() +
//                                             " Unidades",
//                                         style: TextStyle(
//                                             fontSize: 28, color: Colors.green),
//                                       )),
//                                   Container(
//                                     alignment: Alignment.bottomRight,
//                                     child: TextButton(
//                                         child: Text("Ok"),
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).pop();
//                                           Navigator.of(context).pushReplacement(
//                                               MaterialPageRoute(
//                                                   builder: (context) =>
//                                                       HomePage(
//                                                         paciente:
//                                                             widget.paciente,
//                                                       )));
//                                         }),
//                                   )
//                                 ],
//                               ));
//                         } else {
//                           return Container(
//                               child: Column(
//                             children: [
//                               Container(
//                                   padding: EdgeInsets.all(10),
//                                   child: Text("Serviço Fora",
//                                       style: TextStyle(
//                                         color: primary,
//                                         fontSize: 32,
//                                       ))),
//                               Container(
//                                 alignment: Alignment.bottomRight,
//                                 child: TextButton(
//                                     child: Text("Ok"),
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context).pop();
//                                       Navigator.of(context)
//                                           .pushReplacement(MaterialPageRoute(
//                                               builder: (context) => HomePage(
//                                                     paciente: widget.paciente,
//                                                   )));
//                                     }),
//                               )
//                             ],
//                           ));
//                         }
//                       }
//                       return Container(
//                           padding: EdgeInsets.all(20),
//                           child: CircularProgressIndicator());
//                     },
//                   )
//                 ]),
//               ));
//         });
//   }
// }
