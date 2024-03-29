import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/tabs/Approved.dart';
import 'package:zoho/src/presentation/tabs/Pending.dart';
import 'package:zoho/src/presentation/tabs/Rejected.dart';
import 'package:zoho/src/presentation/views/User/Regularisation.dart';
class Approvals extends StatefulWidget {
  const Approvals({super.key});

  @override
  State<Approvals> createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approvals',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add_sharp,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Regular()),
              );
            },
          )
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: 'Pending',
            ),
            Tab(
              text: 'Approved',
            ),
            Tab(
              text: 'Rejected',
            ),
          ],
        ),
      ),
      body: new TabBarView(controller: _tabController,children: <Widget>[
        new Pending(selectedDropdownValue: '',),
        new Approved(),
        new Rejected(),
      ]),
    );
  }
}