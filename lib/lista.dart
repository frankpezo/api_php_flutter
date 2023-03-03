import 'dart:convert';

import 'package:api_php_flutter/update.dart';
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

  //4.1. Creamos el método para eliminar
  Future<void> deteleDatos(String id) async {
    try {
      //4.1.1. Traemos el link
      Uri url = Uri.parse("http://10.0.2.2/crudFlutter/delete.php");
      //4.1.2. Hacemos la petición
      var res = await http.post(url, body: {'id': id});
      var response = jsonDecode(res.body);
      //Creamos condicional para saber si fue exitoso
      if (response['success'] == "true") {
        print('Se eliminó con éxito');
        //4.1.3. Actualizamos la lista
        getDatos();
      } else {
        print('Algo salió mal');
      }
    } catch (e) {
      print('Erro: $e');
    }
  }

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
                  //5. Para llevar a la página que nos permitirá editar los datos
                  //5.1. Mandamos los datos del usuario a la página deseada
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdatePage(
                                  //Para poder pasar estos parametros debemos hacer la modificición en la página
                                  // queremos enviar los datos
                                  userData[index]['uname'],
                                  userData[index]['uemail'],
                                  userData[index]['upassword'],
                                )));
                  },
                  //Cuando utilizamos el método Get, debemos colocar el nombre de la columna
                  //pero como está escrita en la base de datos
                  title: Text(userData[index]['uname']),
                  subtitle: Text(userData[index]['uemail']),
                  //4. Para eliminar de la lista
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      //4.1. Colocamos el médot que nos permitirá eliminar
                      //Para poder elimiar debemos pasar el id como está en la base de datos
                      // y convertirlo a string para que pueda funcionar
                      deteleDatos(userData[index]['uid'].toString());
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
