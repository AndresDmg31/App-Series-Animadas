import 'package:flutter/material.dart';
import 'package:repaso/presentation/provider/provider_splash.dart';
import 'package:repaso/presentation/widgets/home.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final _controller = ProviderSplash();
  String _name = "";
  String _version = "";
  String _build = "";

  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  Future<void> _init() async {
    final (name,version,buil) = await _controller.loadData();
    if(!mounted) return;
    setState(() {
      _name = name;
      _version = version;
      _build = buil;
    });

    await Future.delayed(Duration(milliseconds: 2000));
    if(!mounted)return;
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Home()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
          Image.asset("assets/logo.png"),
          SizedBox(height: 10),
          Text(_name,style: GoogleFonts.adamina(fontWeight: FontWeight.bold,fontSize: 30),),
            SizedBox(height: 5),
            Text("Nueva aplicacion para practicar",style: GoogleFonts.adamina(fontSize: 20),),
            SizedBox(height: 10),
          Text(_version),
            SizedBox(height: 5),
            Text(_build),
          ],
        ),
      ),
    );
  }
}

