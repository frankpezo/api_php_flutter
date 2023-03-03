import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListDatos extends StatefulWidget {
  ListDatos({Key? key}) : super(key: key);

  @override
  State<ListDatos> createState() => _ListDatosState();
}

class _ListDatosState extends State<ListDatos> {
  //3.2. Creamos una lista para obtener las respuestas
  List userData = [];
  //1. Declaramos la función
  Future<void> getDatos() async {
    //2. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/crudFlutter/viewdato.php");
    //3.3. Hacemos un setState para actualizar la lista
    //3. Hacemos la petición
    try {
      //3.1. Hacemos la petición por método get
      var response = await http.get(url);
      //3.2. Utilizamos un setState
      setState(() {
        userData = jsonDecode(response.body);
      });
    } catch (e) {
      print(e);
    }
  }

  //1.1. Hacemos el void init
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    getDatos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de datos'),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  //Cuando utilizamos el método Get, debemos colocar el nombre de la columna
                  //pero como está escrita en la base de datos
                  title: Text(userData[index]['uname'].toString()),
                  subtitle: Text(userData[index]['uemail'].toString()),
                ),
              );
            }),
      ),
    );
  }
}
