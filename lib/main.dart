import 'package:flutter/material.dart';
import 'dart:developer';
import 'table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project Kawan Lama',
      home: homePage(),
    );
  }
}

const List<String> list = <String> ['Andi - A001', 'Susi - A002', 'Toni - A003', 'Hendra - A004'];

// Home page.

final List<Map<String, dynamic>> listData = [
  {'NIK': 'A001', 'Nama': 'Andi', 'Tanggal Absen': '30/08/2014'},
  {'NIK': 'A001', 'Nama': 'Andi', 'Tanggal Absen': '02/09/2014'},
  {'NIK': 'A002', 'Nama': 'Susi', 'Tanggal Absen': '30/08/2014'},
  {'NIK': 'A002', 'Nama': 'Susi', 'Tanggal Absen': '31/08/2014'},
  {'NIK': 'A002', 'Nama': 'Susi', 'Tanggal Absen': '01/09/2014'},
  {'NIK': 'A003', 'Nama': 'Toni', 'Tanggal Absen': '29/08/2014'},
  {'NIK': 'A003', 'Nama': 'Toni', 'Tanggal Absen': '02/09/2014'},
  {'NIK': 'A004', 'Nama': 'Hendra', 'Tanggal Absen': '29/08/2014'},
  {'NIK': 'A005', 'Nama': 'Hendra', 'Tanggal Absen': '31/08/2014'},
];

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {

  String selectedNIK = list.first.split(' - ')[1];
  String selectedName = list.first.split(' - ')[0];
  DateTime selectedDate = DateTime(2014, 08, 30);

  void updateSelectedNIK(String value){
    setState(() {
      selectedNIK = value.split(' - ')[1];
    });
  }

  void updateSelectedName(String value){
    setState(() {
      selectedName = value.split(' - ')[0];
    });
  }

  void updateSelectedDate(DateTime newDate){
    setState(() {
      selectedDate = newDate;
    });
  } 

  void addData(String NIK, String Name, String Date){
    setState(() {
      listData.add({
        'NIK': selectedNIK,
        'Nama': selectedName,
        'Tanggal Absen': '${selectedDate.year}/${selectedDate.month}/${selectedDate.day}',
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Kawan Lama Project'),
      ),
      body: Center(
        child: Column(
          children: [
            DropdownList(selectedNIK: selectedNIK,
                        selectedName: selectedName,
                        updateSelectedNIK: updateSelectedNIK,
                        updateSelectedName: updateSelectedName, 
                        updateSelectedDate: updateSelectedDate,
                        addData: addData,
                        ),
            DataTableList(selectedNIK: selectedNIK,
                          selectedName: selectedName,
                          selectedDate: selectedDate,
                          listData: listData,
            ),
            FloatingActionButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => tableNomor3()),
              );
            },
            child: Icon(Icons.navigate_next),
            ),
          ],
        )
      ),
    );
  }

}

// Dropdown list. (Nomor 1)
class DropdownList extends StatefulWidget {

  final String selectedNIK;
  final String selectedName;
  final Function(String) updateSelectedNIK;
  final Function(String) updateSelectedName;
  final Function(DateTime) updateSelectedDate;
  final Function(String, String, String) addData;

  const DropdownList({
    required this.selectedNIK,
    required this.selectedName,
    required this.updateSelectedNIK,
    required this.updateSelectedName,
    required this.updateSelectedDate,
    required this.addData,
    Key? key,
  }) : super(key: key);

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  String dropdownItem = list.first;
  DateTime date = DateTime(2014, 08, 30);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // NIK and Nama dropdown list
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(right: 50),
              child: Text('NIK - Nama: '), // Text widget on the left
            ),
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: DropdownButton<String>(
                value: dropdownItem,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.black),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                onChanged: (String? value) {
                  setState(() {
                    dropdownItem = value!;
                  });
                },
                items: list.map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
        // Date and time
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 50, right: 50),
              child: Text('Tanggal absen: ${date.year}/${date.month}/${date.day}'),
            ),
            // Date time picker
            Container(
              margin: EdgeInsets.only(top: 50),
              child: ElevatedButton(
                child: Text('Select date'),
                onPressed: () async {
                  DateTime? newDate = await showDatePicker(context: context, firstDate: DateTime(2014), lastDate: DateTime(2016));

                  if (newDate == null) return;

                  setState(() => date = newDate);      
                },
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          child: ElevatedButton(
            child: Text('Add to Table'),
            onPressed: () {
              // debugPrint('Data updated!');
              widget.updateSelectedNIK(dropdownItem);
              widget.updateSelectedDate(date);
              widget.addData(widget.selectedNIK, widget.selectedName, '${date.year}/${date.month}/${date.day}');
            },
          ),
        ),
      ],
    );
  }
}

// Data table. (Nomor 2)
class DataTableList extends StatefulWidget {
  final String selectedNIK;
  final String selectedName;
  final DateTime selectedDate;
  final List<Map<String, dynamic>> listData;
  
  const DataTableList({
    required this.selectedNIK,
    required this.selectedName,
    required this.selectedDate,
    required this.listData,
    Key? key,
  }) : super(key: key);

  @override
  State<DataTableList> createState() => _DataTableState();
}

class _DataTableState extends State<DataTableList> {
  
  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only(top: 30),
      height: 300,
      decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('NIK')),
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('Tanggal Absen')),
            ],
            rows: listData
            .map((data) => DataRow(
              cells: [
                DataCell(Text(data['NIK'].toString())),
                DataCell(Text(data['Nama'].toString())),
                DataCell(Text(data['Tanggal Absen'].toString())),
              ],
            )).toList()
        ),
      ),
      )
    );
  }

}