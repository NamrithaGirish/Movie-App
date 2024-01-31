class Movie {
  final String name;
  final String imagePath;
  final String videoPath;
  final String catagory;
  final int year;
  final Duration duration;

  const Movie({
    required this.name, 
    required this.imagePath,
    required this.videoPath, 
    required this.catagory, 
    required this.year, 
    required this.duration});
  static List<Movie> movies =[

    const Movie(
      name:"Premam",
      imagePath:"assets/image1.jpg",
      videoPath:"assets/video1.mp4",
      catagory:"Romance",
      year: 2017,
      duration: Duration(hours: 2,minutes: 22),
    ),
    const Movie(
      name:"Thondimuthalum Driksakshiyum",
      imagePath:"assets/image2.jpg",
      videoPath:"assets/video1.mp4",
      catagory:"Drama",
      year: 2019,
      duration: Duration(hours: 3,minutes: 10),
    ),
    const Movie(
      name:"Athiran",
      imagePath:"assets/image3.jpg",
      videoPath:"assets/video1.mp4",
      catagory:"Thriller",
      year: 2019,
      duration: Duration(hours: 2,minutes: 30),
    ),
  ];
}