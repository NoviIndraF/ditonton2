part of 'detail_tv_series_bloc.dart';

abstract class DetailTvSeriesEvent extends Equatable {
  const DetailTvSeriesEvent();

  @override
  List<Object> get props => [];
}

class GetTvSeriesDetailEvent extends DetailTvSeriesEvent {
  int id;
  GetTvSeriesDetailEvent(this.id);

  @override
  List<Object> get props => [];
}