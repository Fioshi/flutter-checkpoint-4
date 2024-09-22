import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/pages/detail/movie_detail_page.dart';
import 'package:movie_app/pages/top_rated/widgets/top_rated_movie.dart';
import 'package:movie_app/services/api_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ApiServices apiServices = ApiServices();
  late Future<Result> movies;
  var keywods = "";

  @override
  void initState() {
    movies = apiServices.searchMoveis(keywods);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: CupertinoSearchTextField(
                padding: const EdgeInsets.all(10.0),
                prefixIcon: const Icon(
                  CupertinoIcons.search,
                  color: Colors.grey,
                ),
                suffixIcon: const Icon(
                  Icons.cancel,
                  color: Colors.grey,
                ),
                style: const TextStyle(color: Colors.white),
                backgroundColor: Colors.grey.withOpacity(0.3),
                onChanged: (value) {
                  setState(() {
                    keywods = value;
                    movies =
                        apiServices.searchMoveis(keywods);
                  });
                },
              ),
            ),
            const SizedBox(height: 10),
            const Text('Aqui aparecerão seus filmes 😎'),
            Expanded(
              child: FutureBuilder<Result>(
                future: movies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.movies.length,
                      itemBuilder: (context, index) {
                        final movie = snapshot.data!.movies[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    MovieDetailPage(movieId: movie.id),
                              ),
                            );
                          },
                          child: TopRatedMovie(movie: movie),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text('No data found'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
