import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:marketplace_umkm/features/home/presentation/widgets/map_full_screen_page.dart';

import '../../../../core/utils/get_location.dart';

class SellerLocation {
  final String id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  SellerLocation({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });
}

class NearbySection extends StatefulWidget {
  final List<SellerLocation> sellers;
  const NearbySection({super.key, required this.sellers});

  @override
  State<NearbySection> createState() => _NearbySectionState();
}

class _NearbySectionState extends State<NearbySection> {
  LatLng? userLocation;
  StreamSubscription<Position>? positionStream;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
    _listenToLocationUpdates();
  }

  Future<void> _getUserLocation() async {
    final location = await getCurrentLocation();
    setState(() {
      userLocation = location;
    });
  }

  void _listenToLocationUpdates() {
    const LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    positionStream = Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen((Position position) {
      setState(() {
        userLocation = LatLng(position.latitude, position.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userLocation == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final LatLng center = userLocation ?? LatLng(-6.212340, 106.12566);

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Nearby UMKM",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12),
          SizedBox(
            height: 250,
            width: double.infinity,
            child: FlutterMap(
              options: MapOptions(
                initialCenter: center,
                initialZoom: 16.5,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.drag | InteractiveFlag.pinchZoom,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate:
                      "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: const ['a', 'b', 'c'],
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: userLocation!,
                      width: 40,
                      height: 40,
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 40,
                      ),
                    ),
                    ...widget.sellers.map((seller) {
                      return Marker(
                        point: LatLng(seller.latitude, seller.longitude),
                        width: 40,
                        height: 40,
                        child: const Icon(
                          Icons.location_on,
                          color: Colors.red,
                          size: 36,
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          ElevatedButton.icon(
            icon: const Icon(Icons.map),
            label: const Text('Lihat Peta Lengkap'),
            onPressed: () {
              context.push('/map_full_screen_page', extra: widget.sellers);
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }
}
