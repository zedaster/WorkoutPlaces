import 'package:flutter/material.dart';

class SinglePlaceScreen extends StatelessWidget {
  final int placeId;

  const SinglePlaceScreen({
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
