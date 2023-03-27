import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:verycomplexjson/model/json_model.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: Complex(),
    );
  }
}

class Complex extends StatefulWidget {
  const Complex({super.key});

  @override
  State<Complex> createState() => _ComplexState();
}

class _ComplexState extends State<Complex> {
  Future<VeryComplexJson> getApi() async {
    var response =
        await http.get(Uri.parse('https://reqres.in/api/users?page=2'));
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return VeryComplexJson.fromJson(data);
    } else {
      return VeryComplexJson.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("yek xin ruknu tw");
              } else if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: snapshot!.data!.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(snapshot!
                                      .data!.data![index].avatar
                                      .toString()),
                                  fit: BoxFit.cover)),
                          child: Text(
                              snapshot!.data!.data![index].email.toString()),
                        ));
                  },
                );
              } else {
                return Text("timro data ma kehi kharabxa");
              }
            },
          ))
        ],
      )),
    );
  }
}
