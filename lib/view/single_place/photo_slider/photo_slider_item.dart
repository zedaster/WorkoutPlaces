import 'package:flutter/widgets.dart';

// class GalleryExampleItem {
//   GalleryExampleItem({
//     required this.id,
//     required this.resource,
//     this.isSvg = false,
//   });
//
//   final String id;
//   final String resource;
//   final bool isSvg;
// }

class PhotoSliderItem extends StatelessWidget {
  final ImageProvider image;
  final GestureTapCallback onTap;

  const PhotoSliderItem({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Image(image: image, height: 80.0),
      ),
    );
  }
}
