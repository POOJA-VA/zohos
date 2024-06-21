import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/tabs/Approved.dart';
import 'package:zoho/src/presentation/tabs/Pending.dart';
import 'package:zoho/src/presentation/tabs/Rejected.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zoho/src/presentation/views/User/Regularisation.dart';

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
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.role == "User")
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalizations.of(context)!.approvals,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add), // Search icon
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Regular()),
                  );
                },
              ),
            ],
          ),
        TabBar(
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
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Pending(selectedDropdownValue: '', role: widget.role),
              Approved(),
              Rejected(),
            ],
          ),
        ),
      ],
    );
  }
}
