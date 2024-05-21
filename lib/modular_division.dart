import 'package:flutter/material.dart';

class ModularDivision extends StatefulWidget {
  const ModularDivision({super.key});

  @override
  _ModularDivisionState createState() => _ModularDivisionState();
}

class _ModularDivisionState extends State<ModularDivision> {
  final _formKey = GlobalKey<FormState>();
  final _aController = TextEditingController();
  final _bController = TextEditingController();
  final _nController = TextEditingController();
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modular Division and Remainder Finder'),
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
                decoration: const InputDecoration(labelText: 'b (for division)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a number' : null,
              ),
              TextFormField(
                controller: _nController,
                decoration: const InputDecoration(labelText: 'n (modulus)'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculateModularDivision,
                child: const Text('Calculate Division'),
              ),
              ElevatedButton(
                onPressed: _calculateRemainder,
                child: const Text('Find Remainder'),
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
void _calculateModularDivision() {
  if (_formKey.currentState!.validate()) {
    final a = BigInt.parse(_aController.text);
    final b = BigInt.parse(_bController.text);
    final n = BigInt.parse(_nController.text);

    final bInverse = _modInverse(b, n);
    if (bInverse == null) {
      setState(() {
        _result = 'No modular inverse exists for b under modulo n';
      });
    } else {
      final result = (a * bInverse) % n;
      setState(() {
        _result = 'Division Result: $result';
      });
    }
  }
}

void _calculateRemainder() {
  if (_formKey.currentState!.validate()) {
    final a = BigInt.parse(_aController.text);
    final n = BigInt.parse(_nController.text);

    final result = _mod(a, n);
    setState(() {
      _result = 'Remainder: $result';
    });
  }
}

BigInt _mod(BigInt a, BigInt n) {
  BigInt result = a % n;
  if (result < BigInt.zero) {
    result += n;
  }
  return result;
}

BigInt? _modInverse(BigInt b, BigInt n) {
  BigInt t = BigInt.zero, newT = BigInt.one;
  BigInt r = n, newR = b;

  while (newR != BigInt.zero) {
    BigInt quotient = r ~/ newR;
    BigInt temp = t;
    t = newT;
    newT = temp - quotient * newT;
    BigInt tempR = r;
    r = newR;
    newR = tempR - quotient * newR;
  }

  if (r > BigInt.one) return null;
  if (t < BigInt.zero) t += n;
  return t;
}