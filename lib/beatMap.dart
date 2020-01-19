import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'song.dart';
import 'songSearch.dart';
import 'package:geolocator/geolocator.dart';
import 'globals.dart' as globals;

class BeatMapPage extends StatefulWidget {
  @override
  BeatMapState createState() => BeatMapState();
}

class BeatMapState extends State<BeatMapPage> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController pinMessageController = new TextEditingController();

  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference();

  //Google map icon
  BitmapDescriptor beatIcon;

  double zoomVal = 18.0;
  double SCREEN_HEIGHT, SCREEN_WIDTH;
  ScreenCoordinate SCREEN_CENTER;

  // Geolocation
  Geolocator geolocator = Geolocator();
  double defaultLatVal = 1.306180;
  double defaultLongVal = 103.773737;
  Position defaultPosition = Position(latitude: 1.306180, longitude: 103.773737);

  //Markers
  Map<String, Marker> markers =
      <String, Marker>{}; // map to markerId and marker

  @override
  void initState() {
    BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(64,64)), 'assets/beat_icon.png')
      .then((onValue) {
        beatIcon = onValue;
      });
    super.initState(); // polling step to initialize markers
    refresh();
  }

  ///
  /// BUILD METHOD
  ///
  @override
  Widget build(BuildContext context) {
    SCREEN_HEIGHT = MediaQuery.of(context).size.height;
    SCREEN_WIDTH = MediaQuery.of(context).size.width;
    SCREEN_CENTER = ScreenCoordinate(
      x: (0.5 * SCREEN_WIDTH).round(),
      y: (0.5 * SCREEN_HEIGHT).round(),
    );

    return Scaffold(
      // Appbar
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        brightness: Brightness.light,
        centerTitle: true,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "BeatMap",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 4,
              ),
            ),
            Text(
              "Drop a beat or check out what others' dropped!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
      // Body of main window
      body: Stack(
        children: <Widget>[
          _googlemap(context),
          _zoomfunctions(),
          _refreshbutton(),
          _dropBeatButton(),
        ],
      ),
    );
  }

  ///
  /// Map Widget
  ///
  Widget _googlemap(BuildContext context) {
    return Container(
        height: SCREEN_HEIGHT,
        width: SCREEN_WIDTH,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition:
              CameraPosition(target: LatLng(defaultLatVal, defaultLongVal), zoom: zoomVal),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(markers.values),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
        ));
  }

  ///
  /// DATABASE QUERYING, MARKER ADDITION
  ///
  ///

  void _getCurrentPosition(String message, String name,
      String imageUrl, String artists) async{
    Position currentPosition = new Position(
            longitude: defaultLongVal,
            latitude: defaultLatVal
    );
    currentPosition = await geolocator
    .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
    .timeout(Duration(seconds: 5), onTimeout:() {
      final geolocatorObj = new Geolocator();
      geolocatorObj.forceAndroidLocationManager = true;
      return geolocatorObj.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    });
    
    setState(() {
      writeData(message, name, imageUrl, artists, currentPosition);
    });
  }


  void writeData(String message, String name,
      String imageUrl, String artists, Position currentPosition) {

    databaseReference.child("users").push().set({
      'name': name,
      'imageUrl': imageUrl,
      'artists': artists,
      'message': message,
      'latVal': currentPosition.latitude,
      'lngVal': currentPosition.longitude,
      'username': globals.username
    });

    refresh();
  }

  // Refresh() fetches the marker data from the DB
  void refresh() async {
    DatabaseReference db = databaseReference.child("users");
    await db.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> values = snapshot.value;

      /// hacky we're sorry
      values.forEach((key, values) {
        _addMarker(
            key.toString(),
            values["message"].toString(),
            double.parse(values["latVal"].toString()),
            double.parse(values["lngVal"].toString()),
            values["name"].toString(),
            values["imageUrl"].toString(),
            values["artists"].toString(),
            values["username"].toString());
      });
    });

    // Refreshes model
    setState(() {
      Fluttertoast.showToast(
          msg: "Page Refreshing...",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Color.fromRGBO(169, 169, 169, 0.7),
          textColor: Colors.black,
          fontSize: 12);
    });
  }

  // Takes in parsed marker data to create a new marker
  void _addMarker(
      String markerId,
      String message,
      double positionLat,
      double positionLng,
      String name,
      String imageUrl,
      String artists,
      String username) {
    Marker newMarker = Marker(
      markerId: MarkerId(markerId),
      position: LatLng(positionLat, positionLng),
      infoWindow: InfoWindow(
          title: name,
          snippet: artists,
          onTap: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.black87,
                    contentPadding:
                        const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 12.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Beat Info:",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700)),
                              IconButton(
                                  icon: Icon(Icons.close, color: Colors.white),
                                  padding: const EdgeInsets.all(4.0),
                                  onPressed: () {
                                    Navigator.of(context, rootNavigator: true)
                                        .pop();
                                  })
                            ]),
                        Padding(
                            padding: const EdgeInsets.fromLTRB(10, 2, 2, 8),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Message: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500)),
                                Text(message,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w200)),
                                Container(height: 10, width: 20),
                                Text("Dropped by: " + username,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300)),
                              ],
                            )
                        ),
                      ],
                    ),
                  );
                });
          }),
      icon: beatIcon,
      onTap: () {
        _gotoLocation(positionLat, positionLng);
      },
    );

    // Add new marker to marker map
    markers[markerId] = newMarker;
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: zoomVal,
    )));
  }

  ///
  /// ZOOM IN AND OUT WIDGETS
  ///
  Widget _zoomfunctions() {
    return Align(
        alignment: Alignment.topRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _zoomplusfunction(),
            _zoominusfunction(),
          ],
        ));
  }

  Widget _zoominusfunction() {
    return IconButton(
      icon: Icon(FontAwesomeIcons.searchMinus, color: Colors.black),
      onPressed: () {
        zoomVal -= 0.45;
        _updateZoom(zoomVal);
      },
    );
  }

  Widget _zoomplusfunction() {
    return IconButton(
      icon: Icon(FontAwesomeIcons.searchPlus, color: Colors.black),
      onPressed: () {
        zoomVal += 0.45;
        _updateZoom(zoomVal);
      },
    );
  }

  Future<void> _updateZoom(double zoomVal) async {
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: await controller.getLatLng(SCREEN_CENTER),
      // warning: HACKY ZOOM
      // await controller.getLatLng(ScreenCoordinate(
      //   x: (context.size.width*1.8).round(),
      //   y: (context.size.height*1.5).round(),
      // )),
      zoom: zoomVal,
    )));
  }

  ///
  /// ZOOM IN AND OUT WIDGETS
  ///
  Widget _refreshbutton() {
    return IconButton(
      icon: Icon(FontAwesomeIcons.sync, color: Colors.black),
      onPressed: () {
        refresh();
      },
    );
  }

  ///
  /// DROP THE BEAT Button (#cantstopwontstop)
  ///
  Widget _dropBeatButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FloatingActionButton.extended(
          elevation: 6.0,
          icon: const Icon(Icons.add),
          foregroundColor: Colors.black,
          label: const Text(
            'Drop a Beat!',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: Color.fromRGBO(30, 215, 97, 1.0),
          onPressed: () {
            _initiateSearch();
          },
        ),
      ),
    );
  }

  void _initiateSearch() {
    showSearch(context: context, delegate: CustomSearchDelegate()).then((res) {
      if (res != null) {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return _createPin(res);
            });
      }
    });
  }

  // Create a pin window
  Widget _createPin(Song song) {
    return AlertDialog(
      backgroundColor: Colors.black87,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.music,
            size: 18,
            color: Color.fromRGBO(30, 215, 97, 1.0),
          ),
          //Spacer
          Container(
            height: 10,
            width: 10,
          ),
          Text(
            'Drop a Beat!',
            style: new TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.white,
            ),
          ),
        ],
      ),
      content: Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //
            // SONG FIELD
            //
            song.returnSongWidget(),
            //
            // MESSAGE FIELD
            //
            new TextField(
              controller: pinMessageController,
              maxLength: 100,
              style: new TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
              decoration: new InputDecoration(
                counterStyle: TextStyle(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w200,
                ),
                border: InputBorder.none,
                filled: false,
                contentPadding: new EdgeInsets.only(
                    left: 10.0, top: 10.0, bottom: 10.0, right: 10.0),
                hintText: "Type a message (Optional)",
                hintStyle: new TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                ),
              ),
            ),
            //
            // Drop the Beat Button
            //
            RaisedButton(
              color: Color.fromRGBO(30, 215, 97, 1.0),
              textColor: Colors.black,
              elevation: 2.0,
              highlightElevation: 8.0,
              onPressed: () {
                _getCurrentPosition(pinMessageController.text,
                    song.name, song.imageUrl, song.parseArtists());
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: new Text("Drop the Beat!",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
