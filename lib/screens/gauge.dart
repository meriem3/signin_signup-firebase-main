import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import'HomeScreen.dart';



class gauge extends StatefulWidget {
  gauge(this.values, {Key? key, this.onValueChanged});
  final List<double> values;
  final ValueChanged<double>? onValueChanged;


  @override
  _gaugeState createState() => _gaugeState();
}

class _gaugeState extends State<gauge> {
  Random? _random;
  static double _value = 10;
  static String _title = '10';

  @override
  void initState() {
    _random = Random();
    Duration _interval = Duration(seconds: 1);
    Stream<double> stream  = Stream<double>.periodic(_interval,getValue);
    stream.listen((data) {
      setState((){
        _value = data;
        _title = _value.toInt().toString() ;
      });
    },);

    super.initState();
  }

  double getValue(int x) {
    return _random!.nextInt(80).toDouble();
  }
  @override
  Widget build(BuildContext context) {
    //var _values;

    return MaterialApp(

        home: Scaffold(
            body: Center(
                child: Container(
                    child: SfRadialGauge(
                        axes: <RadialAxis>[
                          RadialAxis(minimum: 0,maximum: 1000,

                              ranges: <GaugeRange>[
                                GaugeRange(startValue: 0,endValue: 330,color: Colors.green,startWidth: 10,endWidth: 10),
                                GaugeRange(startValue: 330,endValue: 660,color: Colors.orange,startWidth: 10,endWidth: 10),
                                GaugeRange(startValue: 660,endValue: 1024,color: Colors.red,startWidth: 10,endWidth: 10)],
                              pointers: <GaugePointer>[
                                NeedlePointer(value: _value, enableAnimation: true)],

                          )]
                    )
                )
            )
        )
    );
  }
}
