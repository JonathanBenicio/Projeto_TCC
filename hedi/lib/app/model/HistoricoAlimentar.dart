import 'AlimentoHistorico.dart';

class HistoricoAlimentar {
  double glicemiaObtida;
  double glicemiaAlvo;
  double carboidratosTotal;
  double carboidratosInsulina;
  double insulinaCalculada;
  String dataHora;
  List<AlimentoHistorico> alimentoHistoricos;
  int fkTipoRefeicaoId;
  int fkPacienteId;

  HistoricoAlimentar(
      {this.glicemiaObtida,
      this.glicemiaAlvo,
      this.carboidratosTotal,
      this.carboidratosInsulina,
      this.insulinaCalculada,
      this.dataHora,
      this.alimentoHistoricos,
      this.fkTipoRefeicaoId,
      this.fkPacienteId});

  HistoricoAlimentar.fromJson(Map<String, dynamic> json) {
    glicemiaObtida = json['Glicemia_Obtida'];
    glicemiaAlvo = json['Glicemia_Alvo'];
    carboidratosTotal = json['Carboidratos_Total'];
    carboidratosInsulina = json['Carboidratos_Insulina'];
    insulinaCalculada = json['Insulina_Calculada'];
    dataHora = json['Data_Hora'];
    if (json['Alimento_Historicos'] != null) {
      alimentoHistoricos = new List<AlimentoHistorico>();
      json['Alimento_Historicos'].forEach((v) {
        alimentoHistoricos.add(new AlimentoHistorico.fromJson(v));
      });
    }
    fkTipoRefeicaoId = json['Fk_Tipo_Refeicao_Id'];
    fkPacienteId = json['Fk_Paciente_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Glicemia_Obtida'] = this.glicemiaObtida;
    data['Glicemia_Alvo'] = this.glicemiaAlvo;
    data['Carboidratos_Total'] = this.carboidratosTotal;
    data['Carboidratos_Insulina'] = this.carboidratosInsulina;
    data['Insulina_Calculada'] = this.insulinaCalculada;
    data['Data_Hora'] = this.dataHora;
    if (this.alimentoHistoricos != null) {
      data['Alimento_Historicos'] =
          this.alimentoHistoricos.map((v) => v.toJson()).toList();
    }
    data['Fk_Tipo_Refeicao_Id'] = this.fkTipoRefeicaoId;
    data['Fk_Paciente_Id'] = this.fkPacienteId;
    return data;
  }
}
