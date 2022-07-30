class AlimentoHistorico {
  double quantidade;
  double carboidratosTotal;
  int fkAlimentoId;

  AlimentoHistorico({
    this.quantidade,
    this.carboidratosTotal,
    this.fkAlimentoId,
  });

  AlimentoHistorico.fromJson(Map<String, dynamic> json) {
    quantidade = json['Quantidade'];
    carboidratosTotal = json['Carboidratos_Total'];
    fkAlimentoId = json['Fk_Alimento_Id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Quantidade'] = this.quantidade;
    data['Carboidratos_Total'] = this.carboidratosTotal;
    data['Fk_Alimento_Id'] = this.fkAlimentoId;
    return data;
  }
}
