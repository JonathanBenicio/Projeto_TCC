import 'dart:convert';

import 'package:flutter/material.dart';

class Alimento {
  int id;
  String nome;
  String marca;
  String porcaoTipo;
  double porcaoQuantidade;
  double porcaoCarboidratos;
  String tipo;
  Image foto;

  Alimento(
      {this.id,
      this.nome,
      this.marca,
      this.porcaoTipo,
      this.porcaoQuantidade,
      this.porcaoCarboidratos,
      this.tipo,
      this.foto});

  Alimento.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nome = json['Nome'];
    marca = json['Marca'];
    porcaoTipo = json['Porcao_Tipo'];
    porcaoQuantidade = json['Porcao_Quantidade'];
    porcaoCarboidratos = json['Porcao_Carboidratos'];
    tipo = json['Tipo'];
    foto = Image.memory(base64Decode(json['Foto']));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Nome'] = this.nome;
    data['Marca'] = this.marca;
    data['Porcao_Tipo'] = this.porcaoTipo;
    data['Porcao_Quantidade'] = this.porcaoQuantidade;
    data['Porcao_Carboidratos'] = this.porcaoCarboidratos;
    data['Tipo'] = this.tipo;
    data['Foto'] = this.foto;
    return data;
  }
}
