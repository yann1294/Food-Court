import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  
  final Map<String, dynamic> _loginData = {
      'email':null,
      'Password':null,
      'acceptTerms': false
  };
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();
  
  DecorationImage _buildBackgroundImage(){
    return DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.3),
              BlendMode.dstATop
              ),
            image: AssetImage('assets/background.jpg')
          );
  }

  Widget _buildEmailTextField(){
    return TextFormField(
              decoration: InputDecoration(
                labelText: 'E-Mail',
                filled: true,
                fillColor: Colors.white
                ),
              keyboardType: TextInputType.emailAddress,
              validator: (String value){
                if(value.isEmpty || 
                !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)){
                  return 'Email is invalid!Please try again!';
                }
              },
              onSaved: (String value){
                _loginData['email'] = value;
              },
            );
  }

  Widget _buildPasswordTextField(){
    return TextFormField(
              decoration: InputDecoration(
                labelText: 'Password',
                fillColor: Colors.white,
                filled: true
                ),
              obscureText: true,
              validator: (String value){
                if(value.isEmpty || value.length < 5){
                  return 'Password is required and must be 5+ characters';
                }
              },
              onSaved: (String value){
                _loginData['Password'] = value;
              },
            );
  }

  Widget _buildAcceptSwitch(){
    return SwitchListTile(
      value: _loginData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _loginData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

  void _submitForm(){

                if(!_loginKey.currentState.validate() || !_loginData['acceptTerms']){
                  return;
                }
                _loginKey.currentState.save();
                print(_loginData);
                Navigator.pushReplacementNamed(context, '/products');
              
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 768.0 ? 500.0 :deviceWidth * 0.95;

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: _buildBackgroundImage(),
        ),
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: GestureDetector(
            onTap: (){
              FocusScope.of(context).requestFocus(FocusNode());
            },
              child: SingleChildScrollView(
              child: Container(
                width: targetWidth,
                child: Form(
                  key: _loginKey,
                  child: Column(
                    children: <Widget>[
                      _buildEmailTextField(),
                      SizedBox(
                        height: 10.0,
                      ),
                      _buildPasswordTextField(),
                      _buildAcceptSwitch(),
                      SizedBox(
                        height: 10.0,
                      ),
                      RaisedButton(
                        textColor: Colors.white,
                        child: Text('LOGIN'),
                        onPressed: _submitForm,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    }
}
