import 'package:flutter/material.dart';
import 'package:vird_tv/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final String movie =  ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate([
              _PosterAndTitle(),
              _Overview(),
              _Overview(),
              _Overview(),
              const CastingCards(),
            ])
            ),
        ],
      ),
    );
  }
}




class _CustomAppBar extends StatelessWidget {

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
          padding: const EdgeInsets.only(bottom: 5),
          child: const Text(
            'movie.title',
            style: TextStyle( fontSize: 16 ),
          ),
        ),
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'), 
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),

    );
  }
}

class _PosterAndTitle extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: const FadeInImage(
              placeholder: AssetImage('assets/no-image.jpg'),
              image: NetworkImage('https://via.placeholder.com/200x300'),
              height: 150,
            ),
          ),
          
          const SizedBox(width: 20,),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('movie.title', style: Theme.of(context).textTheme.headlineSmall, overflow: TextOverflow.ellipsis, maxLines: 2,),
              Text('movie.originaltitle', style: Theme.of(context).textTheme.titleMedium, overflow: TextOverflow.ellipsis, maxLines: 2,),
            
              Row(
                children: [
                  const Icon(Icons.star_outline, size: 15, color: Colors.grey),
                  Text('movie.voteAverage', style: Theme.of(context).textTheme.bodySmall,)
                ],
              )

            ],
          )

        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        'Culpa consequat duis eu nulla consequat ullamco ullamco officia incididunt exercitation voluptate sint tempor. Laborum nisi veniam ea sit sit exercitation. Esse excepteur magna ipsum duis veniam ad in. Ad duis proident sint et ullamco ea esse nulla elit duis velit ullamco. Adipisicing in laboris exercitation amet ut ut eu exercitation eu esse fugiat reprehenderit. Excepteur do dolore esse consequat pariatur deserunt cupidatat. Excepteur aliquip occaecat ipsum dolore culpa cillum minim.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      );
  }
}