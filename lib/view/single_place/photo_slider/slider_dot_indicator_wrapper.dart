import 'package:flutter/material.dart';
import 'package:workout_places_app/view/single_place/photo_slider/photo_slider.dart';

class SliderDotIndicatorWrapper extends StatefulWidget {
  final PhotoSlider slider;

  const SliderDotIndicatorWrapper({
    required this.slider,
    Key? key,
  }) : super(key: key);

  @override
  _SliderDotIndicatorWrapperState createState() =>
      _SliderDotIndicatorWrapperState();
}

class _SliderDotIndicatorWrapperState extends State<SliderDotIndicatorWrapper> {
  late final PhotoSlider _stateSlider;
  int _currentIndex = 0;

  @override
  void initState() {
    _stateSlider = widget.slider.copyWith(onPageChanged: (i, reason) {
      setState(() {
        _currentIndex = i;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        _stateSlider,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: Iterable<int>.generate(_stateSlider.images.length).map((index) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index
                      ? Colors.white
                      : const Color(0xFFC4C4C4)),
            );
          }).toList(),
        ),
      ],
    );
  }
}
