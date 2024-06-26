import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';
import '../../widgets/widges.dart';
import 'package:intl/intl.dart';


class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovuesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {


    final initialLoading = ref.watch(initialLoadinProvider);

    if( initialLoading) {
      return const FullScreenLoader();
    } 

    final slideShowMovies = ref.watch(moviesSlidesshowProvider);
    final nowPlayingMovies = ref.watch(nowPlayingMovuesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);
    final now = DateTime.now();
    final formattedDate = DateFormat('dd-MM-yyyy').format(now);


    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppBar(),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
             // const CustomAppBar(),
              MoviesSlideshow(movies: slideShowMovies),
              MovieHorizonListView(
                movies: nowPlayingMovies,
                title: 'En cines',
                
                subTitle: formattedDate,
                loadNextPage: () {
                  ref.read(nowPlayingMovuesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizonListView(
                movies: upcomingMovies,
                title: 'Próximamente',
                subTitle: 'en este mes',
                loadNextPage: () {
                  ref.read(upcomingMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizonListView(
                movies: popularMovies,
                title: 'Populares',
                loadNextPage: () {
                  ref.read(popularMoviesProvider.notifier).loadNextPage();
                },
              ),
              MovieHorizonListView(
                movies: topRatedMovies,
                title: 'Mejor calificadas',
                subTitle: 'Todos los tiempos',
                loadNextPage: () {
                  ref.read(topRatedMoviesProvider.notifier).loadNextPage();
                },
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ],
    );
  }
}
