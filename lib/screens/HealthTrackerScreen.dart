import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HealthTrackerScreen extends StatefulWidget {
  @override
  _HealthTrackerScreenState createState() => _HealthTrackerScreenState();
}

class _HealthTrackerScreenState extends State<HealthTrackerScreen> {
  int steps = 6000;
  double heartRate = 78;
  double hydration = 2.5; // Liters

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Health Tracker", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5F5), // Light grey background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHealthStat("Steps", steps.toString(), Icons.directions_walk, Colors.blue),
            _buildHealthStat("Heart Rate", "$heartRate bpm", Icons.favorite, Colors.red),
            _buildHealthStat("Hydration", "$hydration L", Icons.local_drink, Colors.teal),

            SizedBox(height: 20),

            Text("Weekly Progress", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Expanded(child: _buildLineChart()), // Graph Section
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStat(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        trailing: Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color)),
      ),
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                List<String> days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
                return Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(days[value.toInt()], style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                );
              },
              reservedSize: 24,
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(0, 4),
              FlSpot(1, 5.5),
              FlSpot(2, 4.8),
              FlSpot(3, 6.2),
              FlSpot(4, 5.9),
              FlSpot(5, 6.5),
              FlSpot(6, 7.1),
            ],
            isCurved: true,
            color: Colors.deepPurple,
            barWidth: 4,
            dotData: FlDotData(show: false),
          ),
        ],
      ),
    );
  }
}
