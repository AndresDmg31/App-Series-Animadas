import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repaso/presentation/provider/provider_Home.dart';
import 'package:repaso/presentation/provider/provider_favorites.dart';
import 'package:repaso/presentation/widgets/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => ProviderHome()),
      ChangeNotifierProvider(create: (_) => ProviderFavorites())
    ],

      child: MaterialApp(
        title: "Prueba App",
        debugShowCheckedModeBanner: false,

        initialRoute: "/",
        routes: {
          "/": (_) => const Splash()
        },
      ),
    );
  }
}




