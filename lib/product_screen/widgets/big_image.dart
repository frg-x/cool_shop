import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BigImage extends StatefulWidget {
  BigImage({required this.url, required this.uniqueId});

  final String url;
  final String uniqueId;

  @override
  _BigImageState createState() => _BigImageState();
}

class _BigImageState extends State<BigImage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: GestureDetector(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
              tag: widget.uniqueId,
              child: ExtendedImage.network(
                widget.url,
                fit: BoxFit.fitWidth,
                cache: true,
                mode: ExtendedImageMode.gesture,
                //cancelToken: cancellationToken,
                initGestureConfigHandler: (state) {
                  return GestureConfig(
                    minScale: 0.9,
                    animationMinScale: 0.7,
                    maxScale: 3.0,
                    animationMaxScale: 3.5,
                    speed: 1.0,
                    inertialSpeed: 100.0,
                    initialScale: 1.0,
                    inPageView: false,
                    initialAlignment: InitialAlignment.center,
                  );
                },
              ),
              transitionOnUserGestures: true,
            ),
          ),
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
