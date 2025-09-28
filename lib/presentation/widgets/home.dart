import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:repaso/domain/entities/entities_people.dart'as model;
import 'package:repaso/presentation/provider/provider_Home.dart';
import 'package:repaso/presentation/provider/provider_favorites.dart';
import 'package:repaso/presentation/widgets/description_person.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index = 0;
  bool _search = false;
  String _query = "";
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProviderHome>(context, listen: false).getData();
    });
  }

  void _selectSearch(){
    setState(() => _search = !_search);
  }



  @override
  Widget build(BuildContext context) {
    final providerPeople = Provider.of<ProviderHome>(context);
    final favorites = Provider.of<ProviderFavorites>(context);
    final error = providerPeople.error;
    final peopleData = providerPeople.people;


  final filtter =
      peopleData!.results.where((b) {
        final q = _query.trim().toLowerCase();
        if (q.isEmpty) return true;
        final data = b.name.toLowerCase();
        return data.contains(q);
      }).toList();

  final filtterFavorites =
      favorites.favorites.where((b) {
        final q = _query.trim().toLowerCase();
        if(q.isEmpty) return true;
        final data = b.name.toLowerCase();
        return data.contains(q);
      }).toList();


    final pages = [
      if (error != null)
        const Center(child: Text("Ocurrió un error al cargar los datos"))
      else if (peopleData == null)
        const Center(child: CircularProgressIndicator())
      else
        ListView.builder(
          itemCount: filtter.length,
          itemBuilder: (context, index) {
            final person = filtter[index];
            return _CardView(person);
           /* return GestureDetector(
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
            );*/
          },
        ),
      favorites.favorites.isEmpty
      ? const Center(child: Text("AUN NO TIENES FAVORITOS"),)
     : ListView.builder(
        itemCount: filtterFavorites.length,
          itemBuilder: (context, index) {
          final person = filtterFavorites[index];
          return _CardView(person);
          }
      ),

      //const Center(child: Text()),
    ];

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          toolbarHeight: 75,
          actions: [IconButton(onPressed: _selectSearch,icon: Icon(Icons.search),color: Colors.white)],
        title: !_search
        ? Text("RICK AND MORTY", style: GoogleFonts.adamina(color: Colors.white))
        : TextField(
          controller: _controller,
          onChanged: (value) => setState(() =>  _query = value),
          textInputAction: TextInputAction.search,
          style: TextStyle(color: Colors.white),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            isDense: true,
            hintText: "Buscar",
            hintStyle: TextStyle(color: Colors.white),
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon:
              _query.isNotEmpty
              ? IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () {
                  _controller.clear();
                  setState(() => _query = "");
                },
              )
                  : null,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white)
            )
          ),


        ),
       /* ),
        ),*/
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

class _CardView extends StatefulWidget {
  final model.Result datos;


  const _CardView(this.datos);

  @override
  State<_CardView> createState() => _CardViewState();
}

class _CardViewState extends State<_CardView> {


  void _descriptionPerson(model.Result person){
    Navigator.push(context, MaterialPageRoute(builder: (context) => DescriptionPerson(dataPerson: person)));
  }



  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<ProviderFavorites>(context);
    final isFav = favorites.isFavorite(widget.datos);


    return GestureDetector(
      onTap: () => _descriptionPerson(widget.datos),
      child: Card(
        elevation: 4,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(padding: EdgeInsets.all(10),
        child:  Row(
            children: [
              ClipRect(
                child: Image.network(
                  widget.datos.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 20),
              Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.datos.name ?? ""),
                Text(widget.datos.species ?? "")
              ],
              ),
              ),
              SizedBox(width: 40),
              Column(
                children: [
                  FilledButton(onPressed: () => favorites.toogleFavorite(widget.datos),
                      style: FilledButton.styleFrom(backgroundColor: Colors.green
                      ),
                       child: Icon(
                      isFav ? Icons.star_outlined : Icons.star_border,
                      color: isFav ? Colors.yellow : Colors.yellow,
                    ),
                  )
                ],
              )
            ],
        )),
      ),
    );
  }
}
