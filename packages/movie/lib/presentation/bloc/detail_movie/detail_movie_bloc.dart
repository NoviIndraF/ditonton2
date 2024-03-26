import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail getMovieDetail;

  DetailMovieBloc(
    this.getMovieDetail,
  ) : super(DetailMovieInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      emit(DetailMovieLoading());
      final result = await getMovieDetail.execute(event.id);

      result.fold(
        (failure) {
          emit(DetailMovieError(failure.message));
        },
        (data) {
          emit(GetDetailMovieState(data));
        },
      );
    });
  }
}
