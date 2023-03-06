import 'package:flutter/material.dart';
import 'package:vird_tv/models/models.dart';
import 'package:vird_tv/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final Movie movie =  ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movie ),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle( movie ),
              _Overview( movie ),
              _Overview( movie ),
              _Overview( movie ),
              //CastingCards( movie.id ),
            ])
            ),
        ],
      ),
    );
  }
}




class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar( this.movie );

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          padding: const EdgeInsets.only(bottom: 5, left: 20, right: 20),
          child: Text(
            textAlign: TextAlign.center,
            movie.title,
            style: TextStyle( fontSize: 16 ),
          ),
        ),
        background: FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage(movie.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle( this.movie );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movie.fullPosterImgPath),
              height: 150,
            ),
          ),
          
          const SizedBox(width: 20,),

          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(movie.title, style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
                Text(movie.originalTitle, style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2,),
              
                Row(
                  children: [
                    const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                    Text('${movie.voteAverage}', style: Theme.of(context).textTheme.bodySmall,)
                  ],
                )
          
              ],
            ),
          )

        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;
  
  const _Overview( this.movie );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
          movie.overview,
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
  }
}