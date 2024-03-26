import 'package:core/core.dart';
import 'package:tv_series/tv_series.dart';
import 'package:dartz/dartz.dart';

class SearchTvSeries {
  final TvSeriesRepository repository;

  SearchTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute(String query) {
    return repository.searchTvSeries(query);
  }
}
