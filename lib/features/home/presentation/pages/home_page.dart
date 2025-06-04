import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../products/presentation/bloc/product_bloc.dart';
import '../../../products/presentation/bloc/product_event.dart';
import '../../../products/presentation/pages/product_section_widget.dart';
import '../../../../core/utils/injection.dart';
import '../widgets/nearby_section.dart'; // pastikan path ini benar

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Column(
              children: [
                NearbySection(
                  sellers: [
                    SellerLocation(
                      id: '1',
                      name: 'UMKM A',
                      description: 'Jualan makanan',
                      latitude: -6.2,
                      longitude: 106.8,
                    ),
                    SellerLocation(
                      id: '2',
                      name: 'UMKM B',
                      description: 'Jualan kerajinan',
                      latitude: -6.21,
                      longitude: 106.81,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "UMKM Terdekat",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                ProductSectionWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
