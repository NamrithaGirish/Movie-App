import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../models/movie_model.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
class MovieScreen extends StatelessWidget {
  final Movie movie;
  const MovieScreen({Key? key, required this.movie,}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        ..._buildBackGround(context,movie),
        _buildMovieInformation(context),
        Positioned(
          bottom: 50,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  primary: Colors.red,
                  //fixedSize: Size(MediaQuery.of(context).size.width*0.25,50),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                ),
                
                
                onPressed: () {}, child: Text('WISHLIST'),
                ),
                const SizedBox(width:10),
          ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20.0),
                  primary: Colors.white,
                  //fixedSize: Size(MediaQuery.of(context).size.width*0.25,50),
                shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                ),
                
                
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => _MoviePlayer(movie: movie)));
                }, child: Text('WATCH NOW', style: TextStyle(color:Colors.black)),
                )
            ],
                  ),
          ),
          ),
        ]
      ),
    );
  }
Positioned _buildMovieInformation(BuildContext context){
        return Positioned(
          bottom:150,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children:[
              Text(
                movie.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:FontWeight.bold),
              ),
              const SizedBox(height: 10,),
              Text(
                '${movie.year} | ${movie.catagory} | ${movie.duration.inHours}hrs',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
                ),
                const SizedBox(height: 10),
                RatingBar.builder(
                  initialRating:1.5,
                  minRating:1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  ignoreGestures: true,
                  itemCount: 5,
                  itemSize: 20,
                  unratedColor: Colors.white,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, index){
                    return const Icon(Icons.star,
                    color: Colors.amber,);
                  }, 
                onRatingUpdate: (rating){ },),
                const SizedBox(height: 20),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed dor elit sed vulputate. Ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget. Est placerat in egestas erat imperdiet sed euismod nisi porta. Adipiscing tristique risus nec feugiat in fermentum.',
                  maxLines: 8,
                  style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(height:1.75,color:Colors.white),
                )
            ],),
          ),
        );
}
  List<Widget> _buildBackGround(context,movie,){
  return [
    Container(
          height: double.infinity,
          color:  Colors.brown[400],
      ),
      Image.asset(movie.imagePath,
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.5,
      fit: BoxFit.cover,
      ),
      const Positioned.fill(
        child: DecoratedBox(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent,Colors.brown],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.3,0.5],
          ),
      ),
      ),
      ),
  ];
}
}

class _MoviePlayer extends StatefulWidget {
  const _MoviePlayer({
    Key?key, required this.movie,
  }) : super(key:key);

 final Movie movie;
  @override
  State<_MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<_MoviePlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  @override
  void initState(){
    super.initState();
    videoPlayerController=VideoPlayerController.asset(widget.movie.videoPath)
    ..initialize()
    .then((value) => {
      setState(() {})
    });
    chewieController = ChewieController(videoPlayerController: videoPlayerController,aspectRatio: 16/9);  }
  
  @override
  void dispose(){
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.transparent,
      body: SafeArea(child: Chewie(controller: chewieController,),),
    );
  }
}