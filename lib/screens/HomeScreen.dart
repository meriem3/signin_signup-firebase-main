 import 'package:flutter/material.dart';
 import 'package:flutter_blue/flutter_blue.dart';
 import 'dart:convert';
 import'screens.dart';
 import 'package:firebase_database/firebase_database.dart';
 import 'package:firebase_core/firebase_core.dart';
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = [];
  final Map<Guid, List<int>> readValues = new Map<Guid, List<int>>();


  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
  }

  class _MyHomePageState extends State<HomeScreen> {
    final _writeController = TextEditingController();
    BluetoothDevice? _connectedDevice;
    List<BluetoothService> _services=[];

    final databaseRef = FirebaseDatabase.instance.reference();
    void addData(data) {
      databaseRef.push().set({'value': data, 'comment': 'A good season'});
    }

       _addDeviceTolist(final BluetoothDevice device) {
         if (!widget.devicesList.contains(device)) {
           setState(() {
             widget.devicesList.add(device);
           });
         }
       }
       @override
       void initState() {
         super.initState();
         widget.flutterBlue.connectedDevices
             .asStream()
             .listen((List<BluetoothDevice> devices) {
               for (BluetoothDevice device in devices) {
                 _addDeviceTolist(device);
               }
             });
         widget.flutterBlue.scanResults.listen((List<ScanResult> results) {
           for (ScanResult result in results) {
             _addDeviceTolist(result.device);
           }
         });
         widget.flutterBlue.startScan();
       }
       ListView _buildListViewOfDevices() {
         List<Container> containers = [];
         for (BluetoothDevice device in widget.devicesList) {
           containers.add(
             Container(
               height: 50,
               child: Row(
                 children: <Widget>[
                   Expanded(
                     child: Column(
                       children: <Widget>[
                         Text(device.name == '' ? '(unknown device)' : device.name),
                         Text(device.id.toString()),
                       ],
                     ),
                   ),
                   ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       primary: Colors.cyanAccent, // background
                       onPrimary: Colors.white,
                     ),
                     child: Text('Connect',
                       style: TextStyle(color: Colors.white),),
                     onPressed: () async {
                       widget.flutterBlue.stopScan();
                       try {
                         await device.connect();
                       } catch (e) {
                        //if (e.code != 'already_connected') {
                          // throw e;}
                       } finally {
                         _services = await device.discoverServices();
                       }
                       setState(() {
                         _connectedDevice = device;
                       });
                       },
                   ),
                 ],
               ),
             ), );
         }
         return ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
  ...containers,
  ],
  );
  }
  List<ButtonTheme> _buildReadWriteNotifyButton(
  BluetoothCharacteristic characteristic) {
  List<ButtonTheme> buttons = [];

  if (characteristic.properties.notify) {
    buttons.add(
      ButtonTheme(
        minWidth: 10,
        height: 20, child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: ElevatedButton(
          child: Text('NOTIFY', style: TextStyle(color: Colors.white)),
          onPressed: () async {
            characteristic.value.listen((value) {
              setState(() {
                final data =characteristic.uuid;
                widget.readValues[data] = value;

              }
              );
            });

            await characteristic.setNotifyValue(true);
  },
  ),
  ),
  ),);
  buttons.add(
        ButtonTheme(
          minWidth: 10,
          height: 20,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
              child: Text('Visualize', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                var j;
                final data = widget.readValues[characteristic.uuid];
                final datab=data!.map((i) => i.toDouble()).toList();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => gauge(datab)));
                  })
                ),),);
    buttons.add(
      ButtonTheme(
        minWidth: 10,
        height: 20,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: ElevatedButton(
                child: Text('historical', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => chart()));
                })
        ),),);

              };
  return buttons;
  }

  ListView _buildConnectDeviceView() {
  List<Container> containers = [];

  for (BluetoothService service in _services) {
  List<Widget> characteristicsWidget = [];

  for (BluetoothCharacteristic characteristic in service.characteristics) {
  characteristicsWidget.add(
  Align(
  alignment: Alignment.centerLeft,
    child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Text(characteristic.uuid.toString(),
            style: TextStyle(fontWeight: FontWeight.bold)),
          ],),
        Row(
          children: <Widget>[
            ..._buildReadWriteNotifyButton(characteristic),
          ],),
        Row(
          children: <Widget>[
            Text('Value: '+widget.readValues[characteristic.uuid].toString()),
          ],
        ),

        Divider(),
      ],),
  ),);}
  containers.add(
    Container(
      child: ExpansionTile(
          title: Text(service.uuid.toString()),
          children: characteristicsWidget),
    ),


  );
  }


  return ListView(
  padding: const EdgeInsets.all(8),
  children: <Widget>[
  ...containers,
  ],
  );
  }


  ListView _buildView() {
         if (_connectedDevice != null) {
           return _buildConnectDeviceView();
         }
         return _buildListViewOfDevices();
       }
       @override
       Widget build(BuildContext context) => Scaffold(
         appBar: AppBar(
           title: Text(widget.title),
         ),
         body: _buildView(),);
}

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
