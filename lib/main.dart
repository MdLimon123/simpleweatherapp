import 'package:flutter/material.dart';
import 'package:simpleweatherapp/api_services/apidata.dart';
import 'package:simpleweatherapp/models/model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  WeatherInfo _weatherInfo = WeatherInfo();
  WeatherModels? _weatherModels;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();

  }

  getData() async{

    _weatherModels = await _weatherInfo.getWeather('Dhaka');

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Api '),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: getData(),
        builder: (context, info){

          if(info.connectionState == ConnectionState.done){
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.wb_sunny_rounded, color: Colors.orange, size: 80,),
                  Text(_weatherModels!.main!.temp.toString()+'°C', style: TextStyle(fontSize: 65),),
                  Text(_weatherModels!.name.toString(), style: TextStyle(fontSize: 30),),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('Wind'),
                      Text(_weatherModels!.wind!.speed.toString()+' km/h'),

                      Text('feels_like'),
                      Text(_weatherModels!.main!.feelsLike.toString())
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('humidity'),
                      Text(_weatherModels!.main!.humidity.toString()),

                      Text('description'),
                      Text(_weatherModels!.weather![0].description.toString())
                    ],
                  ),
                ],
              ),
            );
          }else{
            return Center(
              child: Container(
                child: Text('Loading...'),
              ),
            );
          }


        },
      ),
    );
  }
}
