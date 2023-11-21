import "package:flutter/material.dart";
import "dart:developer";
import 'main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Page 2',
      home: tableNomor3(),
    );
  }
}

final List<Map<String, dynamic>> listData = [
  {'NIK': 'A001', 'Nama': 'Andi', '29-08-2014': ' ', '30-08-2014': 'X',  '31-08-2014': ' ', '01-09-2014': ' ', '02-09-2014': 'X', 'Total': '2'},
  {'NIK': 'A002', 'Nama': 'Susi', '29-08-2014': ' ', '30-08-2014': 'X',  '31-08-2014': 'X', '01-09-2014': 'X', '02-09-2014': ' ', 'Total': '3'},
  {'NIK': 'A003', 'Nama': 'Toni', '29-08-2014': 'X', '30-08-2014': ' ',  '31-08-2014': ' ', '01-09-2014': ' ', '02-09-2014': 'X', 'Total': '2'},
  {'NIK': 'A004', 'Nama': 'Hendra', '29-08-2014': 'X', '30-08-2014': ' ',  '31-08-2014': 'X', '01-09-2014': ' ', '02-09-2014': ' ', 'Total': '2'},
];

final List<Map<String, dynamic>> listData2 = [
  {'NIK': 'A001', 'Nama': 'Andi', '201408': '1', '201409': '1', 'Total': '2'},
  {'NIK': 'A002', 'Nama': 'Susi', '201408': '2', '201409': '1', 'Total': '3'},
  {'NIK': 'A003', 'Nama': 'Toni', '201408': '1', '201409': '1', 'Total': '2'},
  {'NIK': 'A004', 'Nama': 'Hendra', '201408': '2', '201409': '0', 'Total': '2'},
];

class tableNomor3 extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('NIK')),
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('29-08-2014')),
              DataColumn(label: Text('30-08-2014')),
              DataColumn(label: Text('31-08-2014')),
              DataColumn(label: Text('01-09-2014')),
              DataColumn(label: Text('02-09-2014')),
              DataColumn(label: Text('Total')),
            ],
            rows: listData.map((data) => DataRow(
              cells: [
                DataCell(Text(data['NIK'].toString())),
                DataCell(Text(data['Nama'].toString())),
                DataCell(Text(data['29-08-2014'].toString())),
                DataCell(Text(data['30-08-2014'].toString())),
                DataCell(Text(data['31-08-2014'].toString())),
                DataCell(Text(data['01-09-2014'].toString())),
                DataCell(Text(data['02-09-2014'].toString())),
                DataCell(Text(data['Total'].toString())),
              ],
            )).toList(),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 1.0),
              ),
          child: DataTable(
            columns: const [
              DataColumn(label: Text('NIK')),
              DataColumn(label: Text('Nama')),
              DataColumn(label: Text('201408')),
              DataColumn(label: Text('201409')),
              DataColumn(label: Text('Total')),
            ],
            rows: listData2.map((data) => DataRow(
              cells: [
                DataCell(Text(data['NIK'].toString())),
                DataCell(Text(data['Nama'].toString())),
                DataCell(Text(data['201408'].toString())),
                DataCell(Text(data['201409'].toString())),
                DataCell(Text(data['Total'].toString())),
              ] 
            )).toList(),
          ),
        ),
        FloatingActionButton(onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => homePage()),);
        },
        child: Icon(Icons.navigate_before),
        ),
      ],
    );
  }
}

