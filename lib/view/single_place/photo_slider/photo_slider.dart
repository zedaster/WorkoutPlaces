import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoSlider extends StatefulWidget {
  final List<ImageProvider> images;
  final double? height;
  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  const PhotoSlider(
      {Key? key, required this.images, this.height, this.onPageChanged})
      : super(key: key);

  PhotoSlider copyWith({
    List<ImageProvider>? images,
    double? height,
    Function(int index, CarouselPageChangedReason reason)? onPageChanged,
  }) {
    return PhotoSlider(
      images: images ?? this.images,
      height: height ?? this.height,
      onPageChanged: onPageChanged ?? this.onPageChanged,
    );
  }

  @override
  _PhotoSliderState createState() => _PhotoSliderState();
}

class _PhotoSliderState extends State<PhotoSlider> {
  @override
  Widget build(BuildContext context) {
    final images = widget.images;
    return CarouselSlider.builder(
      itemCount: images.length,
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return GestureDetector(
          onTap: () => open(context, index),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Image(
              image: images[index],
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        viewportFraction: 1,
        height: widget.height,
        onPageChanged: widget.onPageChanged,
      ),
    );
  }

  void open(BuildContext context, final int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotoSliderViewWrapper(
          images: widget.images,
          backgroundDecoration: const BoxDecoration(
            color: Colors.black,
          ),
          initialIndex: index,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}

class PhotoSliderViewWrapper extends StatefulWidget {
  PhotoSliderViewWrapper({
    Key? key,
    this.loadingBuilder,
    this.backgroundDecoration,
    this.minScale,
    this.maxScale,
    this.initialIndex = 0,
    required this.images,
    this.scrollDirection = Axis.horizontal,
  })  : pageController = PageController(initialPage: initialIndex),
        super(key: key);

  final LoadingBuilder? loadingBuilder;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;
  final int initialIndex;
  final PageController pageController;
  final List<ImageProvider> images;
  final Axis scrollDirection;

  @override
  State<StatefulWidget> createState() {
    return _PhotoSliderViewWrapperState();
  }
}

class _PhotoSliderViewWrapperState extends State<PhotoSliderViewWrapper> {
  late int currentIndex = widget.initialIndex;

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.backgroundDecoration,
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: _buildItem,
          itemCount: widget.images.length,
          loadingBuilder: widget.loadingBuilder,
          backgroundDecoration: widget.backgroundDecoration,
          pageController: widget.pageController,
          onPageChanged: onPageChanged,
          scrollDirection: widget.scrollDirection,
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final image = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: image,
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 4.1,
    );
  }
}
