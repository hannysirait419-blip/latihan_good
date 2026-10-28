import 'package:flutter/material.dart';

/// Image.asset dengan kotak abu-abu bila file gambar belum ada.
class AppImage extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AppImage(this.path,
      {super.key, this.width, this.height, this.fit = BoxFit.cover});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, __, ___) => Container(
        width: width,
        height: height,
        color: Colors.grey.shade300,
        alignment: Alignment.center,
        child: Icon(Icons.image_outlined, color: Colors.grey.shade600),
      ),
    );
  }
}
