import 'package:json_annotation/json_annotation.dart';
import 'package:piconmap/view/home/model/address_model.dart';
import '../../../core/init/network/interface/INetworkModel.dart';
//part 'map_model.g.dart';

@JsonSerializable()
class MapModel extends INetworkModel<MapModel> {
  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  String? displayName;
  AddressModel? address;
  List<String>? boundingbox;

  MapModel(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.lat,
      this.lon,
      this.displayName,
      this.address,
      this.boundingbox});

  /*@override
  MapModel fromJson(Map<String, dynamic> json) {
    return _$MapModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$MapModelToJson(this);
  }*/

  MapModel.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    address = json['address'] != null ? new AddressModel.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['licence'] = this.licence;
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['display_name'] = this.displayName;
    if (this.address != null) {
      data['address'] = this.address?.toJson();
    }
    data['boundingbox'] = this.boundingbox;
    return data;
  }

  @override
  MapModel fromJson(Map<String, dynamic> json) {
    return MapModel.fromJson(json);
  }
}
