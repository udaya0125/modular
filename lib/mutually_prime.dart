import 'package:flutter/material.dart';

class MutuallyPrime extends StatefulWidget {
  const MutuallyPrime({super.key});

  @override
  _MutuallyPrimeState createState() => _MutuallyPrimeState();
}

class _MutuallyPrimeState extends State<MutuallyPrime> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutually Prime Check'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _aController,
                decoration: const InputDecoration(labelText: 'a'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a number' : null,
              ),
              TextFormField(
                controller: _bController,
                decoration: const InputDecoration(labelText: 'b'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkMutuallyPrime,
                child: const Text('Check'),
              ),
              if (_result != null) ...[
                const SizedBox(height: 20),
                Text('Result: $_result'),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _checkMutuallyPrime() {
    if (_formKey.currentState!.validate()) {
      final a = BigInt.parse(_aController.text);
      final b = BigInt.parse(_bController.text);
      final result = _gcd(a, b) == 1;

      setState(() {
        _result = result ? 'Mutually prime' : 'Not mutually prime';
      });
    }
  }

  int _gcd(BigInt a, BigInt b) {
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a;
  }
}
