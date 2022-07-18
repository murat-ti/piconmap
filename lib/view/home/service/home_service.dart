import 'package:flutter/material.dart';
import '../../_product/_network/_query/map_query_enum_string.dart';
import '../../../core/constants/enums/request_type.dart';
import '../../../core/init/network/interface/INetworkManager.dart';
import '../../_product/_network/_query/map_query.dart';
import '../../_product/_utility/ServiceHelper.dart';
import '../../_product/enum/openstreetmap_routes_string.dart';
import '../model/map_model.dart';
import 'IHomeService.dart';

class HomeService extends IHomeService with ServiceHelper {
  HomeService(INetworkManager manager, GlobalKey<ScaffoldMessengerState> scaffoldKey) : super(manager, scaffoldKey);

  @override
  Future<MapModel?> fetchLocation(MapQuery query) async {
    final response = await manager.send<MapModel, MapModel>(OpenStreetMapRoutes.REVERSE.rawValue,
        parseModel: MapModel(),
        queryParameters: {
          MapQueryEnum.FORMAT.rawValue: query.format,
          MapQueryEnum.LANGUAGE.rawValue: query.language,
          MapQueryEnum.EXTRATAGS.rawValue: query.extraTags,
          MapQueryEnum.NAMEDETAILS.rawValue: query.nameDetails,
          MapQueryEnum.LATITUDE.rawValue: query.latitude,
          MapQueryEnum.LONGITUDE.rawValue: query.longitude,
        },
        method: RequestType.GET);

    //showMessage(scaffoldKey, response.error);
    return response.data ?? null;
  }
}
