import 'package:hedi/app/model/Login.dart';

class Nutricionista {
  int id;
  String nome;
  String endereco;
  String telefone;
  Login login;

  Nutricionista({this.id, this.nome, this.endereco, this.telefone, this.login});

  Nutricionista.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    nome = json['Nome'];
    endereco = json['Endereco'];
    telefone = json['Telefone'];
    login = json['Login'] != null ? new Login.fromJson(json['Login']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Nome'] = this.nome;
    data['Endereco'] = this.endereco;
    data['Telefone'] = this.telefone;
    data['Login'] = this.login?.toJson();
    return data;
  }
}
