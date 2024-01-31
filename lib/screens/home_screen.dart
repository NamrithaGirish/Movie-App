import 'package:flutter/material.dart';
import '../models/movie_model.dart';
import '../widgets/movie_list_item.dart';
import '../screens/movie_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});//change here if

  @override
  Widget build(BuildContext context) {
    List<Movie> movies=Movie.movies;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace:ClipPath(
          clipper: _CustomClipper(),
          child : Container(
            height:150,
            width:MediaQuery.of(context).size.width,
            color: Colors.brown[400], 
            child: Center(
              child: Text(
                'EXPLORE',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white,fontWeight:FontWeight.bold)),
            )),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0,vertical:100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            RichText(
              text: TextSpan(
                style:Theme.of(context).textTheme.headlineSmall, 
                children:[
                  TextSpan(
                    text:"Featured ",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight:FontWeight.bold)),
                    const TextSpan(text:"Movies"),
                  
            ],
            ),
            ),
            const SizedBox(height: 20),
            for (final movie in movies) 
              
            
            InkWell( onTap :(){
              Navigator.push(
                context,MaterialPageRoute(builder: (context)=>MovieScreen(movie:movie)
                ),
              );
            },
              child: MovieListItem(
                imageUrl: movie.imagePath,
                name: movie.name,
                information: "${movie.year} | ${movie.catagory} | ${movie.duration.inMinutes}mins",
              ),
            )
          ],),
        )
      ),
    );
  }
}

class _CustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;

    var path = Path();
    path.lineTo(0,height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width,0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }

}