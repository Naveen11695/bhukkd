import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


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


class ExplorePage extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          background,
          Opacity,
          new CustomScrollView(
            slivers: <Widget>[
              new SliverAppBar(
                backgroundColor: Color.fromRGBO(255, 255, 255, 50),
                expandedHeight: 200.0,
                pinned: true,
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text("Explorer",textAlign: TextAlign.center,style: Raleway,),
                ),
              ),
              SliverGrid(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 300.0,
                  mainAxisSpacing: 20.0,
                  crossAxisSpacing: 20.0,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.teal[100 * (index % 9)],
                      child: Text('grid item $index'),
                    );
                  },
                  childCount: 50,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        elevation: 20.0,
        backgroundColor: Color.fromRGBO(255, 255, 255, 50),
        label: Text("Search",style: Raleway.copyWith(fontSize: 20.0),),
        icon : Icon(Icons.search,color: Color(0xAAAF2222),),
        onPressed: () {showSearch(context: context, delegate: DataSearch());},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
    return Stack(
      children: <Widget>[
        new ListView(
              children : cards,
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty ? recentResturaunt:resturaunt.where((p)=>p.toLowerCase().startsWith(query)).toList();


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