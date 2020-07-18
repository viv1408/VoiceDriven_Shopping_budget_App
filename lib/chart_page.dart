import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChartPage extends StatefulWidget {
  final Widget child;
  static String tag = 'chart-page';
  ChartPage({Key key, this.child}) : super(key: key);

  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  List<charts.Series<Pollution, String>> _seriesData;
  List<charts.Series<Task, String>> _seriesPieData;
  List<charts.Series<Sales, int>> _seriesLineData;

  _generateData() {
    var data1 = [
      new Pollution(5, 'Vishal', 350),
      new Pollution(5, 'Maha',750 ),
      new Pollution(5, 'Nonstop', 400),
    ];
    var data2 = [
      new Pollution(4, 'Vishal', 450),
      new Pollution(4, 'Maha', 650),
      new Pollution(4, 'Nonstop', 450),
    ];
    var data3 = [
      new Pollution(3, 'Vishal', 750),
      new Pollution(3, 'Maha', 750),
      new Pollution(3, 'Nonstop', 300),
    ];

    var piedata = [
      new Task('Vishal', 20.13, Color(0xff3366cc)),
      new Task('Maha', 27.92, Color(0xff990099)),
      new Task('Ramji', 25.32, Color(0xff109618)),
      new Task('Non stop', 13, Color(0xfffdbe19)),
      new Task('Hanuman', 5.82, Color(0xffff9900)),
      new Task('Sai', 7.81, Color(0xffdc3912)),
    ];

    // var linesalesdata = [
    //   new Sales(0, 45),
    //   new Sales(1, 56),
    //   new Sales(2, 55),
    //   new Sales(3, 60),
    //   new Sales(4, 61),
    //   new Sales(5, 70),
    // ];
    var linesalesdata1 = [
      new Sales(0, 300),
      new Sales(1, 750),
      new Sales(2, 750),
      new Sales(3, 550),
      new Sales(4, 600),
      new Sales(5, 450),
      new Sales(6, 650),
      new Sales(7, 450),
      new Sales(8, 300),
      new Sales(9, 400),
      new Sales(10, 1400),
      new Sales(11, 750),
      new Sales(12, 350),
    ];

    var linesalesdata2 = [
      new Sales(0, 800),
      new Sales(1, 900),
      new Sales(2, 800),
      new Sales(3, 500),
      new Sales(4, 500),
      new Sales(5, 500),
      new Sales(6, 700),
      new Sales(7, 600),
      new Sales(8, 800),
      new Sales(9, 500),
      new Sales(10, 500),
      new Sales(11, 900),
      new Sales(12, 500),
    ];

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2017',
        data: data1,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
            charts.ColorUtil.fromDartColor(Color(0xff990099)),
      ), 
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2018',
        data: data2,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
        fillColorFn: (Pollution pollution, _) =>
           charts.ColorUtil.fromDartColor(Color(0xff109618)),
      ),
    );

    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: '2019',
        data: data3,
        fillPatternFn: (_, __) => charts.FillPatternType.solid,
       fillColorFn: (Pollution pollution, _) =>
          charts.ColorUtil.fromDartColor(Color(0xffff9900)),
      ),
    );

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
         labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );

    // _seriesLineData.add(
    //   charts.Series(
    //     colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff990099)),
    //     id: 'Air Pollution',
    //     data: linesalesdata,
    //     domainFn: (Sales sales, _) => sales.yearval,
    //     measureFn: (Sales sales, _) => sales.salesval,
    //   ),
    // );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xff3366cc)),
        id: 'Air Pollution',
        data: linesalesdata1,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
    _seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.ColorUtil.fromDartColor(Color(0xffff9900)),
        id: 'Air Pollution',
        data: linesalesdata2,
        domainFn: (Sales sales, _) => sales.yearval,
        measureFn: (Sales sales, _) => sales.salesval,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesData = List<charts.Series<Pollution, String>>();
    _seriesPieData = List<charts.Series<Task, String>>();
    _seriesLineData = List<charts.Series<Sales, int>>();
    _generateData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1976d2),
            //backgroundColor: Color(0xff308e1c),
            bottom: TabBar(
              indicatorColor: Color(0xff9962D0),
              tabs: [
                Tab(
                  icon: Icon(FontAwesomeIcons.solidChartBar),
                ),
                Tab(icon: Icon(FontAwesomeIcons.chartPie)),
                Tab(icon: Icon(FontAwesomeIcons.chartLine)),
              ],
            ),
            title: Text('budget analysis'),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            '3 month comparison',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.BarChart(
                            _seriesData,
                            animate: true,
                            barGroupingType: charts.BarGroupingType.grouped,
                            //behaviors: [new charts.SeriesLegend()],
                            animationDuration: Duration(seconds: 5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Spending comparison',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                            SizedBox(height: 10.0,),
                        Expanded(
                          child: charts.PieChart(
                            _seriesPieData,
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                             behaviors: [
                            new charts.DatumLegend(
                              outsideJustification: charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                              entryTextStyle: charts.TextStyleSpec(
                                  color: charts.MaterialPalette.purple.shadeDefault,
                                  fontFamily: 'Georgia',
                                  fontSize: 11),
                            )
                          ],
                           defaultRenderer: new charts.ArcRendererConfig(
                              arcWidth: 100,
                             arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.inside)
        ])),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Text(
                            'Budget Comparison',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        Expanded(
                          child: charts.LineChart(
                            _seriesLineData,
                            defaultRenderer: new charts.LineRendererConfig(
                                includeArea: true, stacked: false),
                            animate: true,
                            animationDuration: Duration(seconds: 5),
                            behaviors: [
        new charts.ChartTitle('Comp. of past 3 months',
            behaviorPosition: charts.BehaviorPosition.bottom,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Spending per shop',
            behaviorPosition: charts.BehaviorPosition.start,
            titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
        new charts.ChartTitle('Budget vs spending comarison',
            behaviorPosition: charts.BehaviorPosition.end,
            titleOutsideJustification:charts.OutsideJustification.middleDrawArea,
            )   
      ]
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pollution {
  String place;
  int month;
  int quantity;

  Pollution(this.month, this.place, this.quantity);
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class Sales {
  int yearval;
  int salesval;

  Sales(this.yearval, this.salesval);
}
