import 'package:flutter/material.dart';
import '../../services/server.dart';

class DateTimeScreen extends StatefulWidget {
  const DateTimeScreen({super.key});

  @override
  State<DateTimeScreen> createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay? _selectedTime;
  Map<String, dynamic>? _availableHours;
  List<TimeSlot> _availableTimeSlots = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAvailableHours();
  }

  Future<void> _loadAvailableHours() async {
    try {
      final availableHours = await Server.getAvailableHours();
      if (mounted) {
        setState(() {
          _availableHours = availableHours;
          _isLoading = false;
          _updateAvailableTimeSlots();
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error al cargar los horarios disponibles'),
          ),
        );
      }
    }
  }

  void _updateAvailableTimeSlots() {
    if (_availableHours == null) return;

    final dateStr =
        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
    final slots = _availableHours![dateStr] as List?;

    if (slots == null) {
      _availableTimeSlots = [];
      return;
    }

    // Convert slots to TimeSlot objects
    final allSlots =
        slots.map((slot) {
          final from = DateTime.parse(slot['from']);
          return TimeSlot(
            time: TimeOfDay(hour: from.hour, minute: from.minute),
            isAvailable: _isTimeSlotAvailable(from),
          );
        }).toList();

    setState(() {
      _availableTimeSlots = allSlots;
    });
  }

  bool _isTimeSlotAvailable(DateTime startTime) {
    if (_availableHours == null) return false;

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final duration = args['duration'] as int;
    final requiredSlots =
        (duration / 15).ceil(); // Convert duration to number of 15-min slots

    final dateStr =
        '${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}';
    final slots = _availableHours![dateStr] as List;

    // Find the index of the starting slot
    final startIndex = slots.indexWhere((slot) {
      final slotTime = DateTime.parse(slot['from']);
      return slotTime.hour == startTime.hour &&
          slotTime.minute == startTime.minute;
    });

    if (startIndex == -1) return false;

    // Check if we have enough consecutive slots
    if (startIndex + requiredSlots > slots.length) return false;

    // Verify all required slots are available
    for (int i = 0; i < requiredSlots; i++) {
      final currentSlot = slots[startIndex + i];
      final nextSlot = i < requiredSlots - 1 ? slots[startIndex + i + 1] : null;

      if (nextSlot != null) {
        final currentEnd = DateTime.parse(currentSlot['to']);
        final nextStart = DateTime.parse(nextSlot['from']);
        if (currentEnd != nextStart) return false;
      }
    }

    return true;
  }

  bool _isDateAvailable(DateTime date) {
    if (_availableHours == null) return false;

    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return _availableHours!.containsKey(dateStr) &&
        (_availableHours![dateStr] as List).isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    if (args == null) {
      return const Scaffold(
        body: Center(
          child: Text('Error: No se encontraron los argumentos necesarios'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Fecha y Hora'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Resumen de la reservación',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            Text('Nombre: ${args['name']}'),
                            Text('Email: ${args['email']}'),
                            Text('Servicio: ${args['service'].name}'),
                            Text(
                              'Precio: \$${args['price'].toStringAsFixed(2)}',
                            ),
                            Text('Duración: ${args['duration']} min'),
                            Text(
                              'Fecha: ${_selectedDate.toString().split(' ')[0]}',
                            ),
                            Text(
                              'Hora: ${_selectedTime?.format(context) ?? ''}',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seleccionar fecha',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            CalendarDatePicker(
                              initialDate: _selectedDate,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(
                                const Duration(days: 14),
                              ),
                              selectableDayPredicate: _isDateAvailable,
                              onDateChanged: (date) {
                                setState(() {
                                  _selectedDate = date;
                                  _selectedTime = null;
                                  _updateAvailableTimeSlots();
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seleccionar hora',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            if (_availableTimeSlots.isEmpty)
                              const Center(
                                child: Text(
                                  'No hay horarios disponibles para esta fecha',
                                ),
                              )
                            else
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 2.5,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                    ),
                                itemCount: _availableTimeSlots.length,
                                itemBuilder: (context, index) {
                                  final slot = _availableTimeSlots[index];
                                  return TimeSlotButton(
                                    timeSlot: slot,
                                    isSelected: _selectedTime == slot.time,
                                    onTap:
                                        slot.isAvailable
                                            ? () {
                                              setState(() {
                                                _selectedTime = slot.time;
                                              });
                                            }
                                            : null,
                                  );
                                },
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed:
                          _selectedTime == null
                              ? null
                              : () {
                                // TODO: Implement actual reservation logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Reservación creada exitosamente',
                                    ),
                                  ),
                                );
                                Navigator.of(
                                  context,
                                ).popUntil((route) => route.isFirst);
                              },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFBB9D71),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Confirmar reservación',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}

class TimeSlot {
  final TimeOfDay time;
  final bool isAvailable;

  TimeSlot({required this.time, required this.isAvailable});
}

class TimeSlotButton extends StatelessWidget {
  final TimeSlot timeSlot;
  final bool isSelected;
  final VoidCallback? onTap;

  const TimeSlotButton({
    super.key,
    required this.timeSlot,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color:
          isSelected
              ? Theme.of(context).colorScheme.primary
              : timeSlot.isAvailable
              ? Colors.white
              : Colors.grey[200],
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color:
                  isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              timeSlot.time.format(context),
              style: TextStyle(
                color:
                    isSelected
                        ? Colors.white
                        : timeSlot.isAvailable
                        ? Colors.black
                        : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
