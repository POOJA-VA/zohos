import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:zoho/src/presentation/widgets/AdDropDown.dart'; // Import the file containing DropdownButtonExample

class Admin extends StatefulWidget {
  const Admin({Key? key}) : super(key: key);

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  String? pendingValue = list.first; // Set initial value to "Pending"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Welcome Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SizedBox(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/young-woman-working-laptop-isolated-white-background_231208-1838.jpg',
                            ),
                          ),
                          Text('Daisy Joseph',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20)),
                          Text('Senior Manager',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.grey)),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Date',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '${DateTime.now().toString().substring(0, 10)}', // Display formatted date
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Admin No:',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    '0001',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            child: Text('Close'),
                            onPressed: () {
                              Navigator.pop(context); // Close the bottom sheet
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                'https://img.freepik.com/free-photo/young-woman-working-laptop-isolated-white-background_231208-1838.jpg',
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.network(
            'https://lottie.host/72b84c2c-87d1-49fa-8bc6-ffedff2d8302/TBeFAJHmYP.json',
            width: 350,
            height: 310,
          ),
          SizedBox(
            width: 350,
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      'EP-3445 Santra Richards',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Forgot to checkin',
                      style: TextStyle(fontSize: 16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {}, // No functionality when pressed
                          child: Text(
                            'Approved',
                            style: TextStyle(
                                color: Color.fromARGB(255, 130, 233, 124)),
                          ),
                        ),
                        TextButton(
                          onPressed: () {}, // No functionality when pressed
                          child: Text(
                            'Rejected',
                            style: TextStyle(
                                color: Color.fromARGB(255, 226, 86, 58)),
                          ),
                        ),
                      ],
                    ),
// Use DropdownButtonExample widget here
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
