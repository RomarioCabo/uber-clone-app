import 'package:flutter/material.dart';

import '../../../domain/argument/method_arguments.dart';
import '../../../domain/argument/who_called.dart';
import '../../../domain/taxi_shipping/taxi_shipping_model.dart';

class ItemTileRoute extends StatefulWidget {
  final TaxiShippingModel? route;

  const ItemTileRoute({
    Key? key,
    this.route,
  }) : super(key: key);

  @override
  State<ItemTileRoute> createState() => _ItemTileRouteState();
}

class _ItemTileRouteState extends State<ItemTileRoute> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/fragment-main",
          arguments: MethodArguments(
            title: "Motorista",
            whoCalled: WhoCalled.panelDriver,
            clazz: widget.route,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.route!.passenger!.name!} ${widget.route!.passenger!.lastName!}",
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          Container(height: 4.0),
          Text(
            "${widget.route!.destination!.street!}, ${widget.route!.destination!.number!}",
            style: const TextStyle(
              color: Colors.black38,
              fontSize: 11.0,
            ),
          ),
          //const Divider(),
        ],
      ),
    );
  }
}
