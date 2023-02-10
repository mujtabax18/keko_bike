import 'package:latlong2/latlong.dart';

class MapMarker {
  final String image;
  final String title;
  final String address;
  final LatLng location;
  final int rating;
  final String type;

  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
    required this.rating,
    required this.type,
  });
}

final mapMarkers = [
  MapMarker(
      image: 'assets/images/restaurant_1.jpg',
      type: 'shopping',
      title: 'Cheap tours Hawaii',
      address: '8 Plender St, London NW1 0JT, United Kingdom',
      location: LatLng(21.981753375201695, -159.3467807033223),
      rating: 4),
  MapMarker(
      image: 'assets/images/restaurant_2.jpg',
      title: 'The Ocean Course at Hokuala',
      type: 'shopping',
      address: '103 Hampstead Rd, London NW1 3EL, United Kingdom',
      location: LatLng(21.963950170410296, -159.34638545651694),
      rating: 5),
  MapMarker(
      image: 'assets/images/restaurant_3.jpg',
      title: 'Naito Bay',
      type: 'shopping',
      address: '122 Palace Gardens Terrace, London W8 4RT, United Kingdom',
      location: LatLng(21.969605547928516, -159.3309708311082),
      rating: 2),
  MapMarker(
      image: 'assets/images/restaurant_4.jpg',
      title: 'Puakea Golf Course',
      type: 'shopping',
      address: '2 More London Riverside, London SE1 2AP, United Kingdom',
      location: LatLng(21.96594005113646, -159.37461737118497),
      rating: 3),
];
