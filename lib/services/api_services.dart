import 'dart:convert';

import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:http/http.dart' as http;

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  Future<Result> getTopRatedMovies() async {
    const endpoint = "movie/top_rated";
    final url = Uri.parse("$baseUrl$endpoint$key");
    final response = await http.get(url);

    //verificando se foi c sucesso
    if (response.statusCode == 200) {
      //pega conteudo da requisição
      final json = jsonDecode(response.body);
      final result = Result.fromJson(json);
      return result;
    }
    throw Exception('Ocorreu um erro');
  }

  Future<List<Movie>> getMoviesHome(String endpoint) async {
    final url = Uri.parse("$baseUrl$endpoint$key");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<Movie> similarMovies = (json['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        return similarMovies;
      } else {
        throw Exception('Erro ao carregar filmes semelhantes');
      }
    } catch (e) {
      throw Exception('Falha ao se conectar à API');
    }
  }

  Future<Result> searchMoveis(String keywords) async {
    var endpoint = "search/movie";
    var query = "&query=$keywords";
    final url = Uri.parse("$baseUrl$endpoint$key$query");
    final response = await http.get(url);

    //verificando se foi c sucesso
    if (response.statusCode == 200) {
      //pega conteudo da requisição
      final json = jsonDecode(response.body);
      final result = Result.fromJson(json);
      return result;
    }
    print(url);
    throw Exception('Ocorreu um erro');
    // try {
    //   final response = await http.get(url);
    //   if (response.statusCode == 200) {
    //     final json = jsonDecode(response.body);
    //     List<Movie> similarMovies = (json['results'] as List)
    //         .map((movieJson) => Movie.fromJson(movieJson))
    //         .toList();
    //     return similarMovies;
    //   } else {
    //     throw Exception('Erro ao carregar filmes semelhantes');
    //   }
    // } catch (e) {
    //   throw Exception('Falha ao se conectar à API');
    // }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    const String key = '91403b43dec5b52a06ff2f5a1df26fe6';
    final url =
        Uri.parse("https://api.themoviedb.org/3/movie/$movieId?api_key=$key");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        final movie = Movie.fromJson(json);
        return movie;
      } else {
        throw Exception('Erro ao carregar os detalhes do filme');
      }
    } catch (e) {
      throw Exception('Falha ao se conectar à API');
    }
  }

  Future<List<Movie>> getSimilarMovies(int movieId) async {
    const String apiKey = '91403b43dec5b52a06ff2f5a1df26fe6';
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/similar?api_key=$apiKey");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<Movie> similarMovies = (json['results'] as List)
            .map((movieJson) => Movie.fromJson(movieJson))
            .toList();
        return similarMovies;
      } else {
        throw Exception('Erro ao carregar filmes semelhantes');
      }
    } catch (e) {
      throw Exception('Falha ao se conectar à API');
    }
  }

  Future<List<Review>> getMovieReviews(int movieId) async {
    const String apiKey = '91403b43dec5b52a06ff2f5a1df26fe6';
    final url = Uri.parse(
        "https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=$apiKey");

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        List<Review> reviews = (json['results'] as List)
            .map((reviewJson) => Review.fromJson(reviewJson))
            .toList();
        return reviews;
      } else {
        throw Exception('Erro ao carregar as reviews do filme');
      }
    } catch (e) {
      throw Exception('Falha ao se conectar à API');
    }
  }
}
