import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListDatos extends StatefulWidget {
  ListDatos({Key? key}) : super(key: key);

  @override
  State<ListDatos> createState() => _ListDatosState();
}

class _ListDatosState extends State<ListDatos> {
  //1. Declaramos la función
  Future<void> getDatos() async {
    //3.2. Creamos una lista para obtener las respuestas
    List userData = [];
    //2. Traemos el link
    Uri url = Uri.parse("http://10.0.2.2/crudFlutter/viewdata.php");
    //3. Hacemos la petición
    try {
      //3.1. Hacemos la petición por método get
      var response = await http.get(url);
      userData = jsonDecode(response.body);
    } catch (e) {
      print(e);
    }
  }

  //1.1. Hacemos el void init
  @override
  void initState() {
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
        child: Text('Lista de datos'),
      ),
    );
  }
}
