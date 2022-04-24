import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graphql/auth/ui/login_page.dart';
import 'package:flutter_graphql/auth/ui/signup_page.dart';
import 'package:flutter_graphql/main.dart';
import 'package:flutter_graphql/screens/badges/ui/badges_page.dart';
import 'package:flutter_graphql/screens/dashboard/dashboard.dart';
import 'package:flutter_graphql/screens/error_page.dart';
import 'package:flutter_graphql/screens/get_continent/ui/continent_page.dart';
import 'package:flutter_graphql/screens/get_countries/ui/countries_page.dart';
import 'package:flutter_graphql/screens/notifications/ui/notification_page.dart';
import 'package:flutter_graphql/screens/polls/ui/poll_page.dart';
import 'package:flutter_graphql/screens/searchable_dropdown/ui/searchable_dropdown_page.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyApp());
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => DashboardPage());
      case '/continent':
        return MaterialPageRoute(builder: (_) => ContinentPage());
      case '/countries':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => CountriesPage(continent: args));
        }
        return MaterialPageRoute(builder: (_) => ErrorPage());
      case '/poll':
        return MaterialPageRoute(builder: (_) => PollPage());
      case '/badges':
        return MaterialPageRoute(builder: (_) => BadgesPage());
      case '/timerNotification':
        return MaterialPageRoute(builder: (_) => TimerNotification());
      case '/searchableDropdown':
        return MaterialPageRoute(builder: (_) => SearchableDropdownPage());
      default:
        return MaterialPageRoute(builder: (_) => ErrorPage());
    }
  }
}
