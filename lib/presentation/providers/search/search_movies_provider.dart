import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final searchQueryProviuder = StateProvider<String>((ref) => '');

final searchedMoviesProvider = StateNotifierProvider<SearchMoviesNotigfier, List<Movie>>((ref){

final movieRepository = ref.read( movieRepositoryProvider);

return SearchMoviesNotigfier(
  searchMovies: movieRepository.searchMovies, 
  ref: ref
  );
});

typedef SearchMoviesCallback = Future<List<Movie>> Function( String query );

class SearchMoviesNotigfier extends StateNotifier <List<Movie>> {

  final SearchMoviesCallback searchMovies;
  final Ref ref;
  
  SearchMoviesNotigfier({
    required this.searchMovies,
    required this.ref
  }): super([]);

  Future<List<Movie>> searchMoviesbyQuery( String query) async {


    final List<Movie> movies = await searchMovies(query);

    ref.read(searchQueryProviuder.notifier).update((state) => query);

    state = movies;
    return movies;
  }

}