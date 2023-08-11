// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class FormScreen extends StatefulWidget {
  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final _formfield = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final cpfController = TextEditingController();
  bool passToggle = true;
  bool isDoubleTap = false;

  bool validateEmailFormat(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_´{|}~]+@[a-zA-Z0-9]+\.[a-zA-z]+")
        .hasMatch(email);
  }

  bool validatePasswordLength(String password) {
    return password.length >= 6;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crie uma Conta"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Image.asset(
                    "images/avatar.png",
                    height: 200,
                    width: 200,
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cpfController,
                  decoration: InputDecoration(
                    labelText: "CPF",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira um CPF";
                    } else if (value.length < 11) {
                      return "CPF inválido";
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_´{|}~]+@[a-zA-Z0-9]+\.[a-zA-z]+")
                        .hasMatch(value!);

                    if (value!.isEmpty) {
                      return "Insira um email";
                    } else if (!emailValid) {
                      return "Insira um email válido";
                    }
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: senhaController,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    labelText: "Senha",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Insira a senha";
                    } else if (senhaController.text.length < 6) {
                      return "A senha deve ter mais de 6 caracteres";
                    }
                  },
                ),
                SizedBox(height: 60),
                InkWell(
                  onTap: () {
                    if (_formfield.currentState!.validate()) {
                      Navigator.pushNamed(context, '/home');
                      print("Sucesso ao criar a conta!");
                      emailController.clear();
                      senhaController.clear();
                      cpfController.clear();
                    }
                  },
                  onDoubleTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              SizedBox(height: 16),
                              Text('Calma lá! Insira dados válidos.'),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        "Criar Conta",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Já tem uma conta?",
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        String enteredEmail =
                            ''; // Variável para armazenar o email digitado
                        String enteredSenha =
                            ''; // Variável para armazenar a senha digitada

                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Entrar"),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration:
                                        InputDecoration(labelText: 'Email'),
                                    onChanged: (value) {
                                      enteredEmail =
                                          value; // Atualiza a variável do email
                                    },
                                  ),
                                  TextFormField(
                                    obscureText: true,
                                    decoration:
                                        InputDecoration(labelText: 'Senha'),
                                    onChanged: (value) {
                                      enteredSenha =
                                          value; // Atualiza a variável da senha
                                    },
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    if (enteredEmail.isNotEmpty &&
                                        enteredSenha.isNotEmpty &&
                                        validateEmailFormat(enteredEmail) &&
                                        validatePasswordLength(enteredSenha)) {
                                      Navigator.pop(context); // Fechar o pop-up
                                      Navigator.pushNamed(context, '/home');
                                    }
                                  },
                                  child: Text("Entrar"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        "Entrar",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
