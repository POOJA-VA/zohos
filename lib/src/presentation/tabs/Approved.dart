import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:zoho/src/presentation/provider/regularProvider.dart';

class Approved extends ConsumerWidget {
  const Approved({super.key});

  static bool isFirst = true;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if(isFirst) {
      ref.read(statusProvider).setApprovedList();
      isFirst = false;
    }
    final approvedDataList = ref.watch(statusProvider).approvedList;
    if (approvedDataList.isEmpty || approvedDataList.length == 0) {
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
        itemCount: approvedDataList.length,
        itemBuilder: (context, index) {
          final regularizationData = approvedDataList[index];
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