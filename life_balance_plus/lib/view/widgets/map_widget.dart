import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;
import 'package:life_balance_plus/data/locator.dart';

// Test GeoJson so it the widget doesn't need to spend api calls while testing
String testGeoJson =
    '{"type":"FeatureCollection","metadata":{"attribution":"openrouteservice.org | OpenStreetMap contributors","service":"routing","timestamp":1699755403066,"query":{"coordinates":[[8.681495,49.41461],[8.687872,49.420318]],"profile":"foot-walking","format":"json"},"engine":{"version":"7.1.0","build_date":"2023-07-09T01:31:50Z","graph_date":"2023-10-29T22:15:52Z"}},"bbox":[8.681423,49.414599,8.687872,49.420319],"features":[{"bbox":[8.681423,49.414599,8.687872,49.420319],"type":"Feature","properties":{"transfers":0,"fare":0,"segments":[{"distance":1039.8,"duration":748.6,"steps":[{"distance":1.9,"duration":1.4,"type":11,"instruction":"Head west on Gerhart-Hauptmann-Straße","name":"Gerhart-Hauptmann-Straße","way_points":[0,1]},{"distance":409.5,"duration":294.8,"type":3,"instruction":"Turn sharp right onto Wielandtstraße","name":"Wielandtstraße","way_points":[1,12]},{"distance":126.5,"duration":91.1,"type":1,"instruction":"Turn right","name":"-","way_points":[12,15]},{"distance":11,"duration":7.9,"type":0,"instruction":"Turn left","name":"-","way_points":[15,19]},{"distance":10.6,"duration":7.6,"type":1,"instruction":"Turn right","name":"-","way_points":[19,23]},{"distance":44.7,"duration":32.1,"type":0,"instruction":"Turn left","name":"-","way_points":[23,24]},{"distance":277.9,"duration":200.1,"type":1,"instruction":"Turn right","name":"-","way_points":[24,31]},{"distance":18.7,"duration":13.4,"type":0,"instruction":"Turn left","name":"-","way_points":[31,36]},{"distance":4.1,"duration":2.9,"type":1,"instruction":"Turn right","name":"-","way_points":[36,37]},{"distance":70.4,"duration":50.7,"type":0,"instruction":"Turn left onto Werderplatz","name":"Werderplatz","way_points":[37,39]},{"distance":64.7,"duration":46.6,"type":1,"instruction":"Turn right onto Roonstraße","name":"Roonstraße","way_points":[39,40]},{"distance":0,"duration":0,"type":10,"instruction":"Arrive at Roonstraße, straight ahead","name":"-","way_points":[40,40]}]}],"way_points":[0,40],"summary":{"distance":1039.8,"duration":748.6}},"geometry":{"coordinates":[[8.681496,49.414601],[8.68147,49.414599],[8.681488,49.41465],[8.681423,49.415699],[8.681423,49.415746],[8.681427,49.415802],[8.681656,49.41659],[8.681826,49.417081],[8.681875,49.417287],[8.681881,49.417392],[8.681865,49.417471],[8.681784,49.417632],[8.681533,49.41822],[8.681582,49.418226],[8.681671,49.418251],[8.683225,49.418504],[8.683221,49.418521],[8.683217,49.418555],[8.683213,49.418582],[8.683209,49.418602],[8.683239,49.418609],[8.683285,49.418613],[8.683325,49.418617],[8.683353,49.41862],[8.683254,49.419017],[8.684958,49.419206],[8.684973,49.419208],[8.68503,49.419215],[8.685085,49.41922],[8.68511,49.419223],[8.686455,49.419359],[8.687043,49.419426],[8.687041,49.419438],[8.687039,49.419467],[8.687037,49.419506],[8.687036,49.419527],[8.687026,49.419593],[8.687082,49.419598],[8.687013,49.420078],[8.686989,49.420228],[8.687872,49.420319]],"type":"LineString"}}]}';

String key = "5b3ce3597851110001cf62484c4b229d4838430292ded200c52de5e0";


class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> {
  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultMarkerColor: Colors.red,
    defaultPolygonBorderColor: Colors.red,
    defaultPolygonFillColor: Colors.red.withOpacity(0.1),
    defaultCircleMarkerColor: Colors.red.withOpacity(0.15),
  );

  bool loadingData = false;

  Future<void> getDirections() async {
    // Uncomment for test http response
    // geoJsonParser.parseGeoJsonAsString(testGeoJson);
    // return;

    Map coords = await Locator.getCurrentLocation();
    double startLat = coords['latitudo'];
    double startLng = coords['longitude'];
    double endLat = startLat + 0.00312;
    double endLng = startLng + 0.00312;

    String url = '''
    https://api.openrouteservice.org/v2/directions/foot-walking?api_key=${key}&start=${startLat},${startLng}&end=${endLat},${endLng}
    ''';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      geoJsonParser.parseGeoJsonAsString(response.body);
    } else {
      return Future.error("Maps server unreachable");
    }
  }

  @override
  void initState() {
    loadingData = true;
    getDirections().then((_) {
      setState(() {
        loadingData = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FlutterMap(
          mapController: MapController(),
          options: const MapOptions(
            initialCenter: LatLng(8.681495, 49.41461),
            initialZoom: 5,
          ),
          children: [
            TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c']),
            loadingData
                ? const Center(child: CircularProgressIndicator())
                : PolygonLayer(
              polygons: geoJsonParser.polygons,
            ),
            if (!loadingData) PolylineLayer(polylines: geoJsonParser.polylines),
            if (!loadingData) MarkerLayer(markers: geoJsonParser.markers),
            if (!loadingData) CircleLayer(circles: geoJsonParser.circles),
          ],
        ));
  }
}
