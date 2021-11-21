import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class Users extends StatefulWidget{
  @override
  _Users createState() => _Users();
}

class _Users extends State<Users>{
  TextEditingController txtName = TextEditingController();
  TextEditingController txtJob = TextEditingController();

  dynamic response;

  Future<bool> createUser(data) async {
    dynamic output = await http.post(
      Uri.parse('https://reqres.in/api/users'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(data),
    );
    output = json.decode(output.body.toString());
    this.response = output;

    return (output['id'] != null) ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create User'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: txtName,
              decoration: InputDecoration(
                label: Text('Name'),
                icon: Icon(Icons.account_circle),
                hintText: 'Enter Name',
              ),
            ),
            TextField(
              controller: txtJob,
              decoration: InputDecoration(
                label: Text('Job'),
                icon: Icon(Icons.account_circle),
                hintText: 'Enter Job Title',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                var user = {
                  'name' : txtName.text,
                  'job' : txtJob.text
                };
                bool response = await createUser(user);
                print(response);
                if(response){
                  _dialog(context);
                }
              },
              child: Text('Add User'),
            )
          ],
        ),
      ),
    );
  }
}

Future<void> _dialog(context){
  return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context){
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text('Success'),
          content: Text('Data insertion successfully done!'),
          elevation: 2,
          backgroundColor: Colors.lightGreen,
          actions: [
            ElevatedButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text("Ok"),
            )
          ],
        );
      }
  );
}