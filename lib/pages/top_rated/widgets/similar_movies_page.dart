import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';

class SimilarMoviesPage extends StatelessWidget {
  final int movieId;
  final ApiServices apiServices = ApiServices();

  SimilarMoviesPage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Similar Movies'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: apiServices.getSimilarMovies(movieId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('Nenhum filme semelhante encontrado.'));
          }

          return MoviesHorizontalList(movies: snapshot.data!);
        },
      ),
    );
  }
}
