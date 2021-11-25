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
  final List<dynamic> description;
  final String nom;
  final String categorie;
  final String rayon;
  bool fav;

  Astre(
      {required this.distance,
      required this.rayon,
      required this.fav,
      required this.apparentSize,
      required this.apparentMag,
      required this.description,
      required this.nom,
      required this.categorie});

  static loadAstres() async {
    final String jsonAstres = await rootBundle.loadString('assets/astres.json');
    writeToFile(jsonAstres, _file);
  }

  static Future<List<Astre>> getAstres() async {
    final data = jsonDecode(await readFile(_file));

    List<Astre> astres = [];

    for (Map<String, dynamic> astre in data) {
      switch (astre['categorie']) {
        case 'planète':
          astres.add(_$PlanetFromJson(astre));
          break;
        case 'galaxie':
          astres.add(_$GalaxyFromJson(astre));
          break;
        case 'nébuleuse':
          astres.add(_$NebuleaFromJson(astre));
          break;
        case 'étoile':
          astres.add(_$StarFromJson(astre));
          break;
        case 'satellite':
          astres.add(_$SatelliteFromJson(astre));
          break;
      }
    }
    astres.sort((a, b) => a.nom.compareTo(b.nom));
    return astres;
  }

  static Future<List<Astre>> getFilter(String value) {
    value = value.toLowerCase().replaceAll("‘", "'").replaceAll("’", "'");
    return getAstres().then((astres) {
      return astres
          .where((astre) =>
              astre.nom.toLowerCase().contains(value) ||
              astre.categorie.toLowerCase().contains(value) ||
              (astre is Nebulea &&
                  astre.constellation.toLowerCase().contains(value)) ||
              (astre is Galaxy &&
                  astre.constellation.toLowerCase().contains(value)))
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
    switch (categorie) {
      case 'planète':
        return _$PlanetToJson(this as Planet);
      case 'galaxie':
        return _$GalaxyToJson(this as Galaxy);
      case 'nébuleuse':
        return _$NebuleaToJson(this as Nebulea);
      case 'étoile':
        return _$StarToJson(this as Star);
      case 'satellite':
        return _$SatelliteToJson(this as Satellite);
    }
  }

  @override
  bool operator ==(Object other) =>
      other is Astre && nom == other.nom && categorie == other.categorie;
  @override
  int get hashCode => Object.hash(nom.hashCode, nom.hashCode);
}

@JsonSerializable()
class Nebulea extends Astre {
  final String type;
  final String constellation;
  final String catalogue;

  Nebulea(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required List<dynamic> description,
      required String nom,
      required bool fav,
      required String categorie,
      required String rayon,
      required this.type,
      required this.constellation,
      required this.catalogue})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            categorie: categorie,
            rayon: rayon);

  factory Nebulea.fromJson(Map<String, dynamic> json) =>
      _$NebuleaFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NebuleaToJson(this);
}

@JsonSerializable()
class Galaxy extends Astre {
  final String type;
  final String nbStars;
  final String constellation;
  final String catalogue;

  Galaxy(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required List<dynamic> description,
      required String nom,
      required String categorie,
      required bool fav,
      required String rayon,
      required this.constellation,
      required this.type,
      required this.nbStars,
      required this.catalogue})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            rayon: rayon,
            categorie: categorie);

  factory Galaxy.fromJson(Map<String, dynamic> json) => _$GalaxyFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$GalaxyToJson(this);
}

abstract class Annexe extends Astre {
  Annexe(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required List<dynamic> description,
      required String nom,
      required String categorie,
      required bool fav,
      required String rayon})
      : super(
            fav: fav,
            rayon: rayon,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            categorie: categorie);
}

@JsonSerializable()
class Planet extends Annexe {
  final bool hasRing;
  final int nbSatellites;

  Planet(
      {required String distance,
      required String apparentSize,
      required String apparentMag,
      required List<dynamic> description,
      required String nom,
      required String categorie,
      required this.hasRing,
      required this.nbSatellites,
      required bool fav,
      required String rayon})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            categorie: categorie,
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
      required List<dynamic> description,
      required String nom,
      required String categorie,
      required bool fav,
      required String rayon})
      : super(
            distance: distance,
            fav: fav,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            categorie: categorie,
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
      required List<dynamic> description,
      required String nom,
      required String categorie,
      required bool fav,
      required String rayon})
      : super(
            fav: fav,
            distance: distance,
            apparentSize: apparentSize,
            apparentMag: apparentMag,
            description: description,
            nom: nom,
            categorie: categorie,
            rayon: rayon);

  factory Satellite.fromJson(Map<String, dynamic> json) =>
      _$SatelliteFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SatelliteToJson(this);
}
