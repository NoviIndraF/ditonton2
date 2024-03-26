import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/usecase/get_watchlist_status_tv_series.dart';
import 'package:tv_series/domain/usecase/get_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecase/remove_watchlist_tv_series.dart';
import 'package:tv_series/domain/usecase/save_watchlist_tv_series.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class WatchlistTvSeriesBloc
    extends Bloc<WatchlistTvSeriesEvent, WatchlistTvSeriesState> {
  final GetWatchListStatusTvSeries getWatchListStatusTvSeries;
  final GetWatchlistTvSeries getWatchlistTvSeries;
  final RemoveWatchlistTvSeries removeWatchlistTvSeries;
  final SaveWatchlistTvSeries saveWatchlistTvSeries;

  WatchlistTvSeriesBloc(
    this.getWatchListStatusTvSeries,
    this.getWatchlistTvSeries,
    this.removeWatchlistTvSeries,
    this.saveWatchlistTvSeries,
  ) : super(WatchlistTvSeriesInitial()) {
    on<GetTvSeriesWatchlistStatusEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      try {
        final result = await getWatchListStatusTvSeries.execute(event.id);
        emit(GetTvSeriesWatchlistStatusState(result));
      } catch (message) {
        emit(WatchlistTvSeriesError(message.toString()));
      }
    });

    on<GetWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await getWatchlistTvSeries.execute();

      result.fold(
        (failure) {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (data) {
          data.isEmpty
              ? emit(WatchlistTvSeriesEmpty())
              : emit(GetWatchlistTvSeriesState(data));
        },
      );
    });

    on<RemoveWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result =
          await removeWatchlistTvSeries.execute(event.tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (data) {
          emit(RemovedWatchlistTvSeriesState(data));
        },
      );
    });

    on<SaveWatchlistTvSeriesEvent>((event, emit) async {
      emit(WatchlistTvSeriesLoading());
      final result = await saveWatchlistTvSeries.execute(event.tvSeriesDetail);

      result.fold(
        (failure) {
          emit(WatchlistTvSeriesError(failure.message));
        },
        (data) {
          emit(SavedWatchlistTvSeriesState(data));
        },
      );
    });
  }
}
