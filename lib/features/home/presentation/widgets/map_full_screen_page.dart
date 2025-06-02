import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../core/utils/appbar_widget.dart';
import 'nearby_section.dart';

class MapFullScreenPage extends StatefulWidget {
  final List<SellerLocation> sellerLocations;
  const MapFullScreenPage({super.key, required this.sellerLocations});

  @override
  State<MapFullScreenPage> createState() => _MapFullScreenPageState();
}

class _MapFullScreenPageState extends State<MapFullScreenPage> {
  late final MapController _mapController;
  late final LatLng _center;
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _center =
        widget.sellerLocations.isNotEmpty
            ? LatLng(
              widget.sellerLocations[0].latitude,
              widget.sellerLocations[0].longitude,
            )
            : LatLng(-6.200000, 106.816666); // default Jakarta
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: "Peta UMKM Sekitar",
        onPressed: () {
          GoRouter.of(context).pop();
        },
      ),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: _center,
          initialZoom: 14,
          onTap: (_, __) {},
        ),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers:
                widget.sellerLocations.map((seller) {
                  return Marker(
                    point: LatLng(seller.latitude, seller.longitude),
                    width: 50,
                    height: 50,
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder:
                              (_) => Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Text(
                                  '${seller.name}\n${seller.description}',
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ),
                        );
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}
