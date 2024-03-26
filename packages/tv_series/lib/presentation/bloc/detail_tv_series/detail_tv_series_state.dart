part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesState extends Equatable {
  const DetailTvSeriesState();

  @override
  List<Object> get props => [];
}

final class DetailTvSeriesInitial extends DetailTvSeriesState {}

class DetailTvSeriesEmpty extends DetailTvSeriesState {}

class DetailTvSeriesLoading extends DetailTvSeriesState {}

class DetailTvSeriesError extends DetailTvSeriesState {
  final String message;

  DetailTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

class GetDetailTvSeriesState extends DetailTvSeriesState {
  final TvSeriesDetail result;

  GetDetailTvSeriesState(this.result);

  @override
  List<Object> get props => [result];
}