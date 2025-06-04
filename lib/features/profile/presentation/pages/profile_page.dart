import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_umkm/features/profile/presentation/pages/widget/ProfileItemWidget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 42),
              Center(
                child: ClipOval(
                  child: Image.network(
                    'https://i.pinimg.com/736x/06/5e/48/065e487cba8a1c1dc1e3ab2cdb16ec9b.jpg',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 12),
              Center(
                child: Column(
                  children: [
                    Text(
                      "Astra Yao",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text("Pembeli", style: TextStyle(fontSize: 16)),
                  ],
                ),
              ),
              SizedBox(height: 42),
              Text(
                "Informasi Personal",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              ProfileItemWidget(text: "Edit Informasi Personal", onTap: () {}),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Riwayat Transaksi",
                icon: Icons.history,
                onTap: () {},
              ),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Favorite",
                icon: Icons.favorite,
                onTap: () {},
              ),
              SizedBox(height: 16),
              Text(
                "Lainnya",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Bahasa",
                icon: Icons.language,
                onTap: () {},
              ),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Biometrik",
                icon: Icons.security,
                onTap: () {},
              ),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Masukan",
                icon: Icons.feedback,
                onTap: () {},
              ),
              SizedBox(height: 16),
              ProfileItemWidget(
                text: "Keluar",
                icon: Icons.logout,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
