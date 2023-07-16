import 'package:flutter/material.dart';
import 'grid_view_page.dart';

class CreateGridPage extends StatefulWidget {
  const CreateGridPage({super.key});

  @override
  State<CreateGridPage> createState() => _CreateGridPageState();
}

class _CreateGridPageState extends State<CreateGridPage> {
  late int row;
  late int column;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Grid'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (String? count) {
                  if (count == null || count.isEmpty || int.parse(count) > 6) {
                    return 'enter row count between 1-6';
                  }
                },
                onChanged: (value) {
                  row = int.parse(value);
                },
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Enter Count of Row",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                validator: (String? count) {
                  if (count == null || count.isEmpty || int.parse(count) > 6) {
                    return 'enter column count between 1-6';
                  }
                },
                onChanged: (value) {
                  column = int.parse(value);
                },
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.all(12),
                    hintText: "Enter Count of Column",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2.0, color: Colors.blue),
                    ),
                    border: OutlineInputBorder()),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          GridViewPage(column: column, row: row)),
                );
              }
            },
            child: const Text(
              'Create Grid View',
              style: TextStyle(fontSize: 16.0),
            )),
      ),
    );
  }
}
