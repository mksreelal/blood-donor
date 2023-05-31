import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void deletedonor(id) {
    donor.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hyyyy'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('Screenadd');
        },
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemBuilder: (context, Index) {
                final DocumentSnapshot donorSnap = snapshot.data.docs[Index];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white70,
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 210, 209, 209),
                              blurRadius: 10,
                              spreadRadius: 8)
                        ]),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                backgroundColor: Colors.red,
                                radius: 30,
                                child: Text(
                                  donorSnap['Group'],
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                donorSnap['Name'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                donorSnap['Phone'].toString(),
                                style: TextStyle(fontSize: 16),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.of(
                                      context,
                                    ).pushNamed('update', arguments: {
                                      'Name': donorSnap['Name'],
                                      'Phone': donorSnap['Phone'].toString(),
                                      'Group': donorSnap['Group'],
                                      'id': donorSnap.id
                                    });
                                  },
                                  icon: Icon(Icons.edit)),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                onPressed: () {
                                  deletedonor(donorSnap.id);
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              )
                            ],
                          )
                        ]),
                  ),
                );
              },
              itemCount: snapshot.data?.docs.length,
            );
          }
          return Container();
        },
        stream: donor.orderBy('Name', descending: true).snapshots(),
      ),
    );
  }
}
