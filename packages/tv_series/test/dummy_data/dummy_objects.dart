
import 'package:tv_series/data/model/tv_series_table.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testId = 1;

final testTvSeries = TvSeries(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalName: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  firstAirDate: '2002-05-01',
  name: 'Spider-Man',
  voteAverage: 7.2,
  voteCount: 13507,
  originCountry: ['eng'],
  originalLanguage: 'eng',
);

final testTvSeriesList = [testTvSeries];

final testTvSeriesDetail = TvSeriesDetail(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genres: [Genre(id: 1, name: 'Action')],
  id: 557,
  name: 'Spider-Man',
  overview:
  'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  voteAverage: 7.2,
  voteCount: 13507,
  originCountry: ['idn'],
  originalLanguage: 'idn',
  originalName: 'pulu',
  firstAirDate: '10-20-2009',
  episodeRunTime: [1],
  homepage: "pulu",
  inProduction: true,
  languages: ["eng"],
  lastAirDate: "10-20-2019",
  nextEpisodeToAir: 4,
  numberOfEpisodes: 123,
  numberOfSeasons: 5,
  productionCompanies: ["eng"],
  status: "on air",
  tagline: "",
  type: "",
);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 557,
  name: 'Spider-Man',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  overview: 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
);

final testTvSeriesTable = TvSeriesTable(
  id: 557,
  name: 'Spider-Man',
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  overview: 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
);

final testTvSeriesMap = {
  'id': 557,
  'overview': 'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  'posterPath': '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  'name': 'Spider-Man',
};
