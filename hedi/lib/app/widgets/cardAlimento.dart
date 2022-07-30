import 'package:flutter/material.dart';
import 'package:hedi/app/model/Alimento.dart';
import 'package:hedi/styles/colors.dart';

class CardAlimento extends StatefulWidget {
  final Alimento alimento;
  final ValueChanged<double> valueSave;
  const CardAlimento({Key key, this.alimento, this.valueSave})
      : super(key: key);
  @override
  _CardAlimentoState createState() => _CardAlimentoState();
}

class _CardAlimentoState extends State<CardAlimento> {
  double quant = 0;
  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30),
                topRight: Radius.circular(5),
                bottomRight: Radius.circular(5))),
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topLeft: Radius.circular(20),
                  ),
                  color: Colors.white,
                  image: DecorationImage(image: widget.alimento.foto.image)),

              // child: widget.alimento.foto,
              height: MediaQuery.of(context).size.height * 0.125,
              width: MediaQuery.of(context).size.height * 0.125,
            ),
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5))),
              alignment: Alignment.topLeft,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        widget.alimento.nome.toUpperCase(),
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Marca: ",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                  Text(
                                    widget.alimento.marca.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Tipo: ",
                                    style: TextStyle(
                                        color: Colors.white70, fontSize: 12),
                                  ),
                                  Text(
                                    widget.alimento.tipo.toUpperCase(),
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Peso: ",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                                Text(
                                  widget.alimento.porcaoQuantidade.toString() +
                                      " " +
                                      widget.alimento.porcaoTipo,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Carboidratos: ",
                                  style: TextStyle(
                                      color: Colors.white70, fontSize: 12),
                                ),
                                Text(
                                  widget.alimento.porcaoCarboidratos
                                          .toString() +
                                      " KCal",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: Container(
                        height: 30,
                        margin: EdgeInsets.only(top: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                                child: TextButton(
                              onPressed: () {
                                if (quant > 0) {
                                  widget.valueSave(
                                      quant - widget.alimento.porcaoQuantidade);
                                  setState(() {
                                    quant -= widget.alimento.porcaoQuantidade;
                                  });
                                }
                              },
                              child: Icon(Icons.remove, color: primary),
                            )),
                            Container(
                              alignment: Alignment.center,
                              child: Text(quant.toString() +
                                  " " +
                                  widget.alimento.porcaoTipo),
                            ),
                            Container(
                              child: TextButton(
                                child: Icon(Icons.add, color: primary),
                                onPressed: () {
                                  widget.valueSave(
                                      quant + widget.alimento.porcaoQuantidade);
                                  setState(() {
                                    quant += widget.alimento.porcaoQuantidade;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            )),
          ],
        ));
  }
}
