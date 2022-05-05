import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'places_mode.dart';

class PlacesChangeModeButton extends StatelessWidget {
  final PlacesMode modeToChange;

  const PlacesChangeModeButton({Key? key, required this.modeToChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          color: Colors.black,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 2,
                offset: const Offset(0, 2))
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _iconWidget,
            const SizedBox(width: 10),
            Text(_title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16))
          ],
        ));
  }

  String get _title {
    switch (modeToChange) {
      case PlacesMode.MAP:
        return "КАРТА";
      case PlacesMode.LIST:
        return "СПИСОК";
    }
  }

  Widget get _iconWidget {
    switch (modeToChange) {
      case PlacesMode.MAP:
        return const Icon(Icons.map, color: Colors.white);
      case PlacesMode.LIST:
        return const Icon(Icons.list, color: Colors.white);
    }
  }
}
