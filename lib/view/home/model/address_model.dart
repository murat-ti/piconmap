import 'package:json_annotation/json_annotation.dart';
import '../../../core/init/network/interface/INetworkModel.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel extends INetworkModel<AddressModel> {
  String? houseNumber;
  String? road;
  String? neighbourhood;
  String? city;
  String? county;
  String? state;
  String? postcode;
  String? country;
  String? countryCode;

  AddressModel(
      {this.houseNumber,
        this.road,
        this.neighbourhood,
        this.city,
        this.county,
        this.state,
        this.postcode,
        this.country,
        this.countryCode});

  @override
  AddressModel fromJson(Map<String, dynamic> json) {
    return AddressModel.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$AddressModelToJson(this);
  }

  /*AddressModel.fromJson(Map<String, dynamic> json) {
    _$AddressModelFromJson(json);
  }*/

  AddressModel.fromJson(Map<String, dynamic> json) {
    houseNumber = json['house_number'];
    road = json['road'];
    neighbourhood = json['neighbourhood'];
    city = json['city'];
    county = json['county'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  /*Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['house_number'] = this.houseNumber;
    data['road'] = this.road;
    data['neighbourhood'] = this.neighbourhood;
    data['city'] = this.city;
    data['county'] = this.county;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    return data;
  }*/
}