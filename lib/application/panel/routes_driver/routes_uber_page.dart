import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/store/routes_driver/route_uber_controller_impl.dart';
import '../../../infrastructure/helpers/request_state.dart';
import '../../item_tile/route/item_tile_route.dart';

class RoutesUberPage extends StatefulWidget {
  const RoutesUberPage({Key? key}) : super(key: key);

  @override
  State<RoutesUberPage> createState() => _RoutesUberPageState();
}

class _RoutesUberPageState extends State<RoutesUberPage> {
  late RouteUberControllerImpl _controller;

  List<String> itemsMenu = ["Configurações", "Deslogar"];

  _choiceMenuItem(String choice) {
    switch (choice) {
      case "Deslogar":
        Navigator.pushReplacementNamed(context, "/login");
        break;
      case "Configurações":
        break;
    }
  }

  /// Reactions
  final List<ReactionDisposer> _disposers = [];

  @override
  void initState() {
    super.initState();

    _controller = RouteUberControllerImpl();
    _controller.getAllUberEligibleRoutes();
  }

  @override
  void dispose() {
    for (var disposer in _disposers) {
      disposer();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rotas"),
        actions: [
          PopupMenuButton(
            onSelected: _choiceMenuItem,
            itemBuilder: (context) {
              return itemsMenu.map((String item) {
                return PopupMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Observer(
        builder: (_) {
          return _controller.requestStateGetAllUberEligibleRoutes is Loading
              ? _buildLoading()
              : _buildRoutesEligible();
        },
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        child: const SpinKitDualRing(
          color: Color(0xff37474f),
          size: 40,
          lineWidth: 3,
        ),
      ),
    );
  }

  Widget _buildRoutesEligible() {
    return RefreshIndicator(
      color: const Color(0xff37474f),
      onRefresh: _controller.reloadAllUberEligibleRoutes,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: _controller.eligibleRoutes.length,
        itemBuilder: (context, index) {
          return ItemTileRoute(
            route: _controller.eligibleRoutes[index],
          );
        },
      ),
    );
  }
}
