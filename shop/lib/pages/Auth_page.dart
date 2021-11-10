import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shop/Components/Auth_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
                  Theme.of(context).colorScheme.secondary.withOpacity(0.5)
                ]
              )
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 0, 15),
                      padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 70),
                      transform: Matrix4.rotationZ(-8 * pi / 180)..translate(-10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrange.shade900,
                        boxShadow:  const [ 
                          BoxShadow(
                            blurRadius: 8,
                            offset: Offset(0,5),
                            color: Colors.black87,
                          )
                        ]
                      ),
                      child: Text('Minha Loja',
                        style: TextStyle(
                          fontSize: 45,
                          fontFamily: 'Anton',
                          color: Theme.of(context).primaryTextTheme.headline6?.color
                        ),
                      ),
                    ),
                    const AuthForm()
                  ],
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}