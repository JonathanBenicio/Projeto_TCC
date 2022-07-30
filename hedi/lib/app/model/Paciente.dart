import 'package:hedi/app/model/Login.dart';

import 'Nutricionista.dart';

class Paciente {
  int id;
  String nome;
  String telefone;
  double fatorSensibilidade;
  int tipoDiabetes;
  Nutricionista nutricionista;
  String token;
  Login login;

  Paciente({
    this.id,
    this.nome,
    this.telefone,
    this.fatorSensibilidade,
    this.tipoDiabetes,
    this.nutricionista,
    this.token,
    this.login,
  });

  Paciente.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nome = json['Nome'];
    telefone = json['Telefone'];
    fatorSensibilidade = json['Fator_Sensibilidade'];
    tipoDiabetes = json['Tipo_Diabetes'];
    nutricionista = json['Nutricionista'] != null
        ? new Nutricionista.fromJson(json['Nutricionista'])
        : null;
    token = json['Token'];
    login = new Login.fromJson(json['Login']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Nome'] = this.nome;
    data['Telefone'] = this.telefone;
    data['Fator_Sensibilidade'] = this.fatorSensibilidade;
    data['Tipo_Diabetes'] = this.tipoDiabetes;
    data['Nutricionista'] = this.nutricionista.toJson();
    data['Token'] = this.token;
    data['Login'] = this.login.toJson();
    return data;
  }
}
