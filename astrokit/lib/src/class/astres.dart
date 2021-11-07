import 'package:json_annotation/json_annotation.dart';
part 'astres.g.dart';

abstract class Astre {
  final String distance;
  final String appSize;
  final String appMag;
  final String constellation;
  final String description;

  Astre(
      {required this.distance,
      required this.appSize,
      required this.appMag,
      required this.constellation,
      required this.description});
}

@JsonSerializable()
class Nebulea extends Astre {
  final String type;
  final String? name;

  Nebulea(
      {required this.type,
      this.name,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );

  Nebulea.withName(
      {required this.type,
      required this.name,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );

  factory Nebulea.fromJson(Map<String, dynamic> json) => _$Nebulea(json);

  Map<String, dynamic> toJson() => _$Nebulea(this);
}

@JsonSerializable()
class Galaxy extends Astre {
  final String type;
  final String nbStars;

  Galaxy(
      {required this.type,
      required this.nbStars,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );

  factory Galaxy.fromJson(Map<String, dynamic> json) => _$Galaxy(json);

  Map<String, dynamic> toJson() => _$Galaxy(this);
}

abstract class Annexe extends Astre {
  final String rayon;

  Annexe(
      {required this.rayon,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );
}

@JsonSerializable()
class Planet extends Annexe {
  final bool hasRing;
  final int nbSatellites;

  Planet(
      {required this.hasRing,
      required this.nbSatellites,
      required rayon,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          rayon: rayon,
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );

  factory Planet.fromJson(Map<String, dynamic> json) => _$Planet(json);

  Map<String, dynamic> toJson() => _$Planet(this);
}

@JsonSerializable()
class Star extends Annexe {
  final bool type;

  Star(
      {required this.type,
      required rayon,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          rayon: rayon,
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );

  factory Star.fromJson(Map<String, dynamic> json) => _$Star(json);

  Map<String, dynamic> toJson() => _$Star(this);
}

@JsonSerializable()
class Satellite extends Annexe {
  final bool hasRing;

  Satellite(
      {required this.hasRing,
      required rayon,
      required distance,
      required appSize,
      required appMag,
      required constellation,
      required description})
      : super(
          rayon: rayon,
          distance: distance,
          appSize: appSize,
          appMag: appMag,
          constellation: constellation,
          description: description,
        );
  factory Satellite.fromJson(Map<String, dynamic> json) => _$Satellite(json);

  Map<String, dynamic> toJson() => _$Satellite(this);
}
