part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();

  @override
  List<Object> get props => [];
}

class GetMovieDetailEvent extends DetailMovieEvent {
  int id;
  GetMovieDetailEvent(this.id);

  @override
  List<Object> get props => [];
}