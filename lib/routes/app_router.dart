import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/home_screen.dart';
import '../screens/activity_list_screen.dart';
import '../screens/activity_detail_screen.dart';
import '../screens/add_edit_activity_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/profile_screen.dart';

import '../providers/activity_provider.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/activities',
      builder: (context, state) => const ActivityListScreen(),
    ),
    GoRoute(
      path: '/activity-detail/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ActivityDetailScreen(activityId: id);
      },
    ),


    GoRoute(
      path: '/add-edit',
      builder: (context, state) {
        // Ambil ID dari `extra` waktu ngedit
        final id = state.extra as String?;
        final provider = Provider.of<ActivityProvider>(context, listen: false);

        final activity = id != null ? provider.findById(id) : null;

        return AddEditActivityScreen(activity: activity);
      },
    ),

    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoriteScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
  ],
);