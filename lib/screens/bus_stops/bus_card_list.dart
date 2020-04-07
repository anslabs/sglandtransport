import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart' as http;
import 'package:lta_datamall_flutter/api.dart';
import 'package:lta_datamall_flutter/models/bus_stops/bus_stop_model.dart';
import 'package:lta_datamall_flutter/screens/bus_arrivals.dart';

class BusCardList extends StatefulWidget {
  @override
  _BusCardListState createState() => _BusCardListState();
}

class _BusCardListState extends State<BusCardList> {
  Future<List<BusStopModel>> _future;

  @override
  void initState() {
    super.initState();
    _future = fetchBusStopList(http.IOClient());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FutureBuilder<List<BusStopModel>>(
        future: _future,
        builder:
            (BuildContext context, AsyncSnapshot<List<BusStopModel>> snapshot) {
          if (snapshot.hasData) {
            final List<BusStopModel> busStops = snapshot.data;
            return ListView.builder(
              itemCount: busStops.length,
              itemBuilder: (BuildContext context, int index) {
                return OpenContainer(
                  transitionType: ContainerTransitionType.fade,
                  openBuilder: (BuildContext _, VoidCallback openContainer) {
                    return BusArrivals(
                      busStopCode: busStops[index].busStopCode,
                      description: busStops[index].description,
                      roadName: busStops[index].roadName,
                    );
                  },
                  tappable: false,
                  closedShape: const RoundedRectangleBorder(),
                  closedElevation: 0.0,
                  openColor: Theme.of(context).scaffoldBackgroundColor,
                  closedColor: Theme.of(context).scaffoldBackgroundColor,
                  closedBuilder:
                      (BuildContext context, VoidCallback openContainer) {
                    return Card(
                      margin: const EdgeInsets.all(6),
                      child: ListTile(
                        leading: Icon(Icons.departure_board),
                        onTap: openContainer,
                        title: Text(
                            '${busStops[index].busStopCode} (${busStops[index].description})'),
                        subtitle: Text(busStops[index].roadName),
                        trailing: Icon(Icons.assignment),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {}
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}