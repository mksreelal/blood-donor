import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ScreenAdd extends StatelessWidget {
  ScreenAdd({super.key});
  final bloodgroup = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    "O-",
  ];
  late String selectedgroup;
  final CollectionReference donor =
      FirebaseFirestore.instance.collection('donor');

  void adddonor() {
    final data = {
      'Name': donorname.text,
      'Phone': donorphone.text,
      'Group': selectedgroup
    };
    donor.add(data);
  }

  TextEditingController donorname = TextEditingController();
  TextEditingController donorphone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add members'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextFormField(
              controller: donorname,
              decoration: InputDecoration(
                  labelText: 'username',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: donorphone,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Phone',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
            ),
            DropdownButtonFormField(
                decoration: InputDecoration(
                    hintText: 'select', border: InputBorder.none),
                items: bloodgroup
                    .map((e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ))
                    .toList(),
                onChanged: (val) {
                  selectedgroup = val!;
                }),
            TextButton(
                onPressed: () {
                  adddonor();
                  Navigator.of(context).pop();
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }
}
