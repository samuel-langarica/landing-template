class Service {
  final String name;
  final String description;
  final double price;
  final int durationMinutes;

  const Service({
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
  });
}

const List<Service> availableServices = [
  Service(
    name: 'Baño',
    description:
        'Baño completo con shampoo y acondicionador especial para mascotas',
    price: 300.0,
    durationMinutes: 60,
  ),
  Service(
    name: 'Corte',
    description: 'Corte de pelo profesional según la raza y preferencias',
    price: 250.0,
    durationMinutes: 45,
  ),
  Service(
    name: 'Cepillado de dientes',
    description: 'Limpieza dental profesional con productos especializados',
    price: 400.0,
    durationMinutes: 30,
  ),
];
