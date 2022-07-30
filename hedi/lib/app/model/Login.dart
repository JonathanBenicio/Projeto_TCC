class Login {
  String email;
  String senha;

  Login({this.email, this.senha});

  Login.fromJson(Map<String, dynamic> json) {
    email = json['Email'];
    senha = json['Senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Email'] = this.email;
    data['Senha'] = this.senha;
    return data;
  }
}
