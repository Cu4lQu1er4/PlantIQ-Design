import '../models/lote.dart';
import '../models/aspersor.dart';

// Mock data para aspersores de lote 1
final List<Aspersor> mockAspersoresLote1 = [
  Aspersor(id: 1, nombre: 'Aspersor 1A', humedad: 20.0, ph: 6.5),
  Aspersor(id: 2, nombre: 'Aspersor 1B', humedad: 25.0, ph: 6.8),
];

// Mock data para aspersores de lote 2
final List<Aspersor> mockAspersoresLote2 = [
  Aspersor(id: 3, nombre: 'Aspersor 2A', humedad: 18.0, ph: 6.6),
  Aspersor(id: 4, nombre: 'Aspersor 2B', humedad: 22.0, ph: 6.7),
  Aspersor(id: 5, nombre: 'Aspersor 2C', humedad: 30.0, ph: 7.0),
];

// Mock data para lotes
final List<Lote> mockLotes = [
  Lote(
    id: 1,
    nombre: 'Lote 1',
    aspersores: mockAspersoresLote1,
  ),
  Lote(
    id: 2,
    nombre: 'Lote 2',
    aspersores: mockAspersoresLote2,
  ),
];
