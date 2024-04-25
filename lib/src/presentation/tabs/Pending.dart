import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:zoho/src/presentation/provider/regularProvider.dart';

class Pending extends ConsumerWidget {
  final String selectedDropdownValue;

  const Pending(
      {Key? key, required this.selectedDropdownValue, required this.role})
      : super(key: key);
  final String role;

  static bool isFirst = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    if(isFirst) {
      ref.read(statusProvider).setPendingList();
      isFirst = false;
    }
    // final regularizationPendingDataList = ref.watch(regularizationProvider);
    // final regularizationPendingDataList = ref.watch(pendingRegularizationProvider);
    final pendingList = ref.watch(statusProvider).pendingList;

    if (pendingList.isEmpty || pendingList.length == 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.network(
              'https://lottie.host/bd0e5132-2c38-407a-ba72-f1892558f9c5/yop6ZBBJIu.json',
              fit: BoxFit.cover,
            ),
            Text(
              'No Records Found',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            SizedBox(height: 5),
            Text(
              'There are no records to \ndisplay right now.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    } else {
      return ListView.builder(
        itemCount: pendingList.length,
        itemBuilder: (context, index) {
          final regularizationData = pendingList[index];
          return SizedBox(
            width: 300,
            height: 220,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          regularizationData.employeeName,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
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
                      'Dropdown Value: ${regularizationData.dropdownValue}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    role == "Admin" ? 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 9, 47, 15))),
                            ),
                          ),
                          onPressed: () {
                            ref.read(regularizationProvider.notifier).updateRegularization(regularizationData.id,  "Approved");
                            ref.read(statusProvider).setPendingList();
                            ref.read(statusProvider).setApprovedList();
                            ref.read(statusProvider).setRejectedList();
                          },
                          child: Text('Approve'),
                        ),
                        TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                  side: BorderSide(color: Colors.red)),
                            ),
                          ),
                          onPressed: () {
                            ref.read(regularizationProvider.notifier).updateRegularization(regularizationData.id,  "Rejected");
                            ref.read(statusProvider).setPendingList();
                            ref.read(statusProvider).setApprovedList();
                            ref.read(statusProvider).setRejectedList();
                            print("Rejected");
                          },
                          child: Text('Reject'),
                        ),
                      ],
                    ): SizedBox.shrink(),
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