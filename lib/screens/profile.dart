import 'package:flutter/material.dart';
import 'package:myapp/items.dart' as it;
import 'package:myapp/widgets.dart' as wd;

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: wd.customAppbar(context),
      bottomNavigationBar: wd.customBottomNavigation(context),
      body: Container(),
    );
  }
}
