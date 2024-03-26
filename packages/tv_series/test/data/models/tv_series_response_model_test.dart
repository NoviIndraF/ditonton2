import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/model/tv_series_model.dart';
import 'package:tv_series/data/model/tv_series_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
    adult: false,
    backdropPath: '/butPVWgcbtAjL9Z7jU7Xj1KA8KD.jpg',
    genreIds: [ 10767, 35],
    id: 22980,
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Watch What Happens Live with Andy Cohen",
    overview: "Bravo network executive Andy Cohen discusses pop culture topics with celebrities and reality show personalities.",
    popularity: 4286.342,
    posterPath: "/onSD9UXfJwrMXWhq7UY7hGF2S1h.jpg",
    firstAirDate: "2009-07-16",
    name: "Watch What Happens Live with Andy Cohen",
    voteAverage: 5.179,
    voteCount: 42
  );
  final tTvSeriesResponseModel = TvSeriesResponse(
    tvSeriesList: <TvSeriesModel>[tTvSeriesModel],
    page: 1,
    totalPages: 19,
    totalResults: 379,
  );
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('tv_series/dummy_data/airing_today.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {

          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/butPVWgcbtAjL9Z7jU7Xj1KA8KD.jpg",
              "genre_ids": [
                10767,
                35
              ],
              "id": 22980,
              "origin_country": [
                "US"
              ],
              "original_language": "en",
              "original_name": "Watch What Happens Live with Andy Cohen",
              "overview": "Bravo network executive Andy Cohen discusses pop culture topics with celebrities and reality show personalities.",
              "popularity": 4286.342,
              "poster_path": "/onSD9UXfJwrMXWhq7UY7hGF2S1h.jpg",
              "first_air_date": "2009-07-16",
              "name": "Watch What Happens Live with Andy Cohen",
              "vote_average": 5.179,
              "vote_count": 42
            }
          ],
          "total_pages": 19,
          "total_results": 379
        ,
      };
      expect(result, expectedJsonMap);
    });
  });
}
