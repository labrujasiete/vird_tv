import 'package:flutter/material.dart';
import 'package:vird_tv/models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({super.key, required this.movies, this.title});


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          if ( title != null )
            Padding(
              padding: const EdgeInsets.symmetric( horizontal: 20 ),
              child:  Text( title!, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

          const SizedBox(height: 10,),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _, int index) => _MoviePoster( movie: movies[index] ),
            ),
          ),  
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  
  final Movie movie;
  
  const _MoviePoster({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                  placeholder: const AssetImage('assets/no-image.jpg'), 
                  image: NetworkImage(movie.fullPosterImgPath),
                  width: 130,
                  height: 190,
                  fit: BoxFit.cover,
                ),
            ),
          ),

            const SizedBox(height: 5,),

            Text(
              movie.title, 
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              ),

        ],
      ),
    );
  }
}