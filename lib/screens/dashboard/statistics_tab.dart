// lib/screens/dashboard/statistics_tab.dart
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../models/lote.dart';
import '../../models/aspersor.dart';
import '../../services/api_service.dart';

class StatisticsTab extends StatefulWidget {
  const StatisticsTab({super.key});

  @override
  State<StatisticsTab> createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> {
  late Future<List<Lote>> futureLotes;
  Lote? selectedLote;
  Aspersor? selectedAspersor;
  String chartType = 'line'; // 'line' | 'bar' | 'radialBar'

  @override
  void initState() {
    super.initState();
    futureLotes = ApiService.getLotes();
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
                // Selección de lote y tipo de gráfica
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
                                selectedAspersor = null;
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
                              DropdownMenuItem(value: 'line', child: Text('Líneas')),
                              DropdownMenuItem(value: 'bar', child: Text('Barras')),
                              DropdownMenuItem(value: 'radialBar', child: Text('Radial')),
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

                // Instrucción si no hay lote
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

                // Dropdown aspersores
                // Dropdown aspersores + botón en la misma fila
                if (selectedLote != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        // Dropdown ocupa el espacio disponible
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFF2B2F3A),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<Aspersor>(
                                isExpanded: true,
                                hint: const Text(
                                  'Seleccione un aspersor',
                                  style: TextStyle(color: Color(0xFFE3E3E3)),
                                ),
                                dropdownColor: const Color(0xFF2B2F3A),
                                style: const TextStyle(color: Color(0xFFE3E3E3)),
                                value: selectedAspersor,
                                items: selectedLote!.aspersores.map((asp) {
                                  return DropdownMenuItem<Aspersor>(
                                    value: asp,
                                    child: Text(asp.nombre),
                                  );
                                }).toList(),
                                onChanged: (asp) {
                                  setState(() {
                                    selectedAspersor = asp;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5), // Espacio entre dropdown y botón
                        // Botón de activar
                        ElevatedButton(
                          onPressed: selectedAspersor != null
                              ? () {
                                  // Aquí llamas tu función para activar el aspersor
                                  print("Activando aspersor: ${selectedAspersor!.nombre}");
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFFDA00FF),
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text("Activar", 
                            style: TextStyle(
                              color: Color(0xFFE3E3E3),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Gráfica radial circular
  Widget buildRadialBarChart(Aspersor aspersor, {required bool isPh}) {
    final maxValue = isPh ? 14.0 : 100.0;
    final value = isPh ? aspersor.ph : aspersor.humedad;

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

  /// Construcción de gráficas dependiendo del tipo
  Widget _buildCharts(Lote lote) {
    final aspersoresToShow =
        selectedAspersor == null ? lote.aspersores : [selectedAspersor!];

    if (chartType == 'radialBar') {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: aspersoresToShow.map((aspersor) {
            return Card(
              color: const Color(0xFF2B2F3A),
              margin: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Aspersor ${aspersor.nombre}',
                      style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text('Humedad',
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 8),
                              buildRadialBarChart(aspersor, isPh: false),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              const Text('pH',
                                  style: TextStyle(color: Colors.white)),
                              const SizedBox(height: 8),
                              buildRadialBarChart(aspersor, isPh: true),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    }

    // resto de gráficas (líneas o barras)
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var aspersor in aspersoresToShow) ...[
            Card(
              color: const Color(0xFF2B2F3A),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Humedad - ${aspersor.nombre}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
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
                                        toY: aspersor.humedad.toDouble(),
                                        width: 16,
                                        color: Colors.blueAccent,
                                      )
                                    ],
                                  )
                                ],
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                                ),
                                borderData: FlBorderData(show: false),
                              ),
                            )
                          : LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [FlSpot(0, aspersor.humedad.toDouble())],
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
                                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                                ),
                                gridData: FlGridData(show: true),
                              ),
                            ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'pH - ${aspersor.nombre}',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
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
                                        toY: aspersor.ph.toDouble(),
                                        width: 16,
                                        color: Colors.greenAccent,
                                      )
                                    ],
                                  )
                                ],
                                titlesData: FlTitlesData(
                                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                                ),
                                borderData: FlBorderData(show: false),
                              ),
                            )
                          : LineChart(
                              LineChartData(
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [FlSpot(0, aspersor.ph.toDouble())],
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
                                  bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                                ),
                                gridData: FlGridData(show: true),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
