import 'package:flutter/material.dart';
import 'package:movie_plex/core/constants/all_provider.dart';
import 'package:movie_plex/core/constants/app_theme.dart';
import 'package:movie_plex/core/utils/theme_provider.dart';
import 'package:movie_plex/features/home/screen/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => ThemeProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: AllProviders().providers,
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'MoviePlex',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   const MyHomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final themeProvider = Provider.of<ThemeProvider>(context);
//     final textTheme = Theme.of(context).textTheme;

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Cinema Theme Preview'),
//         actions: [
//           IconButton(
//             icon: Icon(themeProvider.isDarkMode ? Icons.sunny : Icons.dark_mode),
//             onPressed: () => themeProvider.toggleTheme(),
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Current Theme Info
//             Center(
//               child: Text(
//                 'Current Theme: ${themeProvider.isDarkMode ? "Dark" : "Light"}',
//                 style: textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 24),

//             // Movie Ticket Style Color Showcase
//             Wrap(
//               spacing: 16,
//               runSpacing: 16,
//               children: [
//                 _buildColorCard('Primary', AppColors.lightPrimary, Colors.white),
//                 _buildColorCard('Secondary', AppColors.lightSecondary, Colors.black87),
//                 _buildColorCard('Accent', AppColors.lightAccent, Colors.white),
//                 _buildColorCard('Background', AppColors.lightBackground, Colors.black87),
//                 _buildColorCard('Surface', AppColors.lightBackground, Colors.black87),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Text Samples
//             Text('Headline Large', style: textTheme.headlineLarge),
//             const SizedBox(height: 8),
//             Text('Headline Medium', style: textTheme.headlineMedium),
//             const SizedBox(height: 8),
//             Text('Body Large', style: textTheme.bodyLarge),
//             const SizedBox(height: 8),
//             Text('Body Medium', style: textTheme.bodyMedium),
//             const SizedBox(height: 24),

//             // Buttons Preview
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text('Book Ticket'),
//                 ),
//                 OutlinedButton(
//                   onPressed: () {},
//                   style: OutlinedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                   ),
//                   child: const Text('Watch Trailer'),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 24),

//             // Toggle Theme Button
//             Center(
//               child: ElevatedButton.icon(
//                 onPressed: () => themeProvider.toggleTheme(),
//                 icon: Icon(themeProvider.isDarkMode ? Icons.sunny : Icons.dark_mode),
//                 label: Text(
//                   themeProvider.isDarkMode ? 'Switch to Light Theme' : 'Switch to Dark Theme',
//                 ),
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Helper method to create color cards
//   Widget _buildColorCard(String title, Color color, Color textColor) {
//     return Container(
//       width: 150,
//       height: 100,
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: const Offset(2, 4))],
//       ),
//       alignment: Alignment.center,
//       child: Text(
//         title,
//         style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
//       ),
//     );
//   }
// }
