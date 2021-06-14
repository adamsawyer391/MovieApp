import 'package:flutter/material.dart';
import 'package:movies/model/movie.dart';

class MovieDetailsThumbnail extends StatelessWidget {

  final String url;

  MovieDetailsThumbnail(this.url);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3,
              // height: 190,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(url),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Icon(Icons.play_circle_outline, size: 100, color: Colors.white),
          ],
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter
              )
          ),
          height: 100,
        )
      ],
    );
  }
}

class MovieDetailsHeaderWithPoster extends StatelessWidget {

  final Movie movie;

  MovieDetailsHeaderWithPoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: <Widget>[
          MoviePoster(movie.images[2].toString()),
          SizedBox(
            width: 16,
          ),
          Expanded(child: (MovieDetailsHeader(movie)))
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {

  final String url;

  MoviePoster(this.url);

  @override
  Widget build(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.circular(10));
    return Card(
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Container(
          width: MediaQuery.of(context).size.width /4,
          height: 160,
          decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
          ),
        ),
      ),
    );
  }
}

class MovieDetailsHeader extends StatelessWidget {

  final Movie movie;

  MovieDetailsHeader(this.movie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("${movie.year}. ${movie.genre}".toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w400,
              color: Colors.indigoAccent
          ),),
        Text("${movie.title}", style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 32
        ),),
        Text.rich(TextSpan(style: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w300,
        ), children: <TextSpan>[
          TextSpan(
              text: movie.plot
          ),
          TextSpan(
              text: "  More...",
              style: TextStyle(
                color: Colors.indigoAccent,
                fontSize: 14,
              )
          )
        ]))
      ],
    );
  }
}

class MovieDetailsCast extends StatelessWidget {

  final Movie movie;

  MovieDetailsCast(this.movie);

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: <Widget>[
          MovieField("Cast", movie.actors),
          MovieField("Directors", movie.director),
          MovieField("Awards", movie.awards)
        ],
      ),
    );
  }
}

class MovieField extends StatelessWidget {

  final String field;
  final String value;

  MovieField(this.field, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("$field :", style: TextStyle(
            color: Colors.black38,
            fontSize: 12,
            fontWeight: FontWeight.w300
        ),),
        Expanded(
          child: Text(value, style: TextStyle(
              color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300
          ),),
        )
      ],
    );
  }
}

class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailExtraPosters extends StatelessWidget {

  final List<String> posters;

  MovieDetailExtraPosters(this.posters);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 0, right: 0, bottom: 0),
          child: Text("More Movie Posters".toUpperCase(),
            style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),),
        ),
        Container(
          height: 170,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(posters[index]), fit: BoxFit.cover),
                ),
              ),
            ),
            separatorBuilder: (context, index) => SizedBox(width: 8,),
            itemCount: posters.length,
          ),
        )
      ],
    );
  }
}