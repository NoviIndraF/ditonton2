import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvSeriesDetail extends Equatable {
   bool? adult;
   String? backdropPath;
   List<int>? episodeRunTime;
   String? firstAirDate;
   List<Genre>? genres;
   String? homepage;
   int? id;
   bool? inProduction;
   List<String>? languages;
   String? lastAirDate;
   String? name;
   dynamic? nextEpisodeToAir;
   int? numberOfEpisodes;
   int? numberOfSeasons;
   List<String>? originCountry;
   String? originalLanguage;
   String? originalName;
   String? overview;
   double? popularity;
   String? posterPath;
   List<dynamic>? productionCompanies;
   String? status;
   String? tagline;
   String? type;
   double? voteAverage;
   int? voteCount;

  TvSeriesDetail({
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