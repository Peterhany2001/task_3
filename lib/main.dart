import 'package:flutter/material.dart';

import 'contact.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Contact> contacts = [];
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void addContact() {}

  void deleteContact(Contact contact) {
    setState(() {
      contacts.remove(contact);
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Contact Screen"),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: 'Enter Your Name Here',
                        hintText: 'Name',
                        suffixIcon: const Icon(Icons.person)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Text';
                      }
                      return null;
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: 'Enter Your Number Here',
                        hintText: 'Number',
                        suffixIcon: const Icon(Icons.phone)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: FloatingActionButton.extended(
                            label: const Text("Add"), // <-- Text
                            backgroundColor: Colors.blue,
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                if (contacts.length < 3) {
                                  setState(() {
                                    final name = nameController.text;
                                    final phone = phoneController.text;
                                    final newContact = Contact(
                                        name: "Name : $name",
                                        phone: "Phone: $phone");
                                    contacts.add(newContact);
                                    nameController.clear();
                                    phoneController.clear();
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                for (var contact in contacts)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          ListTile(
                            trailing: InkWell(
                              child: IconButton(
                                  onPressed: () {
                                    deleteContact(contact);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                            ),
                            title: Text(
                              contact.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              contact.phone,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
