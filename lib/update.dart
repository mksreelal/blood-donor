import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key});
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

  TextEditingController donorname = TextEditingController();
  TextEditingController donorphone = TextEditingController();

  void updatedonor(docid) {
    final data = {
      'Name': donorname.text,
      'Phone': donorphone.text,
      'Group': selectedgroup
    };
    donor.doc(docid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as Map;
    donorname.text = args['Name'];
    donorphone.text = args['Phone'];
    selectedgroup = args['Group'];
    final docid = args['id'];
    return Scaffold(
      appBar: AppBar(
        title: Text('Update members'),
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
                value: selectedgroup,
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
                  updatedonor(docid);
                  Navigator.of(context).pop();
                },
                child: Text('Update'))
          ],
        ),
      ),
    );
  }
}
