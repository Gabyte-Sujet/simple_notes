import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import './notes.dart';

import './sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  static const routeName = '/sign_in';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var usr = {
    'email': '',
    'password': '',
  };

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();

    if (Provider.of<Users>(context, listen: false)
        .isUser(usr['email'] as String, usr['password'] as String)) {
      Navigator.of(context).pushNamed(Notes.routeName);
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text('Incorrect Mail or Password'),
                content: Text('Try again or Register'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('OK'))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in'),
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
                      decoration: InputDecoration(labelText: 'E-Mail'),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        usr['email'] = value!;
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
                        usr['password'] = value!;
                      },
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _submit(context),
                      child: Text('Sign In'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignUp.routeName);
                      },
                      child: Text('Register'),
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
