import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';
import 'package:peliculas/src/providers/peliculas_provider.dart';


class DataSearch extends SearchDelegate{

  final peliculasProvider = new PeliculasProvider();


  final peliculas = [
    'Spider_man',
    'Aquaman',
    'Batman',
    'Shazam!',
    'Ironman',
    'Capitan America',
  ];

  final peliculasRecientes =[
    'Spider_man',
    'Capitan America',
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
      // Acciones de nuestro AppBar
      return [
        IconButton(
          icon: Icon(Icons.clear), 
          onPressed: (){
            query = '';
          },
        ),
      ];
    }
  
    @override
    Widget buildLeading(BuildContext context) {
      // Icono a la izquierda del AppBar 
      return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, 
          progress: transitionAnimation,
        ), 
        onPressed: (){
          close(context, null);
        },
      );
    }
  
    @override
    Widget buildResults(BuildContext context) {
      // Crea los resultados que vamos a mostrar 
      return Container();
    }
  
    @override
    Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen cuando la persona escribe 

      if (query.isEmpty) {
        return Container();
      }
      return  FutureBuilder(
        future: peliculasProvider.buscarPelicula(query),
        builder: (BuildContext context, AsyncSnapshot<List<Pelicula>> snapshot) {
          if (snapshot.hasData) {

            final peliculas = snapshot.data;

            return ListView(
              children: peliculas.map((pelicula){
                return ListTile(
                  leading: FadeInImage(
                    image: NetworkImage(pelicula.getPosterImg()),
                    placeholder: AssetImage('assets/img/no-image.jpg'),
                    fit: BoxFit.fill,
                    width: 50.0,
                  ),
                  title: Text(pelicula.title, style: Theme.of(context).textTheme.subtitle1, overflow: TextOverflow.ellipsis,),
                  subtitle: Text(pelicula.originalTitle, style:Theme.of(context).textTheme.bodyText2, overflow: TextOverflow.ellipsis),
                  onTap: (){
                    close(context, null);
                    pelicula.uniqueId = '';
                    Navigator.pushNamed(context, 'detalle', arguments: pelicula);
                  },
                );
              }).toList(),
            ); 
          } else{
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      );
  }

     

}