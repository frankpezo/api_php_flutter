import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdatePage extends StatefulWidget {
  //3.2. Creamos la variables necesario y la insertamos al método creado abajo
  String name;
  String email;
  String password;
  //constructor
  UpdatePage(this.name, this.email, this.password);
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  //1. Declaramos los textController
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  //2. Creamos el método
  Future<void> updateData() async {
    //4. Ya que hemos traidos los datos desde el widget o page de las listas
    //pasamos hacer el código para poder modificar la lista
    try {
      //4.1. Traemos el link
      Uri url = Uri.parse("http://10.0.2.2/crudFlutter/updateData.php");
      //4.2. Hacemos la petición
      var res = await http.post(url, body: {
        'name': name.text,
        'email': email.text,
        'password': password.text,
      });
      var response = jsonDecode(res.body);
      //4.4. Condicional para saber que todo va bien
      if (response['success'] == "true") {
        print('Se actualizó los datos con éxito');
      } else {
        print('Algo salió mal');
      }
    } catch (e) {
      print(e);
    }
  }

  //3. Como tendrá un cambio de estado necesitamos hacerle uni iniState al méotod
  @override
  void initState() {
    // TODO: implement initState
    //3.3. Traemos la variables desde el widget anterior
    name.text = widget.name;
    email.text = widget.email;
    password.text = widget.password;
    //3.1. COlocamos el método
    //updateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Actualizar datos')),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(), //Para que se nos muestre redondo
                  label: Text('Nombre')),
            ),
          ),

          //--1.2. Campo Email
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: email,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(), //Para que se nos muestre redondo
                  label: Text('correo')),
            ),
          ),

          //--1.3. Contraseña
          Container(
            margin: EdgeInsets.all(10),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(
                  border:
                      OutlineInputBorder(), //Para que se nos muestre redondo
                  label: Text('Contraseña')),
            ),
          ),

          //--Button
          Container(
            margin: EdgeInsets.all(10),
            child: ElevatedButton(
              onPressed: () {
                //1.1. Colocamos el método que nos permitirá modificar el método
                // Lo crearemos al inicio.
                updateData();
              },
              child: Text('Actualizar'),
            ),
          ),
        ],
      ),
    );
  }
}
