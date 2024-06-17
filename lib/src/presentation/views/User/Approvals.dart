import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/tabs/Approved.dart';
import 'package:zoho/src/presentation/tabs/Pending.dart';
import 'package:zoho/src/presentation/tabs/Rejected.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Approvals extends StatefulWidget {
  const Approvals({super.key, required this.role});
  final String role;

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
        title: widget.role == "User" ? Text(AppLocalizations.of(context)!.approvals,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)): Text(""),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            Tab(
              text: AppLocalizations.of(context)!.pending,
            ),
            Tab(
              text: AppLocalizations.of(context)!.approved,
            ),
            Tab(
              text: AppLocalizations.of(context)!.rejected,
            ),
          ],
        ),
      ),
      body: TabBarView(controller: _tabController,children: <Widget>[
        Pending(selectedDropdownValue: '', role: widget.role,),
        Approved(),
        Rejected(),
      ]),
    );
  }
}