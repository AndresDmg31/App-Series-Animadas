import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:repaso/domain/entities/entities_people.dart'as model;
import 'package:repaso/presentation/provider/provider_Home.dart';
import 'package:repaso/presentation/widgets/description_person.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProviderHome>(context, listen: false).getData();
    });
  }

  void _descriptionPerson(model.Result person){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPerson(dataPerson: person)));
  }


  @override
  Widget build(BuildContext context) {
    final providerPeople = Provider.of<ProviderHome>(context);
    final error = providerPeople.error;
    final peopleData = providerPeople.people;

    final pages = [
      if (error != null)
        const Center(child: Text("Ocurrió un error al cargar los datos"))
      else if (peopleData == null)
        const Center(child: CircularProgressIndicator())
      else
        ListView.builder(
          itemCount: peopleData.results.length,
          itemBuilder: (context, index) {
            final person = peopleData.results[index];
            return GestureDetector(
              onTap: () => _descriptionPerson(person),
              child: ListTile(
                  leading: Image.network(
                    person.image,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(person.name),
                  subtitle: Text(person.status),
                  trailing: Text(person.species),
                ),
            );

          },
        ),
      const Center(child: Text("Favoritos")),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("RICK AND MORTY", style: GoogleFonts.adamina(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(child: pages[_index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.list), label: "Lista"),
          NavigationDestination(icon: Icon(Icons.stars), label: "Favoritos"),
        ],
      ),
    );
  }
}
