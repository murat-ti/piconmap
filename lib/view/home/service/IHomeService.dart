import 'package:flutter/material.dart';
import '../../_product/_network/_query/map_query.dart';
import '../../../core/init/network/interface/INetworkManager.dart';
import '../model/map_model.dart';

abstract class IHomeService{
  final INetworkManager manager;
  final GlobalKey<ScaffoldMessengerState> scaffoldKey;
  IHomeService(this.manager, this.scaffoldKey);

  Future<MapModel?> fetchLocation(MapQuery query);
}