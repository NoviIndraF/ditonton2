
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

TvSeriesDetailResponse tvSeriesDetailResponseFromJson(String str) => TvSeriesDetailResponse.fromJson(json.decode(str));

String tvSeriesDetailResponseToJson(TvSeriesDetailResponse data) => json.encode(data.toJson());

class TvSeriesDetailResponse extends Equatable {
  final bool adult;
  final String? backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<GenreModel> genres;
  final String homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  final String lastAirDate;
  final String name;
  final dynamic nextEpisodeToAir;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<dynamic> productionCompanies;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;

  TvSeriesDetailResponse({
    required this.adult,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.inProduction,
    required this.languages,
    required this.lastAirDate,
    required this.name,
    required this.nextEpisodeToAir,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.originCountry,
    required this.originalLanguage,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.status,
    required this.tagline,
    required this.type,
    required this.voteAverage,
    required this.voteCount,
  });

  factory TvSeriesDetailResponse.fromJson(Map<String, dynamic> json) => TvSeriesDetailResponse(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    episodeRunTime: List<int>.from(json["episode_run_time"].map((x) => x)),
    firstAirDate: json["first_air_date"],
    genres: List<GenreModel>.from(json["genres"].map((x) => GenreModel.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    inProduction: json["in_production"],
    languages: List<String>.from(json["languages"].map((x) => x)),
    lastAirDate: json["last_air_date"],
    name: json["name"],
    nextEpisodeToAir: json["next_episode_to_air"],
    numberOfEpisodes: json["number_of_episodes"],
    numberOfSeasons: json["number_of_seasons"],
    originCountry: List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    productionCompanies: List<dynamic>.from(json["production_companies"].map((x) => x)),
    status: json["status"],
    tagline: json["tagline"],
    type: json["type"],
    voteAverage: json["vote_average"],
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "adult": adult,
    "backdrop_path": backdropPath,
    "episode_run_time": List<dynamic>.from(episodeRunTime.map((x) => x)),
    "first_air_date": firstAirDate,
    "genres": List<dynamic>.from(genres.map((x) => x.toJson())),
    "homepage": homepage,
    "id": id,
    "in_production": inProduction,
    "languages": List<dynamic>.from(languages.map((x) => x)),
    "last_air_date": lastAirDate,
    "name": name,
    "next_episode_to_air": nextEpisodeToAir,
    "number_of_episodes": numberOfEpisodes,
    "number_of_seasons": numberOfSeasons,
    "origin_country": List<dynamic>.from(originCountry.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "production_companies": List<dynamic>.from(productionCompanies.map((x) => x)),
    "status": status,
    "tagline": tagline,
    "type": type,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };

  TvSeriesDetail toEntity() {
    return TvSeriesDetail(
        adult: this.adult,
        backdropPath: this.backdropPath,
        episodeRunTime: this.episodeRunTime,
        firstAirDate: this.firstAirDate,
        genres: this.genres.map((genre) => genre.toEntity()).toList(),
        homepage: this.homepage,
        id: this.id,
        inProduction: this.inProduction,
        languages: this.languages,
        lastAirDate: this.lastAirDate,
        name: this.name,
        nextEpisodeToAir: this.nextEpisodeToAir,
        numberOfEpisodes: this.numberOfEpisodes,
        numberOfSeasons: this.numberOfSeasons,
        originCountry: this.originCountry,
        originalLanguage: this.originalLanguage,
        originalName: this.originalName,
        overview: this.overview,
        popularity: this.popularity,
        posterPath: this.posterPath,
        productionCompanies: this.productionCompanies,
        status: this.status,
        tagline: this.tagline,
        type: this.type,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    adult,
    backdropPath,
    episodeRunTime,
    firstAirDate,
    genres,
    homepage,
    id,
    inProduction,
    languages,
    lastAirDate,
    name,
    nextEpisodeToAir,
    numberOfEpisodes,
    numberOfSeasons,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    status,
    tagline,
    type,
    voteAverage,
    voteCount];
  }

class GenreModel extends Equatable {
  final int id;
  final String name;

  GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) => GenreModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };

  Genre toEntity() {
    return Genre(id: this.id, name: this.name);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    name,
  ];
}