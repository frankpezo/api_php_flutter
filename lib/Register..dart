import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterUser extends StatefulWidget {
  RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  //2. Definimos los controllers
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  //3. Creamos la función que nos permitirá agregar usuarios
  Future<void> insertarUser() async {
    if (name.text.isNotEmpty ||
        email.text.isNotEmpty ||
        password.text.isNotEmpty) {
      try {
        Uri url = Uri.parse("http://10.0.2.2/crudFlutter/insertar.php");
        var res = await http.post(url, body: {
          'name': name.text,
          'email': email.text,
          'password': password.text
        });

        var response = jsonDecode(res.body);
        if (response['success'] == "true") {
          print('Se registro con éxito');
        } else {
          print('Algo salió mal');
        }
      } catch (e) {
        print(e);
      }
    } else {
      print('Rellene todos los formularios');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //1. Creamos los campos
        //--1.1. Campo Nombre
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: name,
            decoration: InputDecoration(
                border: OutlineInputBorder(), //Para que se nos muestre redondo
                label: Text('Nombre')),
          ),
        ),

        //--1.2. Campo Email
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: email,
            decoration: InputDecoration(
                border: OutlineInputBorder(), //Para que se nos muestre redondo
                label: Text('correo')),
          ),
        ),

        //--1.3. Contraseña
        Container(
          margin: EdgeInsets.all(10),
          child: TextFormField(
            controller: password,
            decoration: InputDecoration(
                border: OutlineInputBorder(), //Para que se nos muestre redondo
                label: Text('Contraseña')),
          ),
        ),

        //--Button
        Container(
          margin: EdgeInsets.all(10),
          child: ElevatedButton(
            onPressed: () {
              insertarUser();
            },
            child: Text('Registrar'),
          ),
        ),

        //Para poder visualizar los datos
      ],
    );
  }
}
