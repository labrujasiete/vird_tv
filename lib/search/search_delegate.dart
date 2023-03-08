

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vird_tv/models/movie.dart';
import 'package:vird_tv/providers/movies_provider.dart';

class MoviesSearchDelegate extends SearchDelegate {



  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar Pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear_rounded),
        onPressed: () => query = '',
        ), 
        
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null), 
      );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }


  Widget _emptyContainer(){
    return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.black38, size: 130,),
        ),
      );
  }


  @override
  Widget buildSuggestions(BuildContext context) {
    if( query.isEmpty ){
      return _emptyContainer();
    }

    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);

    
    
    return FutureBuilder(
      future: moviesProvider.searchMovies(query),
      builder: ( _, AsyncSnapshot<List<Movie>> snapshot) {
        if(!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: ( _, int index) => _MovieItem(movies[index]),
          );
        }
      );



  }

}



class _MovieItem extends StatelessWidget {

  final Movie movie;

  const _MovieItem( this.movie );

  @override
  Widget build(BuildContext context) {

    movie.heroId = 'search-${movie.id}';

    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: FadeInImage(
          image: NetworkImage( movie.fullPosterImgPath ),
          placeholder: AssetImage('assets/no-image.jpg'),
          width: 50,
          fit: BoxFit.contain,
          ),
      ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: ( ) {
          Navigator.pushNamed(context, 'details', arguments: movie);
        },
    );
  }
}