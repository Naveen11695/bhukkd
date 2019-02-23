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


class ExplorePage extends StatefulWidget {
  @override
  _ExplorePage createState() => _ExplorePage();
}


class _ExplorePage extends State<ExplorePage>{
  List cards = new List.generate(result.length, (i)=>new CustomCard(result[i])).toList();

  @override
  Widget build(BuildContext context) => new Scaffold(
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
                floating: true,
                title: new Text("Explorer",textAlign: TextAlign.center,style: Raleway.copyWith(fontSize: 30, fontWeight: FontWeight.bold ),),
                flexibleSpace: new FlexibleSpaceBar(
                  title: new Text(
                    "                     Local cuisine, Indian, Asian,\nVegetarian Friendly",
                    textAlign: TextAlign.end,
                    style: Raleway.copyWith(fontSize: 16,fontStyle: FontStyle.italic, fontWeight: FontWeight.w400),),
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
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                      alignment: Alignment.center,
                      color: Colors.white,
                      child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              new Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new Image.asset("assets/images/food.png", fit: BoxFit.fitWidth, height:150, width: 50,
                                    ),
                                  ),
                                ],
                              ),
                              new Text("Resturaunt $index",style: Raleway.copyWith(fontSize: 20.0),),
                              new Text("Description", style: new TextStyle(
                                  fontSize: 10.0,
                                  color: Theme.of(context).textTheme.subtitle.color
                              ),)
                            ],
                          ),
                      ),
                    ),
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
var result = [
];
class DataSearch extends SearchDelegate<String> {



  final resturaunt = [
    "Barcos",
    "foodHub",
    "Rock&Roll",
    "PiratesOfGrills",
    "barloons",
    "baryFeast",
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
            });
  }

  @override
  Widget buildResults(BuildContext context) {
    // show some result based on selection
    var nearList= resturaunt.where((p)=>p.toLowerCase().startsWith(query)).toList();
    List cards = new List.generate(result.isEmpty?nearList.length:result.length, (i)=>new CustomCard((result.isEmpty?nearList[i]:result[i]))).toList();
    return Stack(
      children: <Widget>[
        background,
        Opacity,
        new GridView(
              children : cards,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300.0,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
          childAspectRatio: 1.0,
    ),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    final suggestionList = query.isEmpty ? recentResturaunt:resturaunt.where((p)=>p.toLowerCase().startsWith(query)).toList();
    result.clear();

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
      //shape: StadiumBorder(),
      elevation: 10.0,
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      Expanded(
      child: new Image.asset("assets/images/food.png", fit: BoxFit.fitWidth, height:150, width: 50,
      ),
      ),
      ],
      ),
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