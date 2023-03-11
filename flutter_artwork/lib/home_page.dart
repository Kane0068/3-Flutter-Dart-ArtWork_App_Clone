import 'package:flutter/material.dart';
import 'package:flutter_artwork/login.dart';

class HomePage extends StatefulWidget {
  final String name ;
  const HomePage({Key? key, required this.name}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List categories = [
    "Trending",
    "Music",
    "Sports",
    "Utility",
  ];

  List<Map<String, dynamic>> categoriesDetails = [
    {
      "image": "art4.jpg",
      "profile": "profile1.png",
      "name": "eduardo",
    },
    {
      "image": "art2.jpg",
      "profile": "profile2.png",
      "name": "gonzales",
    }
  ];

  List<Map<String, dynamic>> lattestCollection = [
    {
      "image": "art3.jpg",
      "profile": "profile3.png",
      "name": "romario",
      "price" : "£400",
    },
    {
      "image": "art1.jpg",
      "profile": "profile3.png",
      "name": "ronaldo",
      "price" :"£450" ,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 33, 231, 3),
                  Color.fromARGB(255, 21, 129, 6),
                  Color.fromARGB(255, 15, 47, 10)
                ]),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                height: 130,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 33, 231, 3),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(15))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    artWorkAppBar(),
                    searchTextFormField(),
                  ],
                ),
              ),
              titlesRow("Categories"),
              Container(
                height: 40,
                // color: Colors.white,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: 20),
                      alignment: Alignment.center,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 33, 231, 3),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.white10)),
                      child: Text(
                        categories[index],
                        style: TextStyle(fontSize: 13),
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoriesDetails.length,
                  itemBuilder: (context, index) {
                    return categoryGallery(index);
                  },
                ),
              ),
              titlesRow("Latest Collections"),
              Container(
                margin: EdgeInsets.only(left: 20),
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: lattestCollection.length,
                  itemBuilder: (context,index){
                    return Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(right: 10),
                      height: 110,
                      width: 230,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color.fromARGB(255, 33, 231, 3),
                        border: Border.all(width: 1,color: Colors.white)
                      ),
                      child: latestCollectionDetails(index),
                    );
                  },
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }

  Widget latestCollectionDetails(int index){
    final latest = lattestCollection[index];
    return Row(
      children: [
        ClipPath(
          clipper: customClipperImage(),
          child: Container(
            width: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  "assets/${latest["image"]}"
                ),
                fit: BoxFit.cover
              )
            ),
          ),
        ),
        SizedBox(width: 10,),
        Expanded(child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.teal,
                      radius: 8,
                      backgroundImage: AssetImage(
                          "assets/${latest["profile"]}"
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text(latest["name"],
                    style: TextStyle(
                      fontSize: 15,
                    ),)
                  ],
                ),
                SizedBox(height: 5,),
                Text(
                  latest["price"],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
                child: backIconDesing())
          ],
        ))
      ],
    );
  }

  Widget categoryGallery(int index) {
    final category = categoriesDetails[index];
    return ClipPath(
      clipper: CustomClipperDesing(),
      child: Container(
        alignment: Alignment.bottomCenter,
        margin: EdgeInsets.only(right: 15),
        width: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("assets/${category["image"]}"),
            fit: BoxFit.cover
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 50,
          width: 180,
          color: Colors.tealAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.teal,
                    radius: 13,
                    backgroundImage: AssetImage(
                      "assets/${category["profile"]}"
                    ),

                  ),
                  SizedBox(width: 5,),
                  Text(
                    category["name"],

                  ),
                ],
              ),
              backIconDesing(),
            ],
          ),
        ),
      ),
    );
  }
  Widget backIconDesing() => ClipPath(
    clipper: CustomClipperBox(

    ),
    child: Container(
      height: 20,
      width: 40,
      decoration: BoxDecoration(
        border: Border.all(width: 2,color: Color.fromARGB(255, 33, 231, 3),
        ),
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 33, 231, 3),
            Color.fromARGB(255, 21, 129, 6),
            Color.fromARGB(255, 15, 47, 10)

          ]
        ),
      ),
      child: Icon(Icons.arrow_forward,
      color: Colors.white,
      size: 13,),
    ),
  );

  Widget titlesRow(String title) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20),
            ),
            Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 20,
            )
          ],
        ),
      );
  Widget searchTextFormField() => TextField(
        cursorColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.001),
        //***********textstyle***********
        style: TextStyle(
          color: Color.fromARGB(255, 24, 54, 10),
          fontSize: 17,
        ),
        decoration: InputDecoration(
            hintText: "Search...",
            hintStyle: TextStyle(
              fontSize: 14,
              color: Colors.white,
            ),
            isDense: true,
            filled:
                true, //**************************************arkaplan içini doldur
            fillColor: Color.fromARGB(255, 102, 229, 45).withOpacity(0.2),
            //****************border**************************>>>>>>>>>>>>>>>>>>>>>>>>>>>> kenarlıklar
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1, color: Colors.white10),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
            suffixIcon: Icon(
              Icons.search,
              size: 20,
              color: Colors.white,
            )),
      );

  Widget artWorkAppBar() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 217, 9),
                radius: 18,
                backgroundImage: AssetImage("assets/profile2.png"),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Welcome , ${widget.name}",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
            ],
          ),
          GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ArtWorkLogin()));
              },
              child: Icon(
                Icons.logout,
                size: 18,
                color: Colors.white,
              ))
        ],
      );
}
class customClipperImage extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;

    path.moveTo(0, height - 60);
    path.lineTo(0, height);
    path.lineTo(width-20, height);
    path.lineTo(width, height-20);
    path.lineTo(width, 0);
    path.lineTo(width - 60, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipperDesing extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;

    path.moveTo(0, height - 180);
    path.lineTo(0, height);
    path.lineTo(width, height);
    path.lineTo(width, 0);
    path.lineTo(width - 140, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class CustomClipperBox extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    double height = size.height;
    double width = size.width;

    path.moveTo(0, height - 8);
    path.lineTo(0, height);
    path.lineTo(width-10, height);
    path.lineTo(width, height-12);
    path.lineTo(width, 0);
    path.lineTo(width - 30, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
