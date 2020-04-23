import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}


class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => new HomePageState();
}

  final String url ='https://jsonplaceholder.typicode.com/users';
  List data;




class HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Future<String> getData() async {
    Response response = await get(url);
    setState(() {
      data = jsonDecode(response.body);
    });

    return "Suceess";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: new ListView.builder(
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    child: Image.asset('assets/user.png',
                    height: 80.0,
                    width: 70.0,),
                    padding: EdgeInsets.all(10.0),
                  ),
                    Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(data[index]['name'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(data[index]['email'])
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
       
              onTap: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => DetailsScreen(data:data[index]),
                ),
                );
              },
            );
          }),
    );
  }
}
class DetailsScreen extends StatelessWidget{
  Map data;

  DetailsScreen( {Key key,@required this.data}) : super(key:key);
  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(data['name'],
              style:TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ) ,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(data['email'],
                style:TextStyle(
                  fontSize: 20.0,
                ) ,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(data['phone'],
                style:TextStyle(
                  fontSize: 20.0,
                ) ,),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(data['username'],
                style:TextStyle(
                  fontSize: 20.0,
                ) ,),
            )
          ],
        )
      ),
    );
  }
}
