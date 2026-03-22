import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islamicapp/features/Hadith/cubit/hadithCubit.dart';
import 'package:islamicapp/features/Hadith/view/favourites.dart';
import 'package:islamicapp/features/Hadith/view/hadithView.dart';
import 'package:islamicapp/features/azkaar/cubit/azkaarCubit.dart';
import 'package:islamicapp/features/azkaar/view/azkaarView.dart';
import 'package:islamicapp/features/home/view/homeView.dart';

import 'package:islamicapp/features/prayer/view/prayerTimesView.dart';
import 'package:islamicapp/features/sibhaDetails/view/sibhaDetailsView.dart';
import 'package:islamicapp/shared/view/root.dart';
import 'package:islamicapp/shared/view/splash.dart';

import '../features/profile/view/ProfileView.dart';
import '../features/qibla/view/qiblaView.dart';
import '../features/quran/view/qurabLibrary.dart';

import '../features/sibha/bloc/sibhaCubit.dart';
import '../features/sibha/view/sibhaView.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();

  static final router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,

    redirect: (context, state) {
      final isSplash = state.matchedLocation == 'splash';

      if (isSplash) {
        return '/Homeview';
      }

      return null;
    },

    routes: [
      GoRoute(path: '/splash', builder: (context, state) => const splash()),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return root(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/Homeview',
                builder: (context, state) => const homeView(),
                routes: [
                  GoRoute(
                    path: 'prayerTimesview',
                    builder: (context, state) => prayerTimesview(),
                  ),

                  GoRoute(
                    path: 'azkaarView',
                    builder: (context, state) => BlocProvider(
                      create: (context) => azkaarCubit(),
                      child: const azkaarView(),
                    ),
                  ),

                  ShellRoute(
                    builder: (context, state, child) {
                      return BlocProvider(
                        create: (context) => hadithCubit(),
                        child: child,
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'hadithView',
                        builder: (context, state) => hadithView(),
                        routes: [
                          GoRoute(
                            path: 'favouritesView',
                            builder: (context, state) => favouritesView(),
                          ),
                        ],
                      ),
                    ],
                  ),

                  GoRoute(
                    path: 'qiblaView',
                    builder: (context, state) => qiblaView(),
                  ),
                  ShellRoute(
                    builder: (context, state, child) {
                      return BlocProvider(
                        create: (_) => SibhaCubit(),
                        child: child,
                      );
                    },

                    routes: [
                      GoRoute(
                        path: 'Sibhaview',
                        builder: (context, state) => Sibhaview(),
                        routes: [
                          GoRoute(
                            path: 'Sibhadetailsview',
                            builder: (context, state) => Sibhadetailsview(),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // GoRoute(
                  //   path: 'Sibhaview',
                  //   builder: (context, state) => BlocProvider(
                  //     create: (context) => SibhaCubit(),
                  //
                  //     child: Sibhaview(),
                  //   ),
                  //   routes: [
                  //     GoRoute(
                  //       path: '/Sibhadetailsview',
                  //       builder: (context, state) => Sibhadetailsview(),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/Quranview',
                builder: (context, state) {
                  // return Quranview(surahNumber: id);
                  return Quranview();
                },
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/prayerTimesview',
                builder: (context, state) => const prayerTimesview(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/qiblaView',
                builder: (context, state) => const qiblaView(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/Profileview',
                builder: (context, state) => const Profileview(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
