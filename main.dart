import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController(); //controlador para o recebimento do valor de peso
  TextEditingController heightController = TextEditingController(); //controlador para o recebimento do valor da altura

  GlobalKey<FormState> _formkey =  GlobalKey<FormState>();


  String _infoText = "Informe seus dados";

  void _resetFields(){
    weightController.text = "";
    heightController.text = "";

    setState(() {

      _infoText = "Informe seus dados";
      _formkey = GlobalKey<FormState>();

    }); // recriando campos de mensagens

  } // função para apagar campos de texto

  void calculate(){

    setState(() {

      double weight = double.parse(weightController.text), height = double.parse(heightController.text), imc =  weight / (height*height);

      if ( imc < 18.5){
        _infoText = "Você está abaixo do peso(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      } if ( imc >= 18.5 && imc <= 24.9 ){
        _infoText = "Você está no peso ideal(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      }if ( imc > 24.9 && imc <= 29.9){
        _infoText = "Você levemente acima do peso(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      }if ( imc > 29.9 && imc <= 34.9){
        _infoText = "Você possui obesidade grau I(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      }if ( imc > 34.9 && imc <= 39.9){
        _infoText = "Você possui obesidade grau II(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      }if ( imc >= 40.0){
        _infoText = "Você possui obesidade grau III(${imc.toStringAsPrecision(4)})"; // mostrar apenas 4 digitos
      } // && = conectivo lógico E


    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Color(0xff00BFFF), //or Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _resetFields,
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0 , 10.0, 0.0),
        child: Form(
          key: _formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(Icons.person_outline,size: 100.0, color: Color(0xff00BFFF),),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Peso (kg)",
                    labelStyle: TextStyle(color: Color(0xff00BFFF))
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff00BFFF), fontSize: 20.0),
                controller: weightController,
                validator: (value) {
                if ( value.isEmpty){
                  return "Insira seu Peso";
                }
                },
              ),
              TextFormField(keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelText: "Altura (m)",
                    labelStyle: TextStyle(color: Color(0xff00BFFF))
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff00BFFF), fontSize: 20.0),
                controller: heightController,
                validator: (value) {
                  if ( value.isEmpty){
                    return "Insira sua altura";
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
                child: Container(
                  height: 60.0,
                  child: RaisedButton(
                    onPressed: (){
                      if (_formkey.currentState.validate()){
                        calculate();
                      }
                    },
                    child: Text("Calcular",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    ),
                    color: Color(0xff00BFFF),
                  ),
                ),
              ),
              Text(_infoText,
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xff00BFFF), fontSize: 20.0),
              )
            ],
          ),
        )
      )
    );
  }
}


