// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nebulea _$NebuleaFromJson(Map<String, dynamic> json) => Nebulea(
      type: json['type'] as String,
      distance: json['distance'],
      appSize: json['appSize'],
      appMag: json['appMag'],
      constellation: json['constellation'],
      description: json['description'],
    );

Map<String, dynamic> _$NebuleaToJson(Nebulea instance) => <String, dynamic>{
      'distance': instance.distance,
      'appSize': instance.appSize,
      'appMag': instance.appMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'type': instance.type,
    };

Galaxy _$GalaxyFromJson(Map<String, dynamic> json) => Galaxy(
      type: json['type'] as String,
      nbStars: json['nbStars'] as String,
      distance: json['distance'],
      appSize: json['appSize'],
      appMag: json['appMag'],
      constellation: json['constellation'],
      description: json['description'],
    );

Map<String, dynamic> _$GalaxyToJson(Galaxy instance) => <String, dynamic>{
      'distance': instance.distance,
      'appSize': instance.appSize,
      'appMag': instance.appMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'type': instance.type,
      'nbStars': instance.nbStars,
    };

Planet _$PlanetFromJson(Map<String, dynamic> json) => Planet(
      hasRing: json['hasRing'] as bool,
      nbSatellites: json['nbSatellites'] as int,
      rayon: json['rayon'],
      distance: json['distance'],
      appSize: json['appSize'],
      appMag: json['appMag'],
      constellation: json['constellation'],
      description: json['description'],
    );

Map<String, dynamic> _$PlanetToJson(Planet instance) => <String, dynamic>{
      'distance': instance.distance,
      'appSize': instance.appSize,
      'appMag': instance.appMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'rayon': instance.rayon,
      'hasRing': instance.hasRing,
      'nbSatellites': instance.nbSatellites,
    };

Star _$StarFromJson(Map<String, dynamic> json) => Star(
      type: json['type'] as bool,
      rayon: json['rayon'],
      distance: json['distance'],
      appSize: json['appSize'],
      appMag: json['appMag'],
      constellation: json['constellation'],
      description: json['description'],
    );

Map<String, dynamic> _$StarToJson(Star instance) => <String, dynamic>{
      'distance': instance.distance,
      'appSize': instance.appSize,
      'appMag': instance.appMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'rayon': instance.rayon,
      'type': instance.type,
    };

Satellite _$SatelliteFromJson(Map<String, dynamic> json) => Satellite(
      hasRing: json['hasRing'] as bool,
      rayon: json['rayon'],
      distance: json['distance'],
      appSize: json['appSize'],
      appMag: json['appMag'],
      constellation: json['constellation'],
      description: json['description'],
    );

Map<String, dynamic> _$SatelliteToJson(Satellite instance) => <String, dynamic>{
      'distance': instance.distance,
      'appSize': instance.appSize,
      'appMag': instance.appMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'rayon': instance.rayon,
      'hasRing': instance.hasRing,
    };
