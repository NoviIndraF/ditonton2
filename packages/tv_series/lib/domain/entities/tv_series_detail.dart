import 'package:equatable/equatable.dart';

import 'genre.dart';

class TvSeriesDetail extends Equatable {
   final bool? adult;
   final String? backdropPath;
   final List<int>? episodeRunTime;
   final String? firstAirDate;
   final List<Genre>? genres;
   final String? homepage;
   final int? id;
   final bool? inProduction;
   final List<String>? languages;
   final String? lastAirDate;
   final String? name;
   final dynamic nextEpisodeToAir;
   final int? numberOfEpisodes;
   final int? numberOfSeasons;
   final List<String>? originCountry;
   final String? originalLanguage;
   final String? originalName;
   final String? overview;
   final double? popularity;
   final String? posterPath;
   final List<dynamic>? productionCompanies;
   final String? status;
   final String? tagline;
   final String? type;
   final double? voteAverage;
   final int? voteCount;

  const TvSeriesDetail({
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