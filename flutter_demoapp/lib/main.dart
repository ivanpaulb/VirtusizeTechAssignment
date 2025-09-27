import 'package:flutter/material.dart';
import 'virtusize_sdk.dart';

void main() => runApp(const VirtusizeApp());

class VirtusizeApp extends StatelessWidget {
  const VirtusizeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const BodyInputScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}

class BodyInputScreen extends StatefulWidget {
  const BodyInputScreen({super.key});

  @override
  State<BodyInputScreen> createState() => _BodyInputScreenState();
}

class _BodyInputScreenState extends State<BodyInputScreen> {
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  Future<void> _calculate() async {
    final height = double.tryParse(_heightController.text) ?? 0;
    final weight = double.tryParse(_weightController.text) ?? 0;

    final size = await VirtusizeSDK.getRecommendedSize(
      heightCm: height,
      weightKg: weight,
    );

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResultScreen(size: size),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Find Your Perfect Fit")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _heightController,
              decoration: const InputDecoration(labelText: "Height (cm)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: const InputDecoration(labelText: "Weight (kg)"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculate,
              child: const Text("Get Size Recommendation"),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final String size;
  const ResultScreen({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Your Recommended Size: $size",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text("Based on your info, size $size is recommended."),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
