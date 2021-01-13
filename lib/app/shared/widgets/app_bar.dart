import 'package:flutter/material.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final String imagePath;

  const AppBarCustom(
      {Key key, this.height = 150.0, this.imagePath = 'assets/loja.jpg'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.shade400,
      height: height,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
                Text(
                  'Minha Loja'.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
                IconButton(
                    icon: Icon(
                      Icons.edit_road,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Transform.translate(
              offset: Offset(0.0, height / 2 - 80 / 2),
              child: CircleAvatar(
                radius: 80,
                backgroundImage: AssetImage(
                  imagePath,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
