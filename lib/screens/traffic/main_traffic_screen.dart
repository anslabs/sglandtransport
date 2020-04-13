import 'package:flutter/material.dart';
import 'package:lta_datamall_flutter/screens/widgets/app_drawer.dart';

class MainTrafficScreen extends StatelessWidget {
  static const String id = 'main_traffic_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Traffic'),
      ),
      drawer: AppDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.traffic,
              size: 70,
            ),
            const Text('Coming soon!'),
          ],
        ),
      ),
    );
  }
}
