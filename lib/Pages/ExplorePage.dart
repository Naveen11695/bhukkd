import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExplorePage extends StatelessWidget{

  final Opacity = Container(
    color: Color(0xAAAF2222),
  );



  TextStyle Raleway = TextStyle(
    color: Color(0xAAAF2222),
    fontFamily: 'Raleway',
  );

  final background = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/9.jpeg'),
            fit: BoxFit.cover,
          )
      )
  );

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      /*appBar: new AppBar(
        title: Text("Search",textAlign: TextAlign.center,),
        backgroundColor: Colors.white70,
        iconTheme: IconThemeData(color: Colors.deepOrange),
        textTheme: TextTheme(
            title: TextStyle(
              letterSpacing: 5.0,
              color: Colors.black54,
              wordSpacing: 2.0,
              fontWeight: FontWeight.bold,
              fontFamily: "Raleway",
            ),
          ),

        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
            onPressed:() {
            showSearch(context: context, delegate: DataSearch());
            },)
        ],
//      ),*/
//      drawer: Drawer(),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 20.0,
        backgroundColor: Colors.white,
          label: Text("Search",style: Raleway.copyWith(fontSize: 20.0),),
          icon : Icon(Icons.search,color: Color(0xAAAF2222),),
        onPressed: () {showSearch(context: context, delegate: DataSearch());},
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          background,
          Opacity,
        ],
      ),
    );
  }

}
var result = [
];
class DataSearch extends SearchDelegate<String> {

  final resturaunt = [
    "Barcos",
    "foodHub",
    "Rock&Roll",
    "PiratesOfGrills",
  ];
  
  final recentResturaunt = [
    "Barcos",
    "foodHub",
  ];



  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(icon: Icon(Icons.clear),
          onPressed: (){
        query ="";
      })];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of app bar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: transitionAnimation),
            onPressed: ()
            {
              close(context,null);
              result.clear();
            });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on selection
    List cards = new List.generate(result.length, (i)=>new CustomCard(result[i])).toList();
    return Container(
      child: new ListView(
            children : cards,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty ? recentResturaunt:resturaunt.where((p)=>p.startsWith(query)).toList();


    return ListView.builder(
      itemBuilder: (context,index)=>ListTile(

        onTap: (){
          print("query:" +recentResturaunt[index]);
          result.add(suggestionList[index]);
          showResults(context);
        },
      leading: Icon(Icons.fastfood),
      title: RichText(text: TextSpan(
        text: suggestionList[index].substring(0,query.length),
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        children: [TextSpan(
          text: suggestionList[index].substring(query.length),
          style: TextStyle(color: Colors.grey)
        ),
        ]
      )),
    ),
    itemCount: suggestionList.length,);
  }

}

class CustomCard  extends StatefulWidget{
  var result1;
  CustomCard(this.result1);

  @override
  CustomCardState createState() {
    return new CustomCardState();
  }
}

class CustomCardState extends State<CustomCard> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  new Card(
      elevation: 10.0,
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    new Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    Expanded(
    child: new Image.asset("assets/images/food.png", fit: BoxFit.fitWidth, height:200, width: 100,
    ),
    ),
    ],
    ),
    new Text(widget.result1),
    new Text("Description", style: new TextStyle(
    fontSize: 10.0,
    color: Theme.of(context).textTheme.subtitle.color
    ),)
    ],
    ),
    );
  }
}