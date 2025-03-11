import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculator());
}

class BMICalculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0A0E21),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isMale = true;
  double height = 150;
  int weight = 60;
  int age = 26;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"), backgroundColor: Color(0xFF0A0E21)),
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                genderCard("Male", Icons.male, true),
                genderCard("Female", Icons.female, false),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF1D1E33),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Height", style: TextStyle(fontSize: 20, color: Colors.white)),
                  Text("${height.toInt()} cm", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                  Slider(
                    value: height,
                    min: 100,
                    max: 220,
                    activeColor: Colors.pink,
                    onChanged: (value) {
                      setState(() {
                        height = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                counterCard("Weight", weight, () => setState(() => weight++), () => setState(() => weight--)),
                counterCard("Age", age, () => setState(() => age++), () => setState(() => age--)),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              double bmi = weight / ((height / 100) * (height / 100));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ResultScreen(bmi: bmi)),
              );
            },
            child: Container(
              color: Colors.pink,
              width: double.infinity,
              height: 60,
              child: Center(
                child: Text("Calculate", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded genderCard(String gender, IconData icon, bool male) {
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => isMale = male),
        child: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: isMale == male ? Colors.pink : Color(0xFF1D1E33),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 80, color: Colors.white),
              Text(gender, style: TextStyle(fontSize: 20, color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Expanded counterCard(String label, int value, VoidCallback increment, VoidCallback decrement) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFF1D1E33),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: TextStyle(fontSize: 20, color: Colors.white)),
            Text("$value", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(heroTag: label+"-", mini: true, backgroundColor: Colors.pink, child: Icon(Icons.remove), onPressed: decrement),
                SizedBox(width: 10),
                FloatingActionButton(heroTag: label+"+", mini: true, backgroundColor: Colors.pink, child: Icon(Icons.add), onPressed: increment),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ResultScreen extends StatelessWidget {
  final double bmi;
  ResultScreen({required this.bmi});

  @override
  Widget build(BuildContext context) {
    String result;
    String message;

    if (bmi < 18.5) {
      result = "Underweight";
      message = "You need to gain more weight for a healthy body.";
    } else if (bmi < 24.9) {
      result = "Normal";
      message = "You have a healthy body weight. Keep it up!";
    } else {
      result = "Overweight";
      message = "You should consider maintaining a healthier weight.";
    }

    return Scaffold(
      appBar: AppBar(title: Text("BMI Calculator"), backgroundColor: Color(0xFF0A0E21)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Your Result", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(result, style: TextStyle(fontSize: 25, color: Colors.green)),
          Text(bmi.toStringAsFixed(1), style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white)),
          SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(fontSize: 18, color: Colors.white70),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              color: Colors.pink,
              width: double.infinity,
              height: 60,
              child: Center(
                child: Text("Re-Calculate", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
