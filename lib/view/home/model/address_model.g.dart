// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddressModel _$AddressModelFromJson(Map<String, dynamic> json) => AddressModel(
      houseNumber: json['houseNumber'] as String?,
      road: json['road'] as String?,
      neighbourhood: json['neighbourhood'] as String?,
      city: json['city'] as String?,
      county: json['county'] as String?,
      state: json['state'] as String?,
      postcode: json['postcode'] as String?,
      country: json['country'] as String?,
      countryCode: json['countryCode'] as String?,
    );

Map<String, dynamic> _$AddressModelToJson(AddressModel instance) =>
    <String, dynamic>{
      'houseNumber': instance.houseNumber,
      'road': instance.road,
      'neighbourhood': instance.neighbourhood,
      'city': instance.city,
      'county': instance.county,
      'state': instance.state,
      'postcode': instance.postcode,
      'country': instance.country,
      'countryCode': instance.countryCode,
    };
