import 'package:movie_plex/core/utils/theme_provider.dart';
import 'package:movie_plex/features/home/providers/homeProvider.dart';
import 'package:movie_plex/features/movie_detail/providers/detailProvider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class AllProviders {
  List<SingleChildWidget> providers = [
    ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
    ChangeNotifierProvider<Homeprovider>(create: (_) => Homeprovider()),
    ChangeNotifierProvider<SensorProvider>(create: (_) => SensorProvider()),
  ];
}
