import 'package:flutter/material.dart';

class PrimitiveRoot extends StatefulWidget {
  const PrimitiveRoot({super.key});

  @override
  _PrimitiveRootState createState() => _PrimitiveRootState();
}

class _PrimitiveRootState extends State<PrimitiveRoot> {
  final _formKey = GlobalKey<FormState>();
  final _nController = TextEditingController();
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primitive Root'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nController,
                decoration: const InputDecoration(labelText: 'n'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Enter a number' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calculatePrimitiveRoot,
                child: const Text('Calculate'),
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

  void _calculatePrimitiveRoot() {
    if (_formKey.currentState!.validate()) {
      final n = int.parse(_nController.text);
      final result = _findPrimitiveRoots(n);
      setState(() {
        _result = result.isNotEmpty ? result.join(', ') : 'No primitive root found';
      });
    }
  }

  List<int> _findPrimitiveRoots(int n) {
    if (n <= 1) return [];

    final phi = _phi(n);
    final factors = _factorize(phi);
    final roots = <int>[];

    for (int r = 2; r <= n; r++) {
      bool flag = true;
      for (final factor in factors) {
        if (_modExp(r, phi ~/ factor, n) == 1) {
          flag = false;
          break;
        }
      }
      if (flag) roots.add(r);
    }
    return roots;
  }

  int _phi(int n) {
    int result = n;
    for (int p = 2; p * p <= n; p++) {
      if (n % p == 0) {
        while (n % p == 0) {
          n ~/= p;
        }
        result -= result ~/ p;
      }
    }
    if (n > 1) result -= result ~/ n;
    return result;
  }

  List<int> _factorize(int n) {
    final factors = <int>[];
    for (int i = 2; i * i <= n; i++) {
      if (n % i == 0) {
        factors.add(i);
        while (n % i == 0) {
          n ~/= i;
        }
      }
    }
    if (n > 1) factors.add(n);
    return factors;
  }

  int _modExp(int base, int exp, int mod) {
    int result = 1;
    base = base % mod;
    while (exp > 0) {
      if (exp % 2 == 1) result = (result * base) % mod;
      exp = exp >> 1;
      base = (base * base) % mod;
    }
    return result;
  }
}
