import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';


void main()=> runApp(
 const MaterialApp(
   title: "Hava Durumu",
   home: Home(),
   debugShowCheckedModeBanner: false,
 )
);
class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;
  Future getWeather() async{

     http.Response response = await 
  http.get(Uri.parse("http://api.openweathermap.org/data/2.5/weather?q=mugla&units=metric&appid=apikey"));
    var result =jsonDecode(response.body);

    setState(() {
      this.temp = result['main']['temp'];
      this.description = result['weather'][0]['description'];
      this.currently = result['main']['humidity'];
      this.windSpeed = result['wind']['speed'];
      
    });

  }
  @override
  void initState(){
    super.initState();
    this.getWeather();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height/3,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            // ignore: prefer_const_literals_to_create_immutables
            children:[
            const Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: Text("Şuanda Muğladasınız",
              style: TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w600),
              ),
            ),
           // ignore: prefer_const_constructors
           Text(
             temp != null ? temp.toString()+"\u0000" : "Yükleniyor", 
             style: const TextStyle(
               color: Colors.white,
               fontSize: 14.0,
               fontWeight: FontWeight.w600
               ),
             ),
              Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Text(
                "Nem: ${currently.toString()}",
               style: const TextStyle(color: Colors.white,fontSize: 14.0,fontWeight: FontWeight.w600),
              ),
            ),
          ],
          ),
        ),
        // ignore: prefer_const_constructors
        Expanded(child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView (
            // ignore: prefer_const_literals_to_create_immutables
            children:[
         ListTile(leading:FaIcon(FontAwesomeIcons.thermometerHalf),
          title: Text("Sıcaklık"),
          trailing: Text( temp != null ? temp.toString()+"\u0000":"Yükleniyor"),),
          ListTile(leading:FaIcon(FontAwesomeIcons.cloud),
          title: Text("Yağmur"),
          trailing: Text(description != null ? description.toString(): "Yükleniyor")),
           ListTile(leading:FaIcon(FontAwesomeIcons.sun),
          title: Text("Nem"),
          trailing: Text(currently.toString()),),
           ListTile(leading:FaIcon(FontAwesomeIcons.wind),
          title: Text("Rüzgar Hızı"),
          trailing: Text(windSpeed != null ? windSpeed.toString():"Yükleniyor" ),),
          ])
          ,
        ),
        ),
      ],),
      
    );
  }
}
