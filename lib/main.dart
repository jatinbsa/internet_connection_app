import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
        // counter didn't reset back to zero; the application is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var _connecction_status='unknown';
  Connectivity connectivity;
  StreamSubscription<ConnectivityResult> subscription;

  @override
  void dispose() {
    subscription.cancel();
    // TODO: implement dispose
    super.dispose();
  }
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    connectivity=new Connectivity();
    subscription=connectivity.onConnectivityChanged.listen((ConnectivityResult con){
      _connecction_status=con.toString();
      if(con==ConnectivityResult.wifi || con==ConnectivityResult.mobile ){
        setState(() {

        });
      }
      else{

      }

    });
  }




   Future getData() async{
      http.Response response=await http.get("https://jsonplaceholder.typicode.com/posts/");
          if(response.statusCode==HttpStatus.OK){
               var result=jsonDecode(response.body);

               return result;


          }
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Connectivity"),
      ),
      body: new FutureBuilder(
          future:getData() ,
          builder: (context,snapshot){
            if(snapshot.hasData){
              var myData=snapshot.data;
              return new ListView.builder(
                  itemBuilder: (context,i)=>new ListTile(
                    title: Text(myData[i]['title']),
                  ),
                itemCount: myData.length,
              );
            }
            else{
              return Center(
                child: new CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
}
