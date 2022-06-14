import 'package:flutter/material.dart';
import 'package:workout_places_app/view/navigator_screen.dart';

class ProfileScreen extends StatelessWidget implements NavigatorScreen {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  String get appBarTitle => "Профиль";

  @override
  Widget get asWidget => this;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Profile and Settings Page"));
  }
}
