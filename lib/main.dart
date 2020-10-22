import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:fluttermapdemo/Launch_screen.dart';


//hey you fucking bithc come on


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapController = MapController();

    coords = new Map<String, LatLng>();
    coords.putIfAbsent("home", () => LatLng(12.87574, 77.65771));


    points=new List<LatLng>();
    points.add(LatLng(12.8, 77.65));
    points.add(LatLng(12.87574, 77.65771));

  }



  List<Widget> _moveToLoc() {
    List<Widget> list = [
      RaisedButton(
          onPressed: () {
            mapController.move(LatLng(12.87574, 77.65771), 16);
          },
          child: Text(coords.keys.elementAt(0)))
    ];



    return list;



  }


  double zoomslider = 8;
  MapController mapController;

  Map<String, LatLng> coords;





  List<Marker> marker = [
    new Marker(
      width: 80.0,
      height: 80.0,
      point: new LatLng(12.87574, 77.65771),
      builder: (ctx) => new Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
    new Marker(
      width: 80.0,
      height: 80.0,
      point: new LatLng(12.8, 77.65),
      builder: (ctx) => new Icon(
        Icons.pin_drop,
        color: Colors.red,
      ),
    ),
  ];



  List <LatLng> points=[];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: _moveToLoc(),
            ),
            Text('$zoomslider'),
            Slider(
                value: zoomslider,
                min: 8,
                max: 15,
                onChanged: (double value) {
                  setState(() {
                    print(value);
                    zoomslider = value;
                    mapController.move(LatLng(12.87574, 77.65771), zoomslider);
                  });
                }),
            Flexible(
              child: new FlutterMap(
                mapController: mapController,
                options: new MapOptions(
                  center: new LatLng(12.87574, 77.65771),
                  zoom: 10,
                ),
                layers: [
                  new TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: ['a', 'b', 'c']),
                  new MarkerLayerOptions(
                    markers: marker,
                  ),
                  new PolylineLayerOptions(
                  polylines: [Polyline(points: points,
                  strokeWidth: 4)],
                  )
                ],
              ),
            ),

            RaisedButton(
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => launchurl()) );
              },
              child: Text('go to url launch'),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
