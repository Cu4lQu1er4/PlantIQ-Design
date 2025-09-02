import 'package:flutter/material.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';

// === Widgets para hover simple (botón y link) ===
class SimpleHoverButton extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  const SimpleHoverButton({required this.onTap, required this.child, Key? key})
    : super(key: key);

  @override
  _SimpleHoverButtonState createState() => _SimpleHoverButtonState();
}

class _SimpleHoverButtonState extends State<SimpleHoverButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _isHovered ? 0.7 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}

class SimpleHoverLink extends StatefulWidget {
  final VoidCallback onTap;
  final Widget child;
  const SimpleHoverLink({required this.onTap, required this.child, Key? key})
    : super(key: key);

  @override
  _SimpleHoverLinkState createState() => _SimpleHoverLinkState();
}

class _SimpleHoverLinkState extends State<SimpleHoverLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _isHovered ? 0.7 : 1.0,
          child: widget.child,
        ),
      ),
    );
  }
}

// === HoverMenuItem para SideMenu ===
class HoverMenuItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const HoverMenuItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  _HoverMenuItemState createState() => _HoverMenuItemState();
}

class _HoverMenuItemState extends State<HoverMenuItem> {
  bool _isHovered = false;

  void _onEnter(PointerEvent event) => setState(() => _isHovered = true);
  void _onExit(PointerEvent event) => setState(() => _isHovered = false);

  @override
  Widget build(BuildContext context) {
    final baseColor = const Color(0xFFE3E3E3);
    return MouseRegion(
      onEnter: _onEnter,
      onExit: _onExit,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 150),
          opacity: _isHovered ? 0.7 : 1.0,
          child: Column(
            children: [
              Icon(widget.icon, color: baseColor, size: 40),
              const SizedBox(height: 1),
              Text(
                widget.label,
                style: TextStyle(color: baseColor, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// === SideMenu widget adaptable ===
class SideMenu extends StatelessWidget {
  final Function(int) onItemSelected;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const SideMenu({Key? key, required this.onItemSelected, this.scaffoldKey})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 600) {
          // Pantallas anchas: menú lateral fijo
          return Container(
            width: 85,
            color: const Color(0xFF2B2F3A),
            padding: const EdgeInsets.all(6),
            child: Column(
              children: [
                HoverMenuItem(
                  icon: Icons.person,
                  label: 'Perfil',
                  onTap: () => onItemSelected(0),
                ),
                const SizedBox(height: 220),
                HoverMenuItem(
                  icon: Icons.eco,
                  label: 'Riegos',
                  onTap: () => onItemSelected(1),
                ),
                const SizedBox(height: 20),
                HoverMenuItem(
                  icon: Icons.equalizer,
                  label: 'Estadísticas',
                  onTap: () => onItemSelected(2),
                ),
                const SizedBox(height: 20),
                HoverMenuItem(
                  icon: Icons.apps,
                  label: 'Sistema',
                  onTap: () => onItemSelected(3),
                ),
                const Spacer(),
                HoverMenuItem(
                  icon: Icons.settings,
                  label: 'Ajustes',
                  onTap: () => onItemSelected(4),
                ),
              ],
            ),
          );
        } else {
          // Pantallas pequeñas: menú oculto, usa Drawer y botón hamburguesa
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.menu, color: Color(0xFFE3E3E3)),
              onPressed: () {
                if (scaffoldKey != null && scaffoldKey!.currentState != null) {
                  scaffoldKey!.currentState!.openDrawer();
                }
              },
              tooltip: 'Abrir menú',
            ),
          );
        }
      },
    );
  }
}

// === Página de inicio ===
class PaginaInicio extends StatelessWidget {
  const PaginaInicio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F2A),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2F3A),
                  borderRadius: BorderRadius.circular(20),
                ),
                height: 400,
                width: 700,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/Logo.png', width: 400),
                    const SizedBox(height: 32),
                    const Text(
                      '"Agua precisa, tierra productiva."',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFE3E3E3),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Tus cultivos siempre saludables con nuestro sistema de riego inteligente.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Color(0xFFE3E3E3)),
                    ),
                    const SizedBox(height: 40),
                    SimpleHoverButton(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 35,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFDA00FF),
                              Color(0xFF7E0FF5),
                              Color(0xFFDA00FF),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          'Comenzar',
                          style: TextStyle(
                            color: Color(0xFFE3E3E3),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: Color(0xFFE3E3E3),
                          fontSize: 16,
                        ),
                        children: [
                          const TextSpan(
                            text: 'Si no te has inscrito registrate ',
                          ),
                          WidgetSpan(
                            child: SimpleHoverLink(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'aquí.',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFDA00FF),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// === Dashboard principal con SideMenu ===
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      if (_scaffoldKey.currentState != null &&
          _scaffoldKey.currentState!.isDrawerOpen) {
        Navigator.of(
          context,
        ).pop(); // cierra el drawer si está abierto (en móviles)
      }
    });
  }

  Widget _getPageForIndex(int index) {
    // Aquí puedes poner tus pantallas según el índice
    switch (index) {
      case 0:
        return Center(child: Text('Perfil', style: _textStyle()));
      case 1:
        return Center(child: Text('Riegos', style: _textStyle()));
      case 2:
        return Center(child: Text('Estadísticas', style: _textStyle()));
      case 3:
        return Center(child: Text('Sistema', style: _textStyle()));
      case 4:
        return Center(child: Text('Ajustes', style: _textStyle()));
      default:
        return Center(child: Text('Página no encontrada', style: _textStyle()));
    }
  }

  TextStyle _textStyle() =>
      const TextStyle(fontSize: 24, color: Color(0xFFE3E3E3));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF1C1F2A),
      drawer: Drawer(
        child: Container(
          color: const Color(0xFF2B2F3A),
          child: Column(
            children: [
              const DrawerHeader(
                child: Center(
                  child: Text(
                    'Menú',
                    style: TextStyle(color: Color(0xFFE3E3E3), fontSize: 24),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFFE3E3E3)),
                title: const Text(
                  'Perfil',
                  style: TextStyle(color: Color(0xFFE3E3E3)),
                ),
                onTap: () => _onItemSelected(0),
              ),
              ListTile(
                leading: const Icon(Icons.eco, color: Color(0xFFE3E3E3)),
                title: const Text(
                  'Riegos',
                  style: TextStyle(color: Color(0xFFE3E3E3)),
                ),
                onTap: () => _onItemSelected(1),
              ),
              ListTile(
                leading: const Icon(Icons.equalizer, color: Color(0xFFE3E3E3)),
                title: const Text(
                  'Estadísticas',
                  style: TextStyle(color: Color(0xFFE3E3E3)),
                ),
                onTap: () => _onItemSelected(2),
              ),
              ListTile(
                leading: const Icon(Icons.apps, color: Color(0xFFE3E3E3)),
                title: const Text(
                  'Sistema',
                  style: TextStyle(color: Color(0xFFE3E3E3)),
                ),
                onTap: () => _onItemSelected(3),
              ),
              const Spacer(),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFFE3E3E3)),
                title: const Text(
                  'Ajustes',
                  style: TextStyle(color: Color(0xFFE3E3E3)),
                ),
                onTap: () => _onItemSelected(4),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: [
          SideMenu(onItemSelected: _onItemSelected, scaffoldKey: _scaffoldKey),
          Expanded(child: _getPageForIndex(_selectedIndex)),
        ],
      ),
    );
  }
}

// === Main app ===
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Página de Inicio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2B2F3A)),
        useMaterial3: true,
      ),
      home: const PaginaInicio(),
    );
  }
}
