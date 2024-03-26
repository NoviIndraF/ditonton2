import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/entities/movie_detail.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus getWatchListStatusMovie;
  final GetWatchlistMovies getWatchlistMovie;
  final RemoveWatchlist removeWatchlistMovie;
  final SaveWatchlist saveWatchlistMovie;

  WatchlistMovieBloc(
    this.getWatchListStatusMovie,
    this.getWatchlistMovie,
    this.removeWatchlistMovie,
    this.saveWatchlistMovie,
  ) : super(WatchlistMovieInitial()) {
    on<GetMovieWatchlistStatusEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      try {
        final result = await getWatchListStatusMovie.execute(event.id);
        emit(GetMovieWatchlistStatusState(result));
      } catch (message) {
        emit(WatchlistMovieError(message.toString()));
      }
    });

    on<GetWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovie.execute();

      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(WatchlistMovieEmpty())
              : emit(GetWatchlistMovieState(data));
        },
      );
    });

    on<RemoveWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await removeWatchlistMovie.execute(event.tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          emit(RemovedWatchlistMovieState(data));
        },
      );
    });

    on<SaveWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await saveWatchlistMovie.execute(event.tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistMovieError(failure.message));
        },
        (data) {
          emit(SavedWatchlistMovieState(data));
        },
      );
    });
  }
}
