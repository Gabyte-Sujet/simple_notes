import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import './notes.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  static const routeName = '/sign_up';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  var _userData = {
    'fullName': '',
    'eMail': '',
    'password': '',
  };

  void _addUser(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    if (Provider.of<Users>(context, listen: false).isUser(
        _userData['eMail'] as String, _userData['password'] as String)) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('User already exists'),
                content: Text('Try another eMail'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              ));
    } else {
      Provider.of<Users>(context, listen: false).addUser(
          _userData['fullName'] as String,
          _userData['eMail'] as String,
          _userData['password'] as String);
      Navigator.of(context).pushReplacementNamed(Notes.routeName);
    }

    setState(() {}); //for print testing
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    print(_userData);
    print(Provider.of<Users>(context, listen: false).users);

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 8.0,
          child: Container(
            width: deviceSize.width * 0.80,
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'FullName'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Invalid Fullname!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userData['fullName'] = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userData['eMail'] = value!;
                      },
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password is too short!';
                        }
                      },
                      onSaved: (value) {
                        _userData['password'] = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _addUser(context),
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
