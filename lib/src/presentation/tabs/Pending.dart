import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:zoho/src/domain/Modal/regularization.dart';
import 'package:zoho/src/presentation/provider/regularProvider.dart';

class Pending extends ConsumerWidget {
  final String selectedDropdownValue;

  const Pending({
    Key? key,
    required this.selectedDropdownValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<List<RegularizationData>>(
      regularizationProvider,
      (previousDataList, newDataList) {
        if (newDataList.isEmpty) {
          ref.read(regularizationProvider.notifier).fetchRegularization();
        }
      },
    );

    final regularizationDataList = ref.watch(regularizationProvider);
    if (regularizationDataList.isEmpty) {
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
        itemCount: regularizationDataList.length,
        itemBuilder: (context, index) {
          final regularizationData = regularizationDataList[index];
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