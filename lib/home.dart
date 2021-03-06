import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:project/model/vehicle.dart';
import 'package:project/utils/database_methods.dart';

import 'widgets/add_vehicle.dart';
import 'signup.dart';

class Home extends StatelessWidget {


  Home({this.uid});
  final String uid;
  final String title = "Home";

  void startAddingVehicle(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (idgaf) {
          return AddVehicle();
        });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              onPressed: () {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.signOut().then((res) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignUp()),
                      (Route<dynamic> route) => false);
                });
              },
            )
          ],
        ),
        body: MaterialApp(
          home: HomeBody(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => AddVehicle()),
            // );
            startAddingVehicle(context);
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
        drawer: NavigateDrawer(uid: this.uid));
  }
}

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  DatabaseMethods _databaseMethods = DatabaseMethods();
  @override
  Widget build(BuildContext context) {

    return StreamBuilder<List<Vehicle>>(stream: _databaseMethods.getVehicles(),builder: (_,snapshot){ if(snapshot.hasData){
      return ListView.builder(itemBuilder:(_,index){
        return ListTile(title: Text(snapshot.data[index].name),);
      },itemCount: snapshot.data.length, );
    }
    else{
      if(snapshot.connectionState == ConnectionState.done){
        return Center(child: Text("No Data"),);
      }
      return Center(child: CircularProgressIndicator(),);
    }
    },);
  }
}

class NavigateDrawer extends StatefulWidget {
  final String uid;
  NavigateDrawer({Key key, this.uid}) : super(key: key);
  @override
  _NavigateDrawerState createState() => _NavigateDrawerState();
}

class _NavigateDrawerState extends State<NavigateDrawer> {
  @override
  Widget build(BuildContext context) {
    print(widget.uid);
    print(FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(widget.uid)
        .once());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          // UserAccountsDrawerHeader(
          //   accountEmail: FutureBuilder(
          //       future: FirebaseDatabase.instance
          //           .reference()
          //           .child("Users")
          //           .child(widget.uid)
          //           .once(),
          //       builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          //         print("!!!!!!!!!!!!!!!!!");
          //         print(snapshot.data.value);
          //         if (snapshot.hasData) {
          //           print(snapshot);
          //           return Text(snapshot.data.value['email']);
          //         } else {
          //           return CircularProgressIndicator();
          //         }
          //       }),
          //   accountName: FutureBuilder(
          //       future: FirebaseDatabase.instance
          //           .reference()
          //           .child("Users")
          //           .child(widget.uid)
          //           .once(),
          //       builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
          //         if (snapshot.hasData) {
          //           return Text(snapshot.data.value['email']);
          //         } else {
          //           return CircularProgressIndicator();
          //         }
          //       }),
          //   decoration: BoxDecoration(
          //     color: Colors.blue,
          //   ),
          // ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.home, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Home'),
            onTap: () {
              print(widget.uid);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Home(uid: widget.uid)),
              );
            },
          ),
          ListTile(
            leading: new IconButton(
              icon: new Icon(Icons.settings, color: Colors.black),
              onPressed: () => null,
            ),
            title: Text('Settings'),
            onTap: () {
              print(widget.uid);
            },
          ),
        ],
      ),
    );
  }
}
