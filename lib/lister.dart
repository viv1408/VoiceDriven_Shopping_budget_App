import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/languages.dart';
import 'package:flutter_app/transcriptor.dart';
import 'main.dart';
import 'budget_set.dart';
import 'dart:async';
import 'dart:convert';
import 'places_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_app/languages.dart';
import 'package:flutter_app/recognizer.dart';
import 'package:flutter_app/task.dart';
import 'package:flutter_app/lister.dart';


/* class pushApp
{
double price;
double rating;
pushApp(double rating,double price)
{
print(price);
this.price=price;

}
} */

String tname='abc';
var str=[];
double price=0;
double current=0;
double quantity=0;
String product='--';
String quant='--';
int i=0;
int len=0;
List<String> dataproduct = new List(5); 
List<double> dataquantity = new List(5);
List<double> dataprice = new List(5);
int k=0;
String currplace = "";

class ListerApp extends StatefulWidget {

  ListerApp(double rating,String placename);
  
 
  @override
  State<StatefulWidget> createState() => new ListerAppState();

  static void addcurrent(double price) {}
}

class ListerAppState extends State<ListerApp> {
  Language selectedLang = languages.first;
 
  @override
  Widget build(BuildContext context) {
    

  return Scaffold(
        appBar: new AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FlatButton(onPressed: addcurrent,child: Icon(Icons.add),),
        ),
        
                  title: Text('List'),
                  backgroundColor: Colors.blueGrey,
                  actions: <Widget>[
                    Center(child: FlatButton(onPressed:() {Navigator.push(context,MaterialPageRoute(builder: (context)=> Episode5()) ) ;} ,child: Icon(Icons.shopping_cart),))
                    ,
                    Center(
                
                  child: 
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("RS ${current.round()}",
                            style: TextStyle(fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: current>rating?Colors.black:current>0.75*rating?Colors.red:current>0.50*rating?Colors.orange:Colors.green),),
                  ),
                
              ),
                      
                      Center(
                
                          child: Text("RS ${rating.round()}",
                          style: TextStyle(fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)
                          ),
                
                      ),
                    new PopupMenuButton<Language>(
                      onSelected: _selectLangHandler,
                      itemBuilder: (BuildContext context) => _buildLanguagesWidgets,
                    ),
                   // FlatButton(onPressed: popfunc,child:Text('Back'),),
                  ]),
                body:
                new TranscriptorWidget(lang: selectedLang),

                
                     );
          }
        
          List<CheckedPopupMenuItem<Language>> get _buildLanguagesWidgets => languages
            .map((l) => new CheckedPopupMenuItem<Language>(
            value: l,
            checked: selectedLang == l,
            child: new Text(l.name),
          ))
            .toList();
        
          void _selectLangHandler(Language lang) {
            setState(() => selectedLang = lang);
          }
        
        
        
          void addcurrent() {
            
            setState(() {
             current=current+price; 
               dataprice[i-1]=price;

             if(current>rating)
             {
                              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                   title: Text('YOU ARE OVER BUDGET'),
            
            
                  actions: <Widget>[
                    Center(
                      
                        child: FlatButton(
                          child: Text('OK'),
                          onPressed: () => Navigator.pop(context, 'OK'),
                        ),
                      
                    )]));

             }
             

            });
  }
}
































class TranscriptorWidget extends StatefulWidget {
  final Language lang;

  TranscriptorWidget({this.lang});

  @override
  _TranscriptorAppState createState() => new _TranscriptorAppState();
}

class _TranscriptorAppState extends State<TranscriptorWidget> {
   String transcription = '';


  bool authorized = false;

  bool isListening = false;

  List<Task> todos = [];

  bool get isNotEmpty => transcription != '';



  get numArchived => todos.where((t) => t.complete).length;
  Iterable<Task> get incompleteTasks => todos.where((t) => !t.complete);

    void parsecomplete(Task completed) {

      setState(() {
       tname= completed.label; 
       
       str=tname.split(" ");
      
       len = str.length;
});      
       if(len<4)
          {
            setState(() {
            quant=str[len-1];
            quantity=double.parse(str[len-2]);
            product=str[0];            
            showdialogbox();
  //dataprice[i]=price;
  dataproduct[i]=product;
  dataquantity[i]=quantity;
  i=i+1;

            });                  
}
      else if(len>4)
       {
         setState(() {
                  price=double.parse(str[len-2]);
       quant=str[len-3];
       quantity=double.parse(str[len-4]);
       product=str[0];
       for(int j=1;j<=len-5;j++)
       {
       product=product+' '+str[j];  
       }
    //  dataprice[i]=price;
  dataproduct[i]=product;
  dataquantity[i]=quantity;
  i=i+1; 
         });
       
       //current=current+price;
       }
      // var str=[];
      // str=tname.split(" ");
      //  price=str[0];
 //      ListerAppState().addcurrent();

    }

void showdialogbox()
{
            showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                   title: Text('Add price'),
            content: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Enter price for $product',border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
            onSubmitted: (String val)
            {
              setState(() {

                              price=double.parse(val);
                          
              
              });

            },

            )))
            ;


}


  @override
  void initState() {
    super.initState();
    SpeechRecognizer.setMethodCallHandler(_platformCallHandler);
    _activateRecognition();
  }

  @override
  void dispose() {
    super.dispose();
    if (isListening) _cancelRecognitionHandler();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> blocks = [
      new Expanded(
          flex: 2,
          child: new ListView(
              children: incompleteTasks
                  .map((t) => _buildTaskWidgets(
                      task: t,
                      onDelete: () => _deleteTaskHandler(t),
                      onComplete: () => _completeTaskHandler(t)))
                  .toList())),
      _buildButtonBar(),
    ];
    if (isListening || transcription != '')
      blocks.insert(
          1,
          _buildTranscriptionBox(
              text: transcription,
              onCancel: _cancelRecognitionHandler,
              width: size.width - 20.0));
    return new Center(
        child: new Column(mainAxisSize: MainAxisSize.min, children: blocks));
  }

  void _saveTranscription() {
    if (transcription.isEmpty) return;
    setState(() {
      todos.add(new Task(
          taskId: new DateTime.now().millisecondsSinceEpoch,
          label: transcription));
      transcription = '';
    });
    _cancelRecognitionHandler();
  }

  Future _startRecognition() async {
    final res = await SpeechRecognizer.start(widget.lang.code);
    if (!res)
      showDialog(
          context: context,
          child: new SimpleDialog(title: new Text("Error"), children: [
            new Padding(
                padding: new EdgeInsets.all(12.0),
                child: const Text('Recognition not started'))
          ]));
  }

  Future _cancelRecognitionHandler() async {
    final res = await SpeechRecognizer.cancel();

    setState(() {
      transcription = '';
      isListening = res;
    });
  }

  Future _activateRecognition() async {
    final res = await SpeechRecognizer.activate();
    setState(() => authorized = res);
  }

  Future _platformCallHandler(MethodCall call) async {
    switch (call.method) {
      case "onSpeechAvailability":
        setState(() => isListening = call.arguments);
        break;
      case "onSpeech":
        if (todos.isNotEmpty) if (transcription == todos.last.label) return;
        setState(() => transcription = call.arguments);
        break;
      case "onRecognitionStarted":
        setState(() => isListening = true);
        break;
      case "onRecognitionComplete":
        setState(() {
          if (todos.isEmpty) {
            transcription = call.arguments;
          } else if (call.arguments == todos.last?.label)
            // on ios user can have correct partial recognition
            // => if user add it before complete recognition just clear the transcription
            transcription = '';
          else
            transcription = call.arguments;
        });
        break;
      default:
        print('Unknowm method ${call.method} ');
    }
  }

  void _deleteTaskHandler(Task t) {
    
    setState(() {
      todos.remove(t);
       _showStatus2("removed");
    });
  }

  void _completeTaskHandler(Task completed) {
    
        parsecomplete(completed);
       
        setState(() {
          
          todos =
              todos.map((t) => completed == t ? (t..complete = true) : t).toList();
          
            
          _showStatus("Purchased");
           
          //ListerApp(0.0, price);
          

          //Navigator.push(context, MaterialPageRoute(builder: (context)=> ListerApp(0.0,price)));
        });
      }
    
      Widget _buildButtonBar() {
        List<Widget> buttons = [
          !isListening
              ? _buildIconButton(authorized ? Icons.mic : Icons.mic_off,
                  authorized ? _startRecognition : null,
                  color: Colors.white, fab: true)
              : _buildIconButton(Icons.add, isListening ? _saveTranscription : null,
                  color: Colors.white,
                  backgroundColor: Colors.greenAccent,
                  fab: true),
        ];
        Row buttonBar = new Row(mainAxisSize: MainAxisSize.min, children: buttons);
        return buttonBar;
      }
    
      Widget _buildTranscriptionBox(
              {String text, VoidCallback onCancel, double width}) =>
          new Container(
              width: width,
              color: Colors.grey.shade200,
              child: new Row(children: [
                new Expanded(
                    child: new Padding(
                        padding: new EdgeInsets.all(8.0), child: new Text(text))),
                new IconButton(
                    icon: new Icon(Icons.close, color: Colors.grey.shade600),
                    onPressed: text != '' ? () => onCancel() : null),
              ]));
    
      Widget _buildIconButton(IconData icon, VoidCallback onPress,
          {Color color: Colors.grey,
          Color backgroundColor: Colors.pinkAccent,
          bool fab = false}) {
        return new Padding(
          padding: new EdgeInsets.all(12.0),
          child: fab
              ? new FloatingActionButton(
                  child: new Icon(icon),
                  onPressed: onPress,
                  backgroundColor: backgroundColor)
              : new IconButton(
                  icon: new Icon(icon, size: 32.0),
                  color: color,
                  onPressed: onPress),
        );
      }
    
      Widget _buildTaskWidgets(
          {Task task, VoidCallback onDelete, VoidCallback onComplete}) {
        return new TaskWidget(
            label: task.label, onDelete: onDelete, onComplete: onComplete);
      }
    
      void _showStatus(String action) {
        final label = " $quantity $quant of $product  is $action ";
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(label)));
      }

       void _showStatus2(String action) {
        final label = " Item deleted from the list";
        Scaffold.of(context).showSnackBar(new SnackBar(content: new Text(label)));
      }
    }
    
class Episode5 extends StatefulWidget {
  @override
  Episode5State createState() {
    return new Episode5State();
  }
}

class Episode5State extends State<Episode5> {
  Widget bodyData() => DataTable(
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("Product"),
          numeric: false,
          
          tooltip: "To display  name of the Product",
        ),
        DataColumn(
          label: Text("Quantity"),
          numeric: true,
         
          tooltip: "To display Quantity of the product",
        ),
         DataColumn(
          label: Text("Price"),
          numeric: true,
         
          tooltip: "To display price of the product",
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
                  cells: [
                    DataCell(
                      Text(name.product),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(name.quantity.toStringAsFixed(1)),
                      showEditIcon: false,
                      placeholder: false,
                    ),
                    DataCell(
                      Text(name.price.toStringAsFixed(1)),
                      showEditIcon: false,
                      placeholder: false,
                    )
                  ],
                ),
          )
          .toList());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        actions: <Widget>[Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Rs.$current',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 24.0)),
          ),
        ),
        RaisedButton(
          child:Text("view order history"),
          onPressed:  (){
                              Navigator.push(
                                context, 
                                MaterialPageRoute(
                                  builder:(context)=>ListerApp(rating,placename)));
                            },

        ),],
      ),
      body: Container(
        child: bodyData(),
      ),
    );
  }
}

class Name {
  String product;
  double quantity;
  double price;

  Name({this.product, this.quantity,this.price});
}



var names = <Name>[
  Name(product: dataproduct[0],quantity: dataquantity[0],price: dataprice[0]),
  
];


/* 
class DataTableExample extends StatefulWidget {
  const DataTableExample({Key key}) : super(key: key);

  @override
  _DataTableExampleState createState() => _DataTableExampleState();
}

class _DataTableExampleState extends State<DataTableExample> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        header: Text('Cart'),
        rowsPerPage: _rowsPerPage,
        availableRowsPerPage: <int>[1, 5, 10],
        onRowsPerPageChanged: (int value) {
          setState(() {
            _rowsPerPage = value;
            tableval();
          });
        },
        columns: kTableColumns,
        source: CartDataSource(),
      ),
    );
  }
}

////// Columns in table.
const kTableColumns = <DataColumn>[
  DataColumn(
    label: const Text('Product'),
  ),
  DataColumn(
    label: const Text('Quantity'),
       numeric: true,
  ),
  DataColumn(
    label: const Text('Price'),
    numeric: true,
  ),
  
];

////// Data class.
class Cart {
  Cart(this.product, this.quantity, this.price);
  final String product;
  final double quantity;
  final double price;
  bool selected = false;


}

List<Cart> _carts = <Cart>[];


////// Data source class for obtaining row data for PaginatedDataTable.
class CartDataSource extends DataTableSource {
  int _selectedCount = 0;

    
   
   

  


  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _carts.length) return null;
    final Cart cart = _carts[index];
    return DataRow.byIndex(
        index: index,
        selected: cart.selected,
        onSelectChanged: (bool value) {
          if (cart.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            cart.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${cart.product}')),
          DataCell(Text('${cart.quantity}')),
          DataCell(Text('${cart.price}')),          
        ]);
  }

  @override
  int get rowCount => _carts.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}



void tableval()
{
while(k<=i)
{
  String prod=dataproduct[k];
  double quan=dataquantity[k];
  double pri=dataprice[k];
  
  _carts.add(new Cart(prod,quan,pri)) ;
k++;
}

}
 */

