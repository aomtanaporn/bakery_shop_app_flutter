import 'package:final_project/BasketPage.dart';
import 'package:final_project/Robot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:final_project/FoodItem.dart';
import 'package:final_project/Details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FocusNode searchNode = FocusNode();
  bool search = false;
  TextEditingController searchTxt = TextEditingController();
  Widget cusSearchBar = Text(
    "Aom Shop",
  );
  Icon cusIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  bool searchIsExpanded = false;
  int selectedIndex = 0;
  List<String> categories = ["All", "Dessert","Beverage"];
  @override
  void initState() {

    super.initState();
}
  @override
  Widget build(BuildContext context) {
    var central = Provider.of<MyStore>(context);
    List<FoodItem> foodItemList = central.filterfoods;
    print(foodItemList.length);
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Aom Made Dessert',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
            ListTile(
              title: Text('Home Page',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blue
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => HomePage()
                ));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: cusSearchBar,
        centerTitle: false,
        actions: [
          IconButton(
            splashColor: Colors.transparent,
            color: Colors.black,
            highlightColor: Colors.transparent,
            onPressed: () {
              setState(() {
                if (this.cusIcon.icon == Icons.search) {
                  searchIsExpanded = true;
                  cusIcon = Icon(
                    Icons.close,
                    color: Colors.white,
                  );
                  this.cusSearchBar = buildSearchBar(central);
                } else {
                  searchIsExpanded = false;
                  this.cusIcon = Icon(
                    Icons.search,
                    color: Colors.white,
                  );
                  this.cusSearchBar = Text(
                    "Aom Shop",
                  );
                  this.searchTxt.text = "";
                  // central.createMoviesList(central.selectedCategories, central);
                }
              });
              buildSearchBar(central);
            },
            icon: cusIcon,
          ),
        ],
        backgroundColor: Colors.lightBlue,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            width: w,
            height: h / 2.7,
            child: Container(
                padding: EdgeInsets.only(left: 30, top: 40),
                decoration: BoxDecoration(color: Colors.lightBlue),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Aom Made Dessert",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                        height: 50,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 7),
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: categories.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 2),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedIndex = index;
                                        central.applyMovieFilter(selectedIndex);
                                        print(index);
                                      });
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          categories[index],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: index == selectedIndex
                                                  ? Colors.deepPurple
                                                  : Colors.black26),
                                        ),
                                        Container(
                                          height: 6,
                                          width: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              color: index == selectedIndex
                                                  ? Colors.deepPurple
                                                  : Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        ))
                  ],
                )),
          ),
          Positioned(
            height: h / 1.55,
            top: h * 0.2,
            width: w,
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                  BorderRadius.only(topLeft: Radius.circular(100))),
              child: ListView.builder(
                itemCount: foodItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 110,
                    child: InkWell(
                      onTap: (){
                        central.setActiveProduct(foodItemList[index]);
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Details()
                        ));
                      },
                      child: Card(
                        elevation: 5,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                          image:
                                          NetworkImage(foodItemList[index].image),
                                          fit: BoxFit.cover)

                                  ),
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(foodItemList[index].name, style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17
                                ),),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Price:  " +
                                    foodItemList[index].price.toString()),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("In Stock: " + foodItemList[index].stock.toString()),
                              ],
                            ),
                            IconButton(
                              onPressed: () {
                                central.addOneToBasket(foodItemList[index], 1);
                              },
                              icon: Icon(Icons.add),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(5),
        height: 80,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.lightBlueAccent),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Stack(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Icon(Icons.shopping_basket),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 20,
                          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.deepPurple,),
                          alignment: Alignment.topCenter,
                          child: Text(central.getBasketQty().toString(), style: TextStyle(color: Colors.white),)
                      ),
                    )
                  ],
                ),
              ),


            ),
            InkWell(
              onTap: (){
                if(central.getBasketQty() > 0){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => BasketPage()
                  ));

                }else{
                  AlertDialog alert = AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Text("Error"),
                    content: Text("Please add item into basket before check out"),
                    actions: [
                      RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text("okay"),
                          onPressed: () {
                            Navigator.pop(context);
                          })
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                }

              },
              child: Container(
                alignment: Alignment.center,
                width: 180,
                height: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: central.getBasketQty() == 0? Colors.grey:Colors.blue),
                child: Text(
                  "Check out", style: TextStyle(
                    color: Colors.white,
                    fontSize: 20
                ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  TextField buildSearchBar(MyStore central) {
    return TextField(
      cursorColor: Colors.black,
      autofocus: true,
      focusNode: searchNode,
      controller: searchTxt,
      onChanged: (text) {
        setState(() {
          if (text.isNotEmpty) {
            selectedIndex = 0;
            central.applyMovieFilter(0);
            search = true;
            central.setSearchKey(text);
          } else {
            search = false;
            central.setSearchKey(text);
          }
        });
      },
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.transparent,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.transparent,
            style: BorderStyle.solid,
          ),
        ),
        hintStyle: TextStyle(color: Colors.white30),
        contentPadding:
        EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
        hintText: "Search",
        filled: true,
        fillColor: Colors.black38,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
          borderSide: BorderSide(
            color: Colors.white,
            style: BorderStyle.solid,
          ),
        ),
      ),
    );
  }
}

