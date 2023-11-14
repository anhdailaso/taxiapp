import 'package:flutter/material.dart';
import 'package:flutter_taxiapp/model/place_item_res.dart';
import 'package:flutter_taxiapp/src/widgets/home_menu.dart';
import 'package:flutter_taxiapp/src/widgets/ride_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _sacfolkey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _sacfolkey,
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        child: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(10.793837, 106.734863),
                tilt: 0,
                zoom: 11,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  title: Center(
                    child: Text(
                      "Taxi App",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  leading: TextButton(
                      onPressed: () => {
                            _sacfolkey.currentState?.openDrawer(),
                          },
                      child: Image.asset("assets/ic_menu.png")),
                  actions: <Widget>[Image.asset("assets/ic_notify.png")],
                ),
              ],
            ),
            Positioned(
              left: 20,
              right: 20,
              top: 100,
              child: RidePicker(onPlaceSelected),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: HomeMeu(),
      ),
    );
  }

  void onPlaceSelected(PlaceItemRes place, bool fromAddress) {
    var mkId = fromAddress ? "from_address" : "to_address";
  }
}
