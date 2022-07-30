import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hedi/styles/colors.dart';

class TextEditWidget extends StatefulWidget {
  final String text;
  final TextInputType inputType;
  final bool oculta;
  final int sizeText;
  final ValueChanged<dynamic> valueSave;
  final double marginTop;

  final bool time;

  const TextEditWidget(
      {Key key,
      this.text,
      this.valueSave,
      this.inputType = TextInputType.text,
      this.oculta = false,
      this.sizeText = 0,
      this.time = false,
      this.marginTop = 25.0})
      : super(key: key);
  @override
  _TextEditWidgetState createState() => _TextEditWidgetState();
}

class _TextEditWidgetState extends State<TextEditWidget> {
  final TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    TimeOfDay _picked;

    Future<Null> timePicked(BuildContext context) async {
      _picked =
          await showTimePicker(context: context, initialTime: TimeOfDay.now());

      print(_picked.format(context));
      setState(() {
        controller.text = _picked.format(context);
      });
    }

    return Container(
      margin: EdgeInsets.only(top: widget.marginTop),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                widget.text,
                style: TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.left,
              )),
          // Container(
          //   alignment: Alignment.centerLeft,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(16),
          //     boxShadow: <BoxShadow>[
          //       BoxShadow(
          //           color: Colors.black26,
          //           blurRadius: 8.0,
          //           offset: Offset(4, 4))
          //     ],
          //     color: Colors.white,
          //   ),
          //   margin: EdgeInsets.only(top: 5),
          //   padding: EdgeInsets.only(left: 10),
          //   height: 56,
          //   child: TextFormField(
          //     keyboardType: inputType,
          //     obscureText: oculta,
          //     style: TextStyle(fontSize: 25, color: color_btn),
          //     decoration: InputDecoration(
          //       border: InputBorder.none,
          //       // icon: Icon(Icons.person),
          //       // hintText: 'Informe o nome'
          //     ),
          //     validator: (value) {
          //       if (value.isEmpty) return 'Campo Obrigatorio';
          //       if (value.length < sizeText)
          //         return "Digite $sizeText caracteres";
          //       return null;
          //     },
          //     onSaved: (newValue) {
          //       valueSave(newValue);
          //     },
          //   ),
          // ),
          TextFormField(
            onTap: () {
              if (widget.time) {
                timePicked(context);
              }
            },
            controller: controller,
            keyboardType: widget.inputType,
            obscureText: widget.oculta,
            style: TextStyle(
              fontSize: 25,
              color: color_btn,
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15),
                filled: true,
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: primary,
                    )),
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    borderSide: BorderSide(
                      color: primary,
                    )),
                enabledBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(16.0),
                    borderSide: BorderSide.none)
                //fillColor: Colors.green
                ),
            // icon: Icon(Icons.person),
            // hintText: 'Informe o nome'

            validator: (value) {
              if (value.isEmpty) return 'Campo Obrigatorio';
              if (value.length < widget.sizeText)
                return "Digite $widget.sizeText caracteres";
              return null;
            },
            onSaved: (newValue) {
              widget.valueSave(newValue);
            },
          ),
        ],
      ),
    );
  }
}
