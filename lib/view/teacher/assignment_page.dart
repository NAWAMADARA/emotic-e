import 'package:flutter/material.dart';



class Assignment {
  final String description;
  final List<String> attachedFiles;

  Assignment(this.description, this.attachedFiles);
}


class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  _AssignmentScreenState createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen> {
  List<Assignment> assignments = [];

  void _showAssignAssignmentDialog() async {
    String description = "";
    List<String> attachedFiles = [];

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Assign Assignment'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Description:'),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        description = text;
                      });
                    },
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'Enter description...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text('Attached Files:'),
                  attachedFiles.isEmpty
                      ? Text('No files attached.')
                      : Column(
                    children: attachedFiles.map((file) {
                      return ListTile(
                        title: Text(file),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      // Implement file attachment logic here.
                      String selectedFile =
                          "file.txt"; // Replace with actual selected file.
                      setState(() {
                        attachedFiles.add(selectedFile);
                      });
                    },
                    child: Text('Attach Files'),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Save the assignment with description and attached files.
                    assignments.add(Assignment(description, attachedFiles));
                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _viewAssignments() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewAssignmentsScreen(assignments: assignments),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _showAssignAssignmentDialog,
              child: const Text('Assign Assignments'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _viewAssignments,
              child: const Text('View Assignments'),
            ),
          ],
        ),
      ),
    );
  }
}

class ViewAssignmentsScreen extends StatelessWidget {
  final List<Assignment> assignments;

  const ViewAssignmentsScreen({super.key, required this.assignments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Assignments'),
      ),
      body: ListView.builder(
        itemCount: assignments.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(assignments[index].description),
                  const SizedBox(height: 8),
                  const Text(
                    'Attached Files:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Column(
                    children: assignments[index].attachedFiles.map((file) {
                      return ListTile(
                        title: Text(file),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
