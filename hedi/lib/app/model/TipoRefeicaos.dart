import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TipoRefeicaos {
  int id;
  String nome;
  String horario;
  double glicemiaAlvo;
  Null paciente;
  int fkPacienteId;
  Null historicoAlimentar;

  TipoRefeicaos(
      {this.id,
      this.nome,
      this.horario,
      this.glicemiaAlvo,
      this.paciente,
      this.fkPacienteId,
      this.historicoAlimentar});

  TipoRefeicaos.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nome = json['Nome'];
    horario = json['Horario'];
    glicemiaAlvo = json['Glicemia_Alvo'];
    // paciente = json['Paciente'];
    fkPacienteId = json['Fk_Paciente_Id'];
    historicoAlimentar = json['Historico_Alimentar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.horario.length > 6) {
      data['Horario'] =
          DateFormat.Hms().format(DateFormat.jm().parse(this.horario));
    } else {
      data['Horario'] =
          DateFormat.Hms().format(DateFormat.Hm().parse(this.horario));
    }
    data['Id'] = this.id;
    data['Nome'] = this.nome;
    data['Glicemia_Alvo'] = this.glicemiaAlvo;
    // data['Paciente'] = this.paciente;
    data['Fk_Paciente_Id'] = this.fkPacienteId;
    data['Historico_Alimentar'] = this.historicoAlimentar;
    return data;
  }
}
