import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'Users.dart';

void main() {
  runApp(const MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
  List users = [];
  bool isLoading = false;

  @override
  initState(){
    getAllUsers();
    super.initState();
  }

  Future<String> getAllUsers() async{
    setState(() => isLoading = true);
    var response = await http.get(Uri.parse('http://jsonplaceholder.typicode.com/users'));
    setState(() => users = json.decode(response.body.toString()));
    setState(() => isLoading = false);
    return 'get an error';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => Users()));
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: 700,
          child: ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index){
              return ListTile(
                title: Text(users[index]['name']),
                subtitle: Text(users[index]['email']),
              );
            },
          ),
        )
      ),
    );
  }
}