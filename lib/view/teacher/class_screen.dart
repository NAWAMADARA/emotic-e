

import 'package:flutter/material.dart';

class ClassScreen extends StatefulWidget {
  const ClassScreen({Key? key}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  List<List<String>> items = [];
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();

  void _addItem() {
    _showCustomDialog(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller2.dispose();
    _controller1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(items[index][0]),
                      subtitle:Text(items[index][1]),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _addItem,
              child: const Text('Schedule class'),
            ),
          ],
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context) {
    double dialogWidth = MediaQuery.of(context).size.width/2; // Set your desired width
    double dialogHeight = MediaQuery.of(context).size.height/3; // Set your desired height

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            width: dialogWidth,
            height: dialogHeight,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                 TextField(
                  controller: _controller1,
                  decoration: const InputDecoration(labelText: 'Class Headline'),
                ),
               const SizedBox(height: 16.0),
                TextField(
                 controller: _controller2,
                  decoration: const InputDecoration(labelText: 'Class Description'),
                ),
               const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      items.add([_controller1.text,_controller2.text]);
                    });
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Class'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }


}
