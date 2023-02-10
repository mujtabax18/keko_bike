import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:keko_bike/constants/app_constants.dart';
import 'package:keko_bike/models/map_marker_model.dart';
import 'package:keko_bike/pages/searchpage.dart';
import 'package:keko_bike/utili/widgets/CatagoriesDropDown.dart';
import 'package:keko_bike/utili/widgets/CustomBottomNavigationBar.dart';
import 'package:keko_bike/models/map_tracks_model.dart';
// import 'package:keko_bike/models/get_current_location.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final pageController = PageController();
  int selectedIndex = -1;
  var currentLocation = AppConstants.myLocation;
  int _selectedCatory = -1;
  int _navSelectedIndex = 0;
  late MapController mapController;

  @override
  void initState() {
    mapController = MapController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CatagoriesDropDown(
            iconList: const [
              'assets/icons/location.png',
              'assets/icons/Beach.png',
              'assets/icons/camera.png',
              'assets/icons/Hiking.png',
              'assets/icons/food.png',
              'assets/icons/shopping.png',
              'assets/icons/restroom.png',
              'assets/icons/warning.png',
            ],
            onSelected: (a) {
              _selectedCatory = a;
              setState(() {});
            }),
        backgroundColor: Colors.white,
        title: Center(
          child: SizedBox(
            height: 80,
            child: Image.asset('assets/logo/logo.png'),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: _navSelectedIndex,
        onTap: (a) {
          _navSelectedIndex = a;
          if (_navSelectedIndex == 2) {
            Navigator.pushNamed(context, SearchPage.id);
          }
        },
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 11,
                center: currentLocation,
                onTap: (a, b) {
                  selectedIndex = -1;
                  setState(() {});
                }),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://api.mapbox.com/styles/v1/hostilli/{mapStyleId}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}",
                additionalOptions: {
                  'mapStyleId': AppConstants.mapBoxStyleId,
                  'accessToken': AppConstants.mapBoxAccessToken,
                },
              ),
              PolylineLayerOptions(
                polylineCulling: false,
                polylines: [
                  Polyline(
                    points: mapTracks[0].trackPoint,
                    strokeWidth: 5,
                    color: Colors.blue,
                  ),
                ],
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < mapMarkers.length; i++)
                    Marker(
                      height: 40,
                      width: 40,
                      point: mapMarkers[i].location ?? AppConstants.myLocation,
                      builder: (_) {
                        return GestureDetector(
                          onTap: () {
                            pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                            selectedIndex = i;
                            currentLocation = mapMarkers[i].location ??
                                AppConstants.myLocation;
                            _animatedMapMove(currentLocation, 11.5);
                            setState(() {});
                          },
                          child: AnimatedScale(
                            duration: const Duration(milliseconds: 500),
                            scale: selectedIndex == i ? 1 : 0.7,
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: selectedIndex == i ? 1 : 0.5,
                              child: ImageIcon(
                                const AssetImage(
                                  'assets/icons/location.png',
                                ),
                                color: mapMarkers[i].type == 'track_starting'
                                    ? Colors.green
                                    : mapMarkers[i].type == 'track_ending'
                                        ? Colors.black
                                        : Colors.red,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 2,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (value) {
                selectedIndex = value;
                currentLocation =
                    mapMarkers[value].location ?? AppConstants.myLocation;
                _animatedMapMove(currentLocation, 11.5);
                setState(() {});
              },
              itemCount: mapMarkers.length,
              itemBuilder: (_, index) {
                final item = mapMarkers[index];
                return Visibility(
                  visible: selectedIndex >= 0,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: item.rating,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.orange,
                                      );
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title ?? '',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        item.address ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.asset(
                                  item.image ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: Card(
              elevation: 2,
              child: Container(
                color: Color(0xFFFAFAFA),
                width: 40,
                height: 100,
                child: Column(
                  children: <Widget>[
                    IconButton(icon: Icon(Icons.add), onPressed: () async {}),
                    SizedBox(height: 2),
                    IconButton(icon: Icon(Icons.remove), onPressed: () async {})
                  ],
                ),
              ),
            ),
          ),
          //  Positioned(
          //   top: 110,
          //   right: 5,
          //   child: Card(
          //     elevation: 2,
          //     child: Container(
          //       color: Color(0xFFFAFAFA),
          //       width: 40,
          //       height: 50,
          //       child: IconButton(
          //           icon: Icon(Icons.my_location),
          //           onPressed: () async {
          //             Position temp = await determinePosition();
          //             currentLocation = LatLng(temp.latitude, temp.longitude);
          //             _animatedMapMove(currentLocation, 11.5);
          //             setState(() {});
          //           }),
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.

    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);
    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
