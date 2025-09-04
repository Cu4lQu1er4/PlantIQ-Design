import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/lote.dart';
import '../../models/riegos.dart';
import '../../services/api_service.dart';

class StatisticsTab extends StatefulWidget {
  const StatisticsTab({super.key});

  @override
  State<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  late Future<List<Lote>> futureLotes; // Cambié aquí a List<Lote>
  Lote? selectedLote;
  String chartType = 'line';

  @override
  void initState() {
    super.initState();
    futureLotes =
        ApiService.getLotes(); // Debe ser método que retorna List<Lote>
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: FutureBuilder<List<Lote>>(
        future: futureLotes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay lotes disponibles'));
          }

          final lotes = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2F3A),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<Lote>(
                            isExpanded: true,
                            hint: const Text(
                              'Seleccione un lote',
                              style: TextStyle(color: Color(0xFFE3E3E3)),
                            ),
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            value: selectedLote,
                            items: lotes.map((l) {
                              return DropdownMenuItem<Lote>(
                                value: l,
                                child: Text(l.nombre),
                              );
                            }).toList(),
                            onChanged: (l) {
                              setState(() {
                                selectedLote = l;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2B2F3A),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: chartType,
                            isExpanded: true,
                            dropdownColor: const Color(0xFF2B2F3A),
                            style: const TextStyle(color: Color(0xFFE3E3E3)),
                            items: const [
                              DropdownMenuItem(
                                value: 'line',
                                child: Text('Líneas'),
                              ),
                              DropdownMenuItem(
                                value: 'bar',
                                child: Text('Barras'),
                              ),
                              DropdownMenuItem(
                                value: 'radialBar',
                                child: Text('Radial'),
                              ),
                            ],
                            onChanged: (v) {
                              setState(() {
                                chartType = v ?? 'line';
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (selectedLote == null)
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Selecciona un lote para ver sus gráficas',
                        style: TextStyle(color: Color(0xFFE3E3E3)),
                      ),
                    ),
                  )
                else
                  Expanded(child: _buildCharts(selectedLote!)),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: ElevatedButton(
                    onPressed: selectedLote != null
                        ? () {
                            print(
                              "Activando sistema para lote: ${selectedLote!.nombre}",
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFDA00FF),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                        vertical: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Activar",
                      style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildRadialBarChart(Riego riego, {required bool isPh}) {
    final maxValue = isPh ? 14.0 : 100.0;
    final value = isPh ? riego.ph : riego.humedad;

    return SizedBox(
      width: 100,
      height: 250,
      child: PieChart(
        PieChartData(
          centerSpaceRadius: 35,
          sectionsSpace: 3,
          sections: [
            PieChartSectionData(
              value: value,
              color: isPh ? Colors.greenAccent : Colors.blueAccent,
              radius: 55,
              title: '${value.toStringAsFixed(1)}',
              titleStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            PieChartSectionData(
              value: maxValue - value,
              color: Colors.grey.shade800,
              radius: 55,
              title: '',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCharts(Lote lote) {
    final riegosToShow = lote.riegos;

    if (chartType == 'radialBar') {
      return ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: riegosToShow.length,
        itemBuilder: (context, index) {
          final riego = riegosToShow[index];
          return Card(
            color: const Color(0xFF2B2F3A),
            margin: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Riego ${riego.nombre}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'Humedad',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            buildRadialBarChart(riego, isPh: false),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            const Text(
                              'pH',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(height: 8),
                            buildRadialBarChart(riego, isPh: true),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: riegosToShow.length,
      itemBuilder: (context, index) {
        final riego = riegosToShow[index];
        return Card(
          color: const Color(0xFF2B2F3A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Humedad',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: chartType == 'bar'
                      ? BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(
                                    toY: riego.humedad.toDouble(),
                                    width: 16,
                                    color: Colors.blueAccent,
                                  ),
                                ],
                              ),
                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                          ),
                        )
                      : LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: [FlSpot(0, riego.humedad.toDouble())],
                                isCurved: true,
                                color: Colors.blueAccent,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.blueAccent.withOpacity(0.3),
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'pH',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 250,
                  child: chartType == 'bar'
                      ? BarChart(
                          BarChartData(
                            barGroups: [
                              BarChartGroupData(
                                x: 0,
                                barRods: [
                                  BarChartRodData(
                                    toY: riego.ph.toDouble(),
                                    width: 16,
                                    color: Colors.greenAccent,
                                  ),
                                ],
                              ),
                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                            ),
                            borderData: FlBorderData(show: false),
                          ),
                        )
                      : LineChart(
                          LineChartData(
                            lineBarsData: [
                              LineChartBarData(
                                spots: [FlSpot(0, riego.ph.toDouble())],
                                isCurved: true,
                                color: Colors.greenAccent,
                                barWidth: 3,
                                dotData: FlDotData(show: true),
                                belowBarData: BarAreaData(
                                  show: true,
                                  color: Colors.greenAccent.withOpacity(0.2),
                                ),
                              ),
                            ],
                            titlesData: FlTitlesData(
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: false),
                              ),
                              leftTitles: AxisTitles(
                                sideTitles: SideTitles(showTitles: true),
                              ),
                            ),
                            gridData: FlGridData(show: true),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
