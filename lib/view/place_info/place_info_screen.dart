import 'package:flutter/material.dart';

class PlaceInfoScreen extends StatelessWidget {
  final int placeId;

  const PlaceInfoScreen({
    Key? key,
    required this.placeId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Place Info Screen'),
      ),
    );
  }
}
