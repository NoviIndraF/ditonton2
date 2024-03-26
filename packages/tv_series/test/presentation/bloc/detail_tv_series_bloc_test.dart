import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecase/get_tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/detail_tv_series/detail_tv_series_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTvSeriesDetail])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late DetailTvSeriesBloc detailTvSeriesBloc;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    detailTvSeriesBloc = DetailTvSeriesBloc(mockGetTvSeriesDetail);
  });

  test('the initial state should be empty', () {
    expect(detailTvSeriesBloc.state, DetailTvSeriesInitial());
  });

  blocTest<DetailTvSeriesBloc, DetailTvSeriesState>(
    'should emit Loading state and then Error state when data failed to fetch',
    build: () {
      when(mockGetTvSeriesDetail.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return detailTvSeriesBloc;
    },
    act: (bloc) => bloc.add(GetTvSeriesDetailEvent(testId)),
    expect: () => [
      DetailTvSeriesLoading(),
      DetailTvSeriesError('Server Failure'),
    ],
    verify: (bloc) => DetailTvSeriesLoading(),
  );
}