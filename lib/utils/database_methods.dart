import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:project/model/vehicle.dart';

class DatabaseMethods{
  Firestore _database = Firestore.instance;
Stream<List<Vehicle>> getVehicles(){
  return _database.collection("vehicles").snapshots().map((event) => event.documents.map((e) => Vehicle(name:e["name"])).toList());
}

Future<DocumentReference> addVehicle({String name}){
  return _database.collection("vehicles").add({"name":name});
}
}