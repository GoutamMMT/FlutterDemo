import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';

class WebPImageLoader extends StatelessWidget {
  final String assetPath;
  const WebPImageLoader({required this.assetPath});

  Future<Image> _loadWebPImage() async {
    // Load the image data from the asset
    ByteData data = await rootBundle.load(assetPath);
    Uint8List bytes = data.buffer.asUint8List();
    // Decode the WebP image using the `image` package
    img.Image? webpImage = img.decodeWebP(bytes);
    if (webpImage == null) {
      throw Exception('Failed to decode WebP image');
    }
    // Convert the decoded image to a Flutter Image widget
    return Image.memory(
      Uint8List.fromList(img.encodePng(webpImage)),
      width: 450,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Image>(
      future: _loadWebPImage(),
      builder: (BuildContext context, AsyncSnapshot<Image> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return snapshot.data!;
        }
      },
    );
  }
}
