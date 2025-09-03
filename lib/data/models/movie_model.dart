class Movie_Model {
  final String img;
  final String title;
  final List<String> genre;
  final String description;
  final int price;

  final List<String> actorList;
  Movie_Model({
    required this.description,
    required this.genre,
    required this.img,
    required this.title,
    required this.price,
    required this.actorList,
  });

  static List<Movie_Model> posterList = [
    Movie_Model(
      price: 20,
      description:
          'Unravel the mystery of a city in middle U.S.A. that imprisons everyone who enters. As the residents struggle to maintain a sense of normality and seek a way out, they must also survive the threats of the surrounding forest.',
      genre: ['Horror', 'Thriller', 'Mystery', 'Drama'],
      img: 'assets/img/from-season-3.jpg',
      title: 'From - Season 3',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'A family saga with a supernatural twist, set in a German town where the disappearance of two young children exposes the relationships among four families.',
      genre: ["Crime", "Drama", "Mystery", "Sci-Fi", "Thriller"],
      img: 'assets/img/dark.jpg',
      title: 'Dark',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'Vikings transports us to the brutal and mysterious world of Ragnar Lothbrok, a Viking warrior and farmer who yearns to explore--and raid--the distant shores across the ocean.',
      genre: ["Action", "Adventure", "Drama"],
      img: 'assets/img/vikings.jpg',
      title: 'Vikings',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'After being struck by lightning, Barry Allen wakes up from his coma to discover he\'s been given the power of super speed, becoming the Flash, and fighting crime in Central City.',
      genre: ["Action", "Adventure", "Drama", "Fantasy", "Sci-Fi"],
      img: 'assets/img/flash.jpg',
      title: 'The Flash',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'On the run from a drug deal gone bad, brilliant college dropout Mike Ross finds himself working with Harvey Specter, one of New York City\'s best lawyers.',
      genre: ["Drama", "Comedy", "Romance"],
      img: 'assets/img/suits.jpg',
      title: 'Suits',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'The story follows a high school boy named Arisu and other youths who are transported to a devastated alternate world. Trapped, they are forced to play a deadly game of survival.',
      genre: ["Action", "Animation", "Fantasy", "Thriller", "Adventure"],
      img: 'assets/img/alice-in-borderlands.jpg',
      title: 'Alice in Borderlands',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
    Movie_Model(
      price: 20,
      description:
          'Guts, a wandering mercenary, joins the Band of the Hawk after being defeated in a duel by Griffith, the group\'s leader and founder. Together, they dominate every battle, but something menacing lurks in the shadows.',
      genre: ["Action", "Animation", "Adventure", "Thriller", "Fantasy", "Romance", "Drama"],
      img: 'assets/img/berserk.jpg',
      title: 'Berserk',
      actorList: [
        'assets/actorImg/p1.jpeg',
        'assets/actorImg/p2.jpeg',
        'assets/actorImg/p3.jpeg',
        'assets/actorImg/p4.jpeg',
        'assets/actorImg/p5.jpeg',
      ],
    ),
  ];
}
