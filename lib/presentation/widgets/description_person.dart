import 'package:flutter/material.dart';
import 'package:repaso/domain/entities/entities_people.dart'as model;
import 'package:google_fonts/google_fonts.dart';

class DescriptionPerson extends StatelessWidget {
  final model.Result dataPerson;
  const DescriptionPerson({required this.dataPerson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PERSONAJE", style: GoogleFonts.adamina(fontSize: 20,color: Colors.white)),
      backgroundColor: Colors.green,
      iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(onPressed:() {Navigator.pop(context);}, icon: Icon(Icons.list_outlined)),
      actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
      ),
      body: SafeArea(child: Center(
      child: Column(
        children: [
          SizedBox(height: 20),
          Image.network(
            dataPerson.image,
            height: 250,
            width: 250,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 25),
          Text(dataPerson.name,style: GoogleFonts.adamina(fontSize: 25,fontWeight: FontWeight.bold)
          ),
          SizedBox(height: 10
          ),
          Text("Especie:  " + dataPerson.species, style: GoogleFonts.acme(fontSize: 20),
          ),
          SizedBox(height: 10
          ),
          Text("Estado:  " + dataPerson.status, style: GoogleFonts.acme(fontSize: 20)
          ),
          SizedBox(height: 10
          ),
          Text("Genero:  " + dataPerson.gender, style: GoogleFonts.acme(fontSize: 20)
          ),
        ],
      ),
      )
      ),
    );
  }
}
