// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nebulea _$NebuleaFromJson(Map<String, dynamic> json) => Nebulea(
      fav: json['fav'] as bool,
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      constellation: json['constellation'] as String,
      description: json['description'] as String,
      nom: json['nom'] as String,
      category: json['category'] as String,
      type: json['type'] as String,
    );

Map<String, dynamic> _$NebuleaToJson(Nebulea instance) => <String, dynamic>{
      'fav': instance.fav,
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'nom': instance.nom,
      'category': instance.category,
      'type': instance.type,
    };

Galaxy _$GalaxyFromJson(Map<String, dynamic> json) => Galaxy(
      fav: json['fav'] as bool,
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      constellation: json['constellation'] as String,
      description: json['description'] as String,
      nom: json['nom'] as String,
      category: json['category'] as String,
      type: json['type'] as String,
      nbStars: json["nombre d'étoiles"] as String,
    );

Map<String, dynamic> _$GalaxyToJson(Galaxy instance) => <String, dynamic>{
      'fav': instance.fav,
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'nom': instance.nom,
      'category': instance.category,
      'type': instance.type,
      "nombre d'étoiles": instance.nbStars,
    };

Planet _$PlanetFromJson(Map<String, dynamic> json) => Planet(
      fav: json['fav'] as bool,
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      constellation: json['constellation'] as String,
      description: json['description'] as String,
      nom: json['nom'] as String,
      category: json['category'] as String,
      hasRing: json['hasRing'] as bool,
      nbSatellites: json['nombre de satellites'] as int,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$PlanetToJson(Planet instance) => <String, dynamic>{
      'fav': instance.fav,
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'nom': instance.nom,
      'category': instance.category,
      'rayon': instance.rayon,
      'hasRing': instance.hasRing,
      'nombre de satellites': instance.nbSatellites,
    };

Star _$StarFromJson(Map<String, dynamic> json) => Star(
      fav: json['fav'] as bool,
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      constellation: json['constellation'] as String,
      description: json['description'] as String,
      nom: json['nom'] as String,
      category: json['category'] as String,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$StarToJson(Star instance) => <String, dynamic>{
      'fav': instance.fav,
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'nom': instance.nom,
      'category': instance.category,
      'rayon': instance.rayon,
    };

Satellite _$SatelliteFromJson(Map<String, dynamic> json) => Satellite(
      fav: json['fav'] as bool,
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      constellation: json['constellation'] as String,
      description: json['description'] as String,
      nom: json['nom'] as String,
      category: json['category'] as String,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$SatelliteToJson(Satellite instance) => <String, dynamic>{
      'fav': instance.fav,
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'constellation': instance.constellation,
      'description': instance.description,
      'nom': instance.nom,
      'category': instance.category,
      'rayon': instance.rayon,
    };
