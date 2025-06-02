import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Estética de Lucca',
      theme: ThemeData(
        fontFamily: 'Playfair',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD0B8C8),
          primary: const Color(0xFFD0B8C8),
          secondary: const Color(0xFFBFD4E0),
          surface: const Color(0xFFF0E4EA),
          onSurface: const Color(0xFF1D2645),
          onPrimary: const Color(0xFF1D2645),
          onSecondary: const Color(0xFF1D2645),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(context),
            _buildHero(context),
            _buildServices(context),
            _buildCTASection(context),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF8E4162),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // Image.asset(
              //   'assets/images/logo.png',
              //   height: 40,
              //   width: 40,
              //   fit: BoxFit.contain,
              // ),

              // const SizedBox(width: 12),
              Text(
                'Estética de lucca',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Row(
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.whatsapp,
                'https://wa.me/3314873611',
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                FontAwesomeIcons.instagram,
                'https://www.instagram.com/laesteticadelucca?igsh=bXpuY2g2Z2NkZmpj',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon(IconData icon, String url, {Color? color}) {
    return IconButton(
      icon: Icon(icon),
      onPressed: () => _launchURL(url),
      color: color ?? Colors.white,
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  'assets/images/landscape-logo.png',
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Clínica veterinaria especializada en atención médica, vacunas y estética para perros y gatos. Servicio profesional con amor.',
            style: TextStyle(
              fontSize: 18,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 600) {
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed:
                          () => _launchURL('https://wa.me/5215512345678'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBB9D71),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Reserva una cita',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton(
                      onPressed: () => _launchURL('tel:+525512345678'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 16,
                        ),
                        side: const BorderSide(color: Color(0xFFBB9D71)),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Text(
                        'Contactános',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFFBB9D71),
                        ),
                      ),
                    ),
                  ],
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => _launchURL('https://wa.me/5215512345678'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFBB9D71),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: const Text(
                      'Reserva una cita',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 16),
                  OutlinedButton(
                    onPressed: () => _launchURL('tel:+525512345678'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      side: const BorderSide(color: Color(0xFFBB9D71)),
                    ),
                    child: const Text(
                      'Llamar ahora',
                      style: TextStyle(fontSize: 16, color: Color(0xFFBB9D71)),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    final services = [
      {'name': 'Baño', 'description': 'Baño completo', 'price': 300},
      {'name': 'Corte', 'description': 'Corte de pelo', 'price': 250},
      {
        'name': 'Cepillado de dientes',
        'description': 'Cepillado de dientes.',
        'price': 400,
      },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: Theme.of(context).colorScheme.secondary,
      child: Column(
        children: [
          Text(
            'Nuestros Servicios',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children:
                services.map((service) => _buildServiceCard(service)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      width: 300,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            service['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1D2645),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            service['description'],
            style: const TextStyle(fontSize: 16, color: Color(0xFF1D2645)),
          ),
          const SizedBox(height: 16),
          Text(
            '\$${service['price']}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFBB9D71),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: Theme.of(context).colorScheme.primary,
      child: Column(
        children: [
          Text(
            '¿Listo para cuidar a tu mascota?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          LayoutBuilder(
            builder: (context, constraints) {
              return ElevatedButton(
                onPressed: () => _launchURL('https://wa.me/5215512345678'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFBB9D71),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 48,
                    vertical: 20,
                  ),
                  minimumSize: Size(
                    constraints.maxWidth < 600 ? double.infinity : 200,
                    50,
                  ),
                ),
                child: const Text(
                  'Reserva una cita',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: const Color(0xFF254E70),
      child: Column(
        children: [
          const Text(
            'Estética de Lucca',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialIcon(
                FontAwesomeIcons.whatsapp,
                'https://wa.me/3314873611',
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                FontAwesomeIcons.phone,
                'tel:+3314873611',
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                FontAwesomeIcons.instagram,
                'https://www.instagram.com/laesteticadelucca?igsh=bXpuY2g2Z2NkZmpj',
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}
