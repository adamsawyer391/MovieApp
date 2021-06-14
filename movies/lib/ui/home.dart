

import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';
import 'package:movies/ui/movie_ui/movie_ui.dart';

class MovieListView extends StatelessWidget {

  final List<Movie> movieList = Movie.getMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Movies!"),
        backgroundColor: Colors.black45,
      ),
      backgroundColor: Colors.blueGrey.shade900,
      body: ListView.builder(
        itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: <Widget>[
              movieCard(movieList[index], context),
              Positioned(
                top: 15.0,
                  left: 10.0,
                  child: movieImage(movieList[index].images[0])
              ),
            ],
          );
          return movieCard(movieList[index], context);
      }),
    );
  }

  Widget movieCard(Movie movie, BuildContext context){
    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: 60),
        width: MediaQuery.of(context).size.width,
        height: 130.0,
        child: Card(
          color: Colors.black45,
          child: Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 50.0,
              right: 0.0
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0,
                        top: 5.0,
                        right: 0.0,
                        bottom: 5.0),
                        child: Text(movie.title, style: titleStyle()),
                      ),

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Rating: ${movie.imdbRating} / 10", style: TextStyle(
                        color: Colors.white
                      ),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Released: ${movie.released}", style: TextStyle(
                        color: Colors.white
                      ),),
                      Text(movie.length, style: TextStyle(
                        color: Colors.white
                      ),),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(movie.rated, style:
                      TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.red
                      ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onTap: ()=>{
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => MovieListViewDetails(movie))
        )
      },
    );
  }

  Widget movieImage(String imageUrl){
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover
        )
      ),
    );
  }

  TextStyle titleStyle(){
    return TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
        color: Colors.green
    );
  }

}

class MovieListViewDetails extends StatelessWidget {

  final Movie movie;
  MovieListViewDetails(this.movie); // ignore: non_constant_identifier_names

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      body: ListView(
        children: <Widget>[
          MovieDetailsThumbnail(movie.images[1]),
          MovieDetailsHeaderWithPoster(movie),
          HorizontalLine(),
          MovieDetailsCast(movie),
          HorizontalLine(),
          MovieDetailExtraPosters(movie.images)
        ],
      ),
    );
  }
}