import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF27A19C),
          primary: const Color(0xFF27A19C),
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
        color: Colors.white,
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
          const Text(
            'Estética de Lucca',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27A19C),
            ),
          ),
          Row(
            children: [
              _buildSocialIcon(
                Icons.facebook,
                'https://facebook.com/barberiafina',
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                Icons.camera_alt,
                'https://instagram.com/barberiafina',
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                Icons.music_note,
                'https://tiktok.com/@barberiafina',
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
      color: color ?? const Color(0xFF27A19C),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: const Color(0xFF27A19C).withOpacity(0.1),
      child: Column(
        children: [
          const Text(
            'Cuidamos a tu mascota como parte de tu familia',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27A19C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          const Text(
            'Clínica veterinaria especializada en atención médica, vacunas y estética para perros y gatos. Servicio profesional con amor.',
            style: TextStyle(fontSize: 18, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _launchURL('https://wa.me/5215512345678'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF27A19C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  'Agendar cita por WhatsApp',
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
                  side: const BorderSide(color: Color(0xFF27A19C)),
                ),
                child: const Text(
                  'Llamar ahora',
                  style: TextStyle(fontSize: 16, color: Color(0xFF27A19C)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServices(BuildContext context) {
    final services = [
      {
        'name': 'Consulta general',
        'description':
            'Chequeo completo para perros y gatos con historial clínico digital.',
        'price': 300,
      },
      {
        'name': 'Vacuna antirrábica',
        'description': 'Vacuna certificada con cartilla de vacunación.',
        'price': 250,
      },
      {
        'name': 'Baño y estética',
        'description': 'Baño, corte de pelo y uñas. Incluye limpieza de oídos.',
        'price': 400,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      child: Column(
        children: [
          const Text(
            'Nuestros Servicios',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27A19C),
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
              color: Color(0xFF27A19C),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            service['description'],
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            '\$${service['price']}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27A19C),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCTASection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
      color: const Color(0xFF27A19C).withOpacity(0.1),
      child: Column(
        children: [
          const Text(
            '¿Listo para cuidar a tu mascota?',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color(0xFF27A19C),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _launchURL('https://wa.me/5215512345678'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF27A19C),
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 20),
            ),
            child: const Text(
              'Agendar cita por WhatsApp',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      color: const Color(0xFF27A19C),
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
                Icons.facebook,
                'https://facebook.com/barberiafina',
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                Icons.camera_alt,
                'https://instagram.com/barberiafina',
                color: Colors.white,
              ),
              const SizedBox(width: 16),
              _buildSocialIcon(
                Icons.music_note,
                'https://tiktok.com/@barberiafina',
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
