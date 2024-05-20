import 'package:flutter/material.dart';
import 'modular_division.dart';
import 'primitive_root.dart';
import 'mutually_prime.dart';

void main() {
  runApp(ModularMathApp());
}

class ModularMathApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modular Math App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Modular Math Operations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OperationTile(
              title: 'Modular Division and Remainder Finder',
              description: 'Calculate a / b mod n and find remainder',
              operation: ModularDivision(),
            ),
            OperationTile(
              title: 'Primitive Root',
              description: 'Find primitive roots of n',
              operation: PrimitiveRoot(),
            ),
            OperationTile(
              title: 'Mutually Prime Check',
              description: 'Check if a and b are mutually prime',
              operation: MutuallyPrime(),
            ),
          ],
        ),
      ),
    );
  }
}

class OperationTile extends StatelessWidget {
  final String title;
  final String description;
  final Widget operation;

  OperationTile({required this.title, required this.description, required this.operation});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => operation),
        ),
      ),
    );
  }
}
