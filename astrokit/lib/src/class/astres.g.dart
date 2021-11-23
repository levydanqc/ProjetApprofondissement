// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'astres.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Nebulea _$NebuleaFromJson(Map<String, dynamic> json) => Nebulea(
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      description: json['description'] as List<dynamic>,
      nom: json['nom'] as String,
      fav: json['fav'] as bool,
      categorie: json['categorie'] as String,
      rayon: json['rayon'] as String,
      type: json['type'] as String,
      constellation: json['constellation'] as String,
      catalogue: json['catalogue'] as String,
    );

Map<String, dynamic> _$NebuleaToJson(Nebulea instance) => <String, dynamic>{
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'description': instance.description,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'rayon': instance.rayon,
      'fav': instance.fav,
      'type': instance.type,
      'constellation': instance.constellation,
      'catalogue': instance.catalogue,
    };

Galaxy _$GalaxyFromJson(Map<String, dynamic> json) => Galaxy(
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      description: json['description'] as List<dynamic>,
      nom: json['nom'] as String,
      categorie: json['categorie'] as String,
      fav: json['fav'] as bool,
      rayon: json['rayon'] as String,
      constellation: json['constellation'] as String,
      type: json['type'] as String,
      nbStars: json["nombre d'étoiles"] as String,
      catalogue: json['catalogue'] as String,
    );

Map<String, dynamic> _$GalaxyToJson(Galaxy instance) => <String, dynamic>{
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'description': instance.description,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'rayon': instance.rayon,
      'fav': instance.fav,
      'type': instance.type,
      "nombre d'étoiles": instance.nbStars,
      'constellation': instance.constellation,
      'catalogue': instance.catalogue,
    };

Planet _$PlanetFromJson(Map<String, dynamic> json) => Planet(
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      description: json['description'] as List<dynamic>,
      nom: json['nom'] as String,
      categorie: json['categorie'] as String,
      hasRing: json['hasRing'] as bool,
      nbSatellites: json['nombre de satellites'] as int,
      fav: json['fav'] as bool,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$PlanetToJson(Planet instance) => <String, dynamic>{
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'description': instance.description,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'rayon': instance.rayon,
      'fav': instance.fav,
      'hasRing': instance.hasRing,
      'nombre de satellites': instance.nbSatellites,
    };

Star _$StarFromJson(Map<String, dynamic> json) => Star(
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      description: json['description'] as List<dynamic>,
      nom: json['nom'] as String,
      categorie: json['categorie'] as String,
      fav: json['fav'] as bool,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$StarToJson(Star instance) => <String, dynamic>{
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'description': instance.description,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'rayon': instance.rayon,
      'fav': instance.fav,
    };

Satellite _$SatelliteFromJson(Map<String, dynamic> json) => Satellite(
      distance: json['distance'] as String,
      apparentSize: json['taille app.'] as String,
      apparentMag: json['magnitude app.'] as String,
      description: json['description'] as List<dynamic>,
      nom: json['nom'] as String,
      categorie: json['categorie'] as String,
      fav: json['fav'] as bool,
      rayon: json['rayon'] as String,
    );

Map<String, dynamic> _$SatelliteToJson(Satellite instance) => <String, dynamic>{
      'distance': instance.distance,
      'taille app.': instance.apparentSize,
      'magnitude app.': instance.apparentMag,
      'description': instance.description,
      'nom': instance.nom,
      'categorie': instance.categorie,
      'rayon': instance.rayon,
      'fav': instance.fav,
    };
