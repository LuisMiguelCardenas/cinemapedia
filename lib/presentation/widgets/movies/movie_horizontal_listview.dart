import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MovieHorizonListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizonListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizonListView> createState() => _MovieHorizonListViewState();
}

class _MovieHorizonListViewState extends State<MovieHorizonListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;

      if (scrollController.position.pixels + 200 >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              // movies: movies,
              title: widget.title,
              subtitle: widget.subTitle,
            ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.movies.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return FadeInRight(
                        child: _Slide(movie: widget.movies[index]));
                  }))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  // final List<Movie> movies;
  final String? title;
  final String? subtitle;

  const _Title({
    this.title,
    this.subtitle,
    // required this.movies
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          if (title != null)
            Text(
              title!,
              style: titleStyle,
            ),
          const Spacer(),
          if (subtitle != null)
            FilledButton.tonal(
              style: const ButtonStyle(visualDensity: VisualDensity.compact),
              onPressed: () {},
              child: Text(subtitle!),
            ),
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;
  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: 150,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              movie.posterPath,
              fit: BoxFit.cover,
              width: 150,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress != null) {
                  return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ));
                }
                return GestureDetector(
                  onTap: () => context.push('/movie/${ movie.id}'),
                  child: FadeIn(child: child),
                );
              },
            ),
          ),
        ),
        SizedBox(
          width: 150,
          child: Text(
            movie.title,
            maxLines: 2,
            style: textStyle.titleSmall,
          ),
        ),
        SizedBox(
          width: 150,
          child: Row(
            children: [
              Icon(Icons.star_half_outlined, color: Colors.yellow.shade800),
              const SizedBox(width: 3),
              Text(
                '${movie.voteAverage}',
                style: textStyle.bodyMedium
                    ?.copyWith(color: Colors.yellow.shade800),
              ),
              const SizedBox(width: 10),
              Text(
                HumanFormats.number(movie.popularity),
                style: textStyle.bodySmall,
              )
            ],
          ),
        )
      ]),
    );
  }
}
