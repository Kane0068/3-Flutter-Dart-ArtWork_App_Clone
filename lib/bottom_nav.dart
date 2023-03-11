import 'package:flutter/material.dart';
import 'package:flutter_artwork/home_page.dart';

class ArtWorkBottomNavBar extends StatefulWidget {
  final String username;
  const ArtWorkBottomNavBar({Key? key, required this.username}) : super(key: key);

  @override
  State<ArtWorkBottomNavBar> createState() => _ArtWorkBottomNavBarState();
}

class _ArtWorkBottomNavBarState extends State<ArtWorkBottomNavBar> {
  int _currentIndex = 0;
  Widget getWidgets(index){
    switch(index){
      case 0:
        return HomePage(name : widget.username);
      case 1:
        return Center(child: Text("Report"),);
      case 2:
        return Center(child: Text(""),);
      case 3:
        return Center(child: Text("favorite"),);
      case 4:
        return Center(child: Text("Profile"),);

    }
    return Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromARGB(255, 21, 129, 6),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Color.fromARGB(255, 234, 170, 8),
        unselectedItemColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "report",
          ),
          BottomNavigationBarItem(
            icon: Icon(null),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "profile",
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          height: 70,
          width:70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
              gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    Color.fromARGB(255, 33, 231, 3),
                    Color.fromARGB(255, 21, 129, 6),
                    Color.fromARGB(255, 15, 47, 10)
                  ]
              )
          ),
          child: Icon(Icons.add,
          color: Colors.white,)
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            colors: [
                Color.fromARGB(255, 33, 231, 3),
                Color.fromARGB(255, 21, 129, 6),
                Color.fromARGB(255, 15, 47, 10)
            ]
          )
        ),
        child: getWidgets(_currentIndex),//--------------------------------------------->>>>>>>>>>>>>>>>>>
      ),
    );
  }
}
