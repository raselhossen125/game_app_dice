// ignore_for_file: prefer_const_constructors, unused_element, unused_field, prefer_final_fields, unnecessary_string_interpolations

import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _diceImage = [
    'images/d1.png',
    'images/d2.png',
    'images/d3.png',
    'images/d4.png',
    'images/d5.png',
    'images/d6.png',
  ];

  int _index1 = 0, _index2 = 0, _point = 0, _diceSum = 0;
  String _result = '';
  bool _hasGameStarted = false;
  bool _isGameOver = false;
  final _random = Random.secure();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game'),
      ),
      body: Center(
        child: _hasGameStarted ? _gameWidget() : _startWidget(),
      ),
    );
  }

  Widget _startWidget() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _hasGameStarted = true;
        });
      },
      child: Container(
        height: 45,
        width: 130,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: Colors.deepOrange),
        child: Center(
          child: Text(
            'Start Game',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _gameWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              _diceImage[_index1],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 20,
            ),
            Image.asset(
              _diceImage[_index2],
              height: 100,
              width: 100,
              fit: BoxFit.cover,
            ),
          ],
        ),
        ElevatedButton(
          onPressed: _isGameOver ? null : _theRollDevice,
          child: Text(
            'Roll',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          'Sum : $_diceSum',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        if (_point > 0)
          Text(
            'Point : $_point',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange),
          ),
        if (_isGameOver)
          Text(
            '$_result',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
          ),
        if (_isGameOver)OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              side: BorderSide(color: Colors.green),
            ),
            onPressed: _reset,
            child: Text(
              'Play Again',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
      ],
    );
  }

  void _theRollDevice() {
    setState(() {
      _index1 = _random.nextInt(6);
      _index2 = _random.nextInt(6);
      _diceSum = _index1 + _index2 + 2;
      if (_point > 0) {
        _secondThrow();
      } else {
        _firstThrow();
      }
    });
  }

  void _firstThrow() {
    switch (_diceSum) {
      case 7:
      case 11:
        _result = "You are won the game!!";
        _isGameOver = true;
        break;
      case 2:
      case 3:
      case 12:
        _result = "You are loss the game!!";
        _isGameOver = true;
        break;
      default:
        _point = _diceSum;
        break;
    }
  }

  void _secondThrow() {
    if (_diceSum == _point) {
      _result = "You are won the game!!";
      _isGameOver = true;
    } else if (_diceSum == 7) {
      _result = "You are loss the game!!";
      _isGameOver = true;
    }
  }

  void _reset() {
    setState(() {
      _index1 = 0;
      _index2 = 0;
      _point = 0;
      _diceSum = 0;
      _hasGameStarted = false;
      _isGameOver = false;
    });
  }
}
