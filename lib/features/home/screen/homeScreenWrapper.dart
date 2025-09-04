import 'package:flutter/material.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/home/screen/home_screen.dart';
import 'package:movie_plex/features/home/screen/shimmer_function/shimmer%20effect%20testing%20home.dart';
import 'package:provider/provider.dart';

// this screen will decide whether to show shimmer effect or actual home screen based on loading state

class HomePageWrapper extends StatefulWidget {
   HomePageWrapper({super.key});

  @override
  State<HomePageWrapper> createState() => _HomePageWrapperState();
}

class _HomePageWrapperState extends State<HomePageWrapper> {
  @override
  void initState() {
    super.initState();

    // Delay shimmer for 5 seconds currently it's dummy later we'll make it dynamic when we'll use api data
 Provider.of<Homeprovider>(context, listen: false).loadMovies();

    Future.delayed( Duration(seconds: 5), () {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Provider.of<Homeprovider>(context, listen: false).setLoading(false);
          Provider.of<Homeprovider>(context, listen: false).setAppOpenedFirstTime(false);

        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<Homeprovider>(context);

    return homeProvider.isLoading && homeProvider.appOpenedFirstTime
        ?  ShimmerHomePage()
        :  HomePage();
  }
}
