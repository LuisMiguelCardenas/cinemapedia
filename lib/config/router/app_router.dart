import 'package:cinemapedia/presentation/screens/movies/home_screen.dart';
import 'package:cinemapedia/presentation/screens/movies/movie_screen.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_bottom_navigationbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';




  final appRouter = GoRouter(

    initialLocation: '/',
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (BuildContext context, GoRouterState state,
            StatefulNavigationShell navigationShell) {

          return CostomBottomNavigation(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[

          StatefulShellBranch(

            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, GoRouterState state,) =>
                    const HomeScreen(childView:HomeView() ,),
                routes: <RouteBase>[

                  GoRoute(
                     path: 'movie/:id',
                    builder: (context, state) {
                      final movieId = state.pathParameters['id'] ?? 'no-id';
                       return MovieScreen(movieId: movieId);
                    },

                  ),
                ],
              ),
            ],
          ),

 
          StatefulShellBranch(

            routes: <RouteBase>[
              GoRoute(
      
                path: '/favorites',
                builder: (BuildContext context, GoRouterState state) =>
                    const FavoritesViews(
 
                )
              ),
            ],
          ),

   
        ],
      ),
    ],
  );



