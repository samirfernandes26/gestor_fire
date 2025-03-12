// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gps_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GpsModel _$GpsModelFromJson(Map<String, dynamic> json) => GpsModel(
  precisionGps: (json['precision_GPS'] as num).toInt(),
  searchTypeGps: (json['search_type_GPS'] as num).toInt(),
);

Map<String, dynamic> _$GpsModelToJson(GpsModel instance) => <String, dynamic>{
  'precision_GPS': instance.precisionGps,
  'search_type_GPS': instance.searchTypeGps,
};
