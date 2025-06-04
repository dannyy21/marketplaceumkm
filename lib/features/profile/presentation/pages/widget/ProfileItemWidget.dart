import 'package:flutter/material.dart';

class ProfileItemWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final IconData icon;

  const ProfileItemWidget({
    Key? key,
    required this.text,
    required this.onTap,
    this.icon = Icons.person,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 36,
            width: 36,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon),
          ),
          SizedBox(width: 16),
          Text(text),
        ],
      ),
    );
  }
}
