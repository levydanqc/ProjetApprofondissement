import 'package:astrokit/src/utils/file_manager.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

part 'astres.g.dart';

abstract class Astre {
  static const String _file = 'astres';
  final String distance;
  final String apparentSize;
  final String apparentMag;
  final String constellation;
  final String description;
  final String nom;
  final String category;
  bool fav;

  Astre(
      {required this.distance,
      required this.fav,
      required this.apparentSize,
      required this.apparentMag,
      required this.constellation,
      required this.description,
      required this.nom,
      required this.category});

  static loadAstres() async {
    final String jsonAstres = await rootBundle.loadString('assets/astres.json');
    if (jsonAstres == "0") writeToFile(jsonAstres, _file);
  }

  static Future<List<Astre>> getAstres() async {
    final data = jsonDecode(await readFile(_file));

    List<Astre> astres = [];

    for (Map<String, dynamic> astre in data) {
      switch (astre['category']) {
        case 'pln':
          astres.add(_$PlanetFromJson(astre));
          break;
        case 'glx':
          astres.add(_$GalaxyFromJson(astre));
          break;
        case 'nb':
          astres.add(_$NebuleaFromJson(astre));
          break;
        case 'str':
          astres.add(_$StarFromJson(astre));
          break;
        case 'stl':
          astres.add(_$SatelliteFromJson(astre));
          break;
      }
    }

    return astres;
  }

  static Future<List<Astre>> getFilter(String value) {
    value = value.toLowerCase().replaceAll("‘", "'").replaceAll("’", "'");
    return getAstres().then((astres) {
      return astres
          .where((astre) =>
              astre.nom.contains(value) || astre.constellation.contains(value))
          .toList();
    });
  }

  static Future<List<Astre>> getFav() {
    return getAstres().then((astres) {
      return astres.where((astre) => astre.fav).toList();
    });
  }

  static Future<List<Astre>> updateFav(Astre pAstre) {
    return getAstres().then((astres) {
      for (var astre in astres) {
        if (astre == pAstre) {
          astre.fav = !astre.fav;
          break;
        }
      }
      writeToFile(jsonEncode(astres), _file);
      return astres;
    });
  }

  toJson() {
    switch (category) {
      case 'pln':
        return _$PlanetToJson(this as Planet);
      case 'glx':
        return _$GalaxyToJson(this as Galaxy);
      case 'nb':
        return _$NebuleaToJson(this as Nebulea);
      case 'str':
        return _$StarToJson(this as Star);
      case 'stl':
        return _$SatelliteToJson(this as Satellite);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Astre &&
      nom == other.nom &&
      constellation == other.constellation;
  @override
  int get hashCode => Object.hash(nom.hashCode, nom.hashCode);
}

@JsonSerializable()
class Nebulea extends Astre {
  final String type;

  Nebulea(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required bool fav,
      required String category,
      required this.type})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category);

  factory Nebulea.fromJson(Map<String, dynamic> json) =>
      _$NebuleaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NebuleaToJson(this);
}

@JsonSerializable()
class Galaxy extends Astre {
  final String type;
  final String nbStars;

  Galaxy(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required String category,
      required bool fav,
      required this.type,
      required this.nbStars})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category);

  factory Galaxy.fromJson(Map<String, dynamic> json) => _$GalaxyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GalaxyToJson(this);
}

abstract class Annexe extends Astre {
  final String rayon;

  Annexe(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required String category,
      required bool fav,
      required this.rayon})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category);
}

@JsonSerializable()
class Planet extends Annexe {
  final bool hasRing;
  final int nbSatellites;

  Planet(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required String category,
      required this.hasRing,
      required this.nbSatellites,
      required bool fav,
      required String rayon})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category,
            rayon: rayon);

  factory Planet.fromJson(Map<String, dynamic> json) => _$PlanetFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlanetToJson(this);
}

@JsonSerializable()
class Star extends Annexe {
  Star(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required String category,
      required bool fav,
      required String rayon})
      : super(
            distance: distance,
            fav: fav,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category,
            rayon: rayon);

  factory Star.fromJson(Map<String, dynamic> json) => _$StarFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$StarToJson(this);
}

@JsonSerializable()
class Satellite extends Annexe {
  Satellite(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required String constellation,
      required String description,
      required String nom,
      required String category,
      required bool fav,
      required String rayon})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            constellation: constellation,
            description: description,
            nom: nom,
            category: category,
            rayon: rayon);

  factory Satellite.fromJson(Map<String, dynamic> json) =>
      _$SatelliteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SatelliteToJson(this);
}
