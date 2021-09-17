import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BigImage extends StatefulWidget {
  const BigImage({
    Key? key,
    required this.imageUrl,
    required this.heroTag,
  }) : super(key: key);

  final String imageUrl;
  final String heroTag;

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
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Hero(
              tag: widget.heroTag,
              child: ExtendedImage.network(
                widget.imageUrl,
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
