import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:zoho/src/presentation/barGraph/barGraph.dart';
import 'package:zoho/src/presentation/provider/hoursProvider.dart';
import 'package:zoho/src/presentation/provider/reportProvider.dart';
import 'package:zoho/src/presentation/views/User/UserList.dart';

class Report extends ConsumerStatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  ConsumerState<Report> createState() => _ReportState();
}

class _ReportState extends ConsumerState<Report> {
  @override
  void initState() {
    super.initState();
    ref.read(hrsProvider.notifier).setHours();
    ref.read(checkInOutProvider.notifier).fetchCheckInOutList();
  }

  @override
  Widget build(BuildContext context) {
    final checkInOutList = ref.watch(checkInOutProvider);
    final hrsProviderNotifier = ref.watch(hrsProvider.notifier);
    final hrs = ref.watch(hrsProvider).hrs;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                AppLocalizations.of(context)!.report,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserList()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: 160,
                height: 110,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.totalTime,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '66:50:00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 160,
                height: 110,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.averageTime,
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '56:00:00',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            width: 340,
            height: 290,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.arrow_back_rounded),
                          onPressed: () {
                            setState(() {
                              hrsProviderNotifier.setPreviousWeek();
                            });
                          },
                        ),
                        Spacer(),
                        Text(
                          AppLocalizations.of(context)!.summaryReport,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_rounded),
                          onPressed: () {
                            setState(() {
                              hrsProviderNotifier.setCurrentWeek();
                            });
                          },
                        ),
                      ],
                    ),
                    Center(
                      child: SizedBox(
                        height: 190,
                        child: BarGraph(
                          weeklySummary: hrs,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: checkInOutList.isEmpty
                ? Center(
                    child: Text(AppLocalizations.of(context)!.record),
                  )
                : ListView.builder(
                    itemCount: checkInOutList.length,
                    itemBuilder: (context, index) {
                      final checkInOut = checkInOutList[index];
                      return SizedBox(
                        width: 300,
                        height: 130,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${checkInOut['title']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    Text(
                                      '${checkInOut['hours'] != null ? checkInOut['hours'] : 'Absent'}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      icon: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!.checkin,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Color.fromARGB(
                                                255, 177, 178, 178),
                                          ),
                                        ),
                                        Text(
                                          '${checkInOut['checkin'] != null ? checkInOut['checkin'] : '00:00:00'}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                    IconButton(
                                      icon: CircleAvatar(
                                        backgroundImage: NetworkImage(
                                          'https://img.freepik.com/free-photo/young-beautiful-woman-pink-warm-sweater-natural-look-smiling-portrait-isolated-long-hair_285396-896.jpg',
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          AppLocalizations.of(context)!
                                              .checkout,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                          ),
                                        ),
                                        Text(
                                          '${checkInOut['checkout'] != null ? checkInOut['checkout'] : '00:00:00'}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}