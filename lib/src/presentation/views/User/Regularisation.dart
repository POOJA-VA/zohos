import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:zoho/src/domain/Modal/regularization.dart';
import 'package:zoho/src/presentation/provider/regularProvider.dart';
import 'package:zoho/src/presentation/tabs/Pending.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Regular extends ConsumerStatefulWidget {
  const Regular({Key? key}) : super(key: key);

  @override
  ConsumerState<Regular> createState() => _RegularState();
}

class _RegularState extends ConsumerState<Regular> {
  String dropdownValue = 'Day';
  late DateTime selectedDate;
  late TimeOfDay checkInTime;
  late TimeOfDay checkOutTime;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    DateTime now = DateTime.now().toUtc().add(Duration(hours: 5, minutes: 30));
    selectedDate = DateTime(now.year, now.month, now.day);
    checkInTime = TimeOfDay(hour: 9, minute: 30);
    checkOutTime = TimeOfDay(hour: 19, minute: 00);
  }

  Future<void> _selectDateTime(BuildContext context, String choose) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
    if (pickedDate != null && choose != "Date") {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: 19, minute: 30),
      );
      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          checkInTime = pickedTime;
          checkOutTime = TimeOfDay(
            hour: pickedTime.hour + 9,
            minute: pickedTime.minute,
          );
        });
      }
    }
  }

  void _reset() {
    setState(() {
      selectedDate = DateTime.now();
      checkInTime = TimeOfDay(hour: 9, minute: 30);
      checkOutTime = TimeOfDay(hour: 19, minute: 00);
      selectedValue = null;
    });
  }

  final List<String> items = [
    'Forgot to Check-in',
    'Forgot to Check-out',
    'Temporary Access Card',
  ];

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, dd MMM').format(now);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context)!.regularization,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: 340,
            height: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.employee,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'EM-3445 Santra Richards',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 340,
            height: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.period,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          dropdownValue,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: 340,
            height: 100,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(context)!.date,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${selectedDate.day}-${selectedDate.month}-${selectedDate.year}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        _selectDateTime(context, "Date");
                      },
                      icon: Icon(Icons.arrow_forward_ios_outlined,
                          color: Colors.lightBlueAccent),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 300,
                    width: 80,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              formattedDate,
                              style: TextStyle(fontSize: 20),
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: 260,
                    height: 300,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    _selectDateTime(context, "");
                                  },
                                  child: Text(
                                    'Check-in\n${selectedDate.day}-${selectedDate.month}-${selectedDate.year} \n${checkInTime.format(context)}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.green),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    _selectDateTime(context, "");
                                  },
                                  child: Text(
                                    'Check-out\n${selectedDate.day}-${selectedDate.month}-${selectedDate.year} \n${checkOutTime.format(context)}',
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.red),
                                  ),
                                ),
                                Text(
                                  '${checkOutTime.hour - checkInTime.hour}:${checkOutTime.minute - checkInTime.minute}\n Hr(s)',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 250,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.blueAccent[100],
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<String>(
                                  isExpanded: true,
                                  hint: Text(
                                    'Forgot to Check-in',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Theme.of(context).hintColor),
                                  ),
                                  items: items
                                      .map((String item) =>
                                          DropdownMenuItem<String>(
                                            value: item,
                                            child: Text(
                                              item,
                                              style:
                                                  const TextStyle(fontSize: 14),
                                            ),
                                          ))
                                      .toList(),
                                  value: selectedValue,
                                  onChanged: (String? value) {
                                    // print(selectedValue);
                                    selectedValue = value;
                                  },
                                  buttonStyleData: const ButtonStyleData(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    height: 40,
                                    width: 140,
                                  ),
                                  menuItemStyleData: const MenuItemStyleData(
                                    height: 40,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextButton(
                              style: TextButton.styleFrom(
                                textStyle: const TextStyle(fontSize: 15),
                              ),
                              onPressed: _reset,
                              child: Center(
                                child: Text(AppLocalizations.of(context)!.reset),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          Container(
            height: 50,
            width: 350,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.cancel,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
                SizedBox(width: 20),
                TextButton(
                  onPressed: () async {
                    RegularizationData regularizationData = RegularizationData(
                        employeeName: 'EM-3445 Santra Richards',
                        date: selectedDate.toString(),
                        checkInTime: checkInTime,
                        checkOutTime: checkOutTime,
                        hours: checkOutTime.hour - checkInTime.hour,
                        dropdownValue: selectedValue!,
                        status: "Pending");
                    ref
                        .read(regularizationProvider.notifier)
                        .insertRegularization(regularizationData);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Pending(
                          selectedDropdownValue: selectedValue!,
                          role: "User",
                        ),
                      ),
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    AppLocalizations.of(context)!.submit,
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}