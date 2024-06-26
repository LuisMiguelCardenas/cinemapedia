import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CostomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
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
                subTitle: 'Lunes 20',
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
                // subTitle: 'Lunes 20',
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
