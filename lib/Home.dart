
import 'package:WeatherApp/weatherPage.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
     SharedPreferences _preferences;
    var controller = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }
  getSharedPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }
  @override
  Widget build(BuildContext context) {
     
    
  
    return Scaffold(
      backgroundColor: Colors.blue,
          body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        
        children: <Widget>[


          Center(
              child: Container(
                child: FlareActor("assets/WorldSpin.flr", fit: BoxFit.contain, animation: "roll",),
                height: 300,
                width: 300,
              )
          ),



         
                Container(
                  padding: EdgeInsets.only(left: 32, right: 32,),
                  child: Column(
                    children: <Widget>[
                      Text("Search Weather", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500, color: Colors.white70),),
                      Text("Instanly", style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200, color: Colors.white70),),
                      SizedBox(height: 24,),
                      TextFormField(
                        controller: controller,

                        decoration: InputDecoration(

                          prefixIcon: Icon(Icons.search, color: Colors.white70,),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.white70,
                                  style: BorderStyle.solid
                              )
                          ),

                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.blue,
                                  style: BorderStyle.solid
                              )
                          ),

                          hintText: "City Name",
                          hintStyle: TextStyle(color: Colors.white70),

                        ),
                        style: TextStyle(color: Colors.white70),

                      ),

                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        height: 50,
                        child: FlatButton(
                          shape: new RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                          onPressed:  () async {
                  if (controller.text != null && controller.text != '') {
                    _preferences.setString('city', controller.text);
                    await
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShowWeather(
                          controller: controller.text,

                        )));
                  }
                },
                          color: Colors.lightBlue,
                          child: Text("Search", style: TextStyle(color: Colors.white70, fontSize: 16),),

                        ),
                      )

                    ],
                  ),
                ),
             
        ],
      ),
    );
  }}