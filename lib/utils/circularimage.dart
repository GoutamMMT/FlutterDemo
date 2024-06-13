import 'package:flutter/material.dart';

class CircularCachedNetwork extends StatelessWidget {
  final String url;
  final double size;
  const CircularCachedNetwork({required this.url, this.size = 80.0});

  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.black,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(80),
      child: FadeInImage(
        placeholder: const AssetImage('assets/images/profile_sample.png'),
        image: NetworkImage(url),
        fit: BoxFit.fill,
      ),
    );
  }
}
