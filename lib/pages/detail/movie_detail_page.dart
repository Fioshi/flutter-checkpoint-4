import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/reviews/reviews_movie.dart'; // Importa a página de reviews
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/top_rated/widgets/similar_movies_page.dart'; // Importa a página de filmes semelhantes

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiServices = ApiServices();
  late Future<Movie> movieFuture;

  @override
  void initState() {
    super.initState();
    movieFuture = apiServices.getMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: FutureBuilder<Movie>(
        future: movieFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.hasData) {
            final movie = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Exibição do filme
                  Center(
                    child: Container(
                      height: 400,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage('$imageUrl${movie.posterPath}'),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Título do filme
                  Text(
                    movie.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  // Sinopse
                  Text('Sinopse: ${movie.overview}',
                      style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),

                  // Ano de lançamento
                  if (movie.releaseDate != null)
                    Text('Ano de Lançamento: ${movie.releaseDate!.year}',
                        style: const TextStyle(fontSize: 16)),
                  const SizedBox(height: 10),

                  // Avaliação
                  Text(
                      'Avaliação: ${movie.voteAverage.toStringAsFixed(1)} / 10',
                      style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),

                  // Botão para Reviews
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewMoviePage(
                              movieId:
                                  movie.id), // Navega para a página de reviews
                        ),
                      );
                    },
                    child: const Text('Ver Reviews'),
                  ),

                  const SizedBox(height: 20),

                  // Botão para filmes semelhantes
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SimilarMoviesPage(
                              movieId: movie
                                  .id), // Navega para a página de filmes semelhantes
                        ),
                      );
                    },
                    child: const Text('Ver Filmes Semelhantes'),
                  ),
                ],
              ),
            );
          }

          return const Center(
            child: Text('No data found'),
          );
        },
      ),
    );
  }
}
