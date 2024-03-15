import 'package:flutter/material.dart';
import 'package:zoho/src/presentation/JsonModels/regularization.dart';
import 'package:zoho/src/presentation/SQLite/sqlite.dart';

class Pending extends StatefulWidget {
  final String selectedDropdownValue;

  const Pending({
    Key? key,
    required this.selectedDropdownValue,
  }) : super(key: key);

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
   List<RegularizationData>? regularizationDataList;

  Future<void> _fetchRegularizationData() async {
    final fetchedData = await DatabaseHelper.instance.getRegularizationData();
    setState(() {
      regularizationDataList = fetchedData;
    });
  }

    @override
  void initState() {
    super.initState();
    _fetchRegularizationData();
  }

  @override
  Widget build(BuildContext context) {
    if (regularizationDataList!.isEmpty) {
      return Center(
        child: Text('No regularization data available.'),
      );
    } else {
      return ListView.builder(
        itemCount: regularizationDataList!.length,
        itemBuilder: (context, index) {
          final regularizationData = regularizationDataList![index];
          return SizedBox(
            width: 300,
            height: 170,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      regularizationData.employeeName,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Date: ${regularizationData.date}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Check-In Time: ${regularizationData.checkInTime}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Check-Out Time: ${regularizationData.checkOutTime}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Hours: ${regularizationData.hours}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Dropdown Value: ${widget.selectedDropdownValue}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
