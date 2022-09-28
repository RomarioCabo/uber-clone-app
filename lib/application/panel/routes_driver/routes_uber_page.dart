import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/store/routes_driver/route_uber_controller_impl.dart';
import '../../../infrastructure/helpers/request_state.dart';
import '../../item_tile/route/item_tile_route.dart';
import '../../no_content/no_content.dart';

class RoutesUberPage extends StatefulWidget {
  const RoutesUberPage({Key? key}) : super(key: key);

  @override
  State<RoutesUberPage> createState() => _RoutesUberPageState();
}

class _RoutesUberPageState extends State<RoutesUberPage> {
  late RouteUberControllerImpl _controller;

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
    return Observer(
      builder: (_) {
        return _controller.requestStateGetAllUberEligibleRoutes is Loading
            ? _buildLoading()
            : _buildRoutesEligible();
      },
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
    return _controller.eligibleRoutes.isEmpty
        ? NoContent(
            buttonText: 'VERIFICAR NOVAMENTE',
            alertText: 'Não encontramos nenhuma corrida disponível',
            imagePath: 'imagens/no_results_found.png',
            function: () {
              _controller.getAllUberEligibleRoutes();
            },
          )
        : RefreshIndicator(
            color: const Color(0xff37474f),
            onRefresh: _controller.reloadAllUberEligibleRoutes,
            child: ListView.separated(
              padding: const EdgeInsets.all(14.0),
              separatorBuilder: (context, index) => Divider(
                color: Colors.grey[400],
              ),
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
