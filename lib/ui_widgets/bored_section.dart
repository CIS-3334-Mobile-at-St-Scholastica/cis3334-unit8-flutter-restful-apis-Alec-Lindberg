// lib/ui_widgets/bored_section.dart
import 'package:flutter/material.dart';
import '../services/bored_service.dart';
import '../data_models/bored_activity.dart';

class BoredSection extends StatelessWidget {
  const BoredSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BoredActivity>(
      future: BoredService.fetchRandomActivity(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              color: Theme.of(context).colorScheme.errorContainer,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onErrorContainer,
                  ),
                ),
              ),
            ),
          );
        }

        // Data
        final activity = snapshot.data!;
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.activity,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(label: 'Type', value: activity.type),
                    _InfoChip(label: 'Participants', value: '${activity.participants}'),
                    _InfoChip(label: 'Price', value: activity.price.toStringAsFixed(2)),
                    _InfoChip(label: 'Accessibility', value: activity.accessibility.toStringAsFixed(2)),
                    if (activity.link != null)
                      ActionChip(
                        label: const Text('Link'),
                        onPressed: () {
                          // You could integrate url_launcher here if desired.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Open link with url_launcher')),
                          );
                        },
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
}

class _InfoChip extends StatelessWidget {
  final String label;
  final String value;
  const _InfoChip({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text('$label: $value'),
    );
  }
}
