import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_geojson/flutter_map_geojson.dart';
import 'package:http/http.dart' as http;

import 'package:life_balance_plus/data/locator.dart';

// Test GeoJson so the widget doesn't need to spend api calls while testing
String testGeoJson = '{"routes":[{"weight_name":"auto","weight":0.003,"duration":0,"distance":0,"legs":[{"via_waypoints":[],"admins":[{"iso_3166_1_alpha3":"USA","iso_3166_1":"US"}],"weight":0.003,"duration":0,"steps":[{"intersections":[{"bearings":[0],"entry":[true],"mapbox_streets_v8":{"class":"service"},"is_urban":true,"admin_index":0,"out":0,"geometry_index":0,"location":[-122.08372,37.421304]}],"maneuver":{"type":"depart","instruction":"Drive north.","bearing_after":0,"bearing_before":0,"location":[-122.08372,37.421304]},"name":"","duration":0,"distance":0,"driving_side":"right","weight":0.003,"mode":"driving","geometry":{"coordinates":[[-122.08372,37.421304],[-122.08372,37.421304]],"type":"LineString"}},{"intersections":[{"bearings":[180],"entry":[true],"in":0,"admin_index":0,"geometry_index":1,"location":[-122.08372,37.421304]}],"maneuver":{"type":"arrive","instruction":"You have arrived at your destination.","bearing_after":0,"bearing_before":0,"location":[-122.08372,37.421304]},"name":"","duration":0,"distance":0,"driving_side":"right","weight":0,"mode":"driving","geometry":{"coordinates":[[-122.08372,37.421304],[-122.08372,37.421304]],"type":"LineString"}}],"distance":0,"summary":""}],"geometry":{"coordinates":[[-122.08372,37.421304],[-122.08372,37.421304]],"type":"LineString"}}],"waypoints":[{"distance":81.157,"name":"","location":[-122.08372,37.421304]},{"distance":81.157,"name":"","location":[-122.08372,37.421304]}],"code":"Ok","uuid":"eJbMr_hPq7wwrcl7IDz4L2vLTi0txwq6u_eRBxjlyy-hsQIpMoYSvQ=="}';



class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidget();
}

class _MapWidget extends State<MapWidget> with TickerProviderStateMixin  {
  bool loadingData = false;
  bool locationSelected = false;
  late LatLng currentLocation;
  late LatLng selectedLocation;
  late MapController mapController;
  Polyline? customPolyline;
  final pageController = PageController();

  GeoJsonParser geoJsonParser = GeoJsonParser(
    defaultMarkerColor: Colors.red,
    defaultPolygonBorderColor: Colors.red,
    defaultPolygonFillColor: Colors.red.withOpacity(0.1),
    defaultCircleMarkerColor: Colors.red.withOpacity(0.15),
  );

  Future<void> getCurrentLocation() async {
    currentLocation = await Locator.getCurrentLocation();
    selectedLocation = currentLocation;
  }


  void addPolylines(String body) {
    final parsed = (jsonDecode(body) as Map<String, dynamic>);
    List<Polyline> polylines = [];

    parsed['routes'].forEach((route) {
      List<LatLng> points = [];
      route['geometry']['coordinates'].forEach((coord) {
        points.add(LatLng(coord[1], coord[0])); // MapBox api sends longiture before latitude
      });

      polylines.add(
        Polyline(
          points: points,
          color: Colors.blue,
          strokeWidth: 4.0
        )
      );
    });

    setState(() {
      polylineWidget = PolylineLayer(
        polylines: polylines,
      );
    });
  }

  Future<void> getDirections() async {
    // Uncomment for test http response
    // getPolylines(testGeoJson);
    // return;

    double startLat = currentLocation.latitude;
    double startLng = currentLocation.longitude;
    double endLat = selectedLocation.latitude;
    double endLng = selectedLocation.longitude;

    String url = 'https://api.mapbox.com/directions/v5/mapbox/walking/${startLng}%2C${startLat}%3B${endLng}%2C${endLat}?alternatives=true&geometries=geojson&language=en&overview=full&steps=true&access_token=pk.eyJ1IjoibHVjYXNzcm9jaGExIiwiYSI6ImNscDJ6bmsyazBzOHkycXMxYTYzNnJrZGMifQ.XWyJTUcjWPmcjx-NUPn_3w';

    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      addPolylines(response.body);
    } else {
      return Future.error("Maps server unreachable ${response.body}");
    }
  }

  Widget polylineWidget = SizedBox();

  @override
  void initState() {
    super.initState();
    loadingData = true;
    getCurrentLocation().then((_) {
      setState(() {
        loadingData = false;
      });
    });
    mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    return loadingData ? const CircularProgressIndicator()
      : Center(
        child: Stack(
          children: [
            FlutterMap(
              mapController: mapController,
              options: MapOptions(
                onTap: (tapPosition, point) {
                  _mapTap(point);
                },
                initialCenter: currentLocation,
                initialZoom: 15,
                minZoom: 10,
                maxZoom: 17,
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
                polylineWidget,
                MarkerLayer(
                  markers: [
                    Marker(
                      width: 34.0,
                      height: 34.0,
                      point: currentLocation,
                      child: Icon(Icons.person_pin),
                    ),
                    if (locationSelected) Marker(
                      width: 30.0,
                      height: 30.0,
                      point: selectedLocation,
                      child: Icon(Icons.location_on)
                    )
                  ]
                )
              ],
            ),
          ],
        ),
      );
  }

  void _mapTap(LatLng point) async {
    getDirections().then((_) {
      setState(() {
        locationSelected = true;
        selectedLocation = point;
        getDirections();
      });
    });
  }
}