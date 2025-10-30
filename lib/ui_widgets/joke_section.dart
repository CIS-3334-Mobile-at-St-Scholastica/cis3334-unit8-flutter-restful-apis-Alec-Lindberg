// lib/ui_widgets/joke_section.dart
import 'package:flutter/material.dart';
import '../services/joke_service.dart';
import '../data_models/joke.dart';

class JokeSection extends StatefulWidget {
  const JokeSection({super.key});

  @override
  State<JokeSection> createState() => _JokeSectionState();
}

class _JokeSectionState extends State<JokeSection> {
  late Future<Joke> _future;

  @override
  void initState() {
    super.initState();
    _future = JokeService.fetchRandomJoke();
  }

  void _reload() {
    setState(() {
      _future = JokeService.fetchRandomJoke();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Joke>(
      future: _future,
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          );
        }

        // Error
        if (snapshot.hasError) {
          return Card(
            color: Theme.of(context).colorScheme.errorContainer,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: _reload,
                    child: const Text('Try again'),
                  ),
                ],
              ),
            ),
          );
        }

        // Data
        final joke = snapshot.data!;
        final textTheme = Theme.of(context).textTheme;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row with category + refresh
                Row(
                  children: [
                    Chip(label: Text(joke.category)),
                    const Spacer(),
                    IconButton(
                      tooltip: 'New joke',
                      onPressed: _reload,
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                if (joke.type == 'single') ...[
                  Text(joke.joke ?? '', style: textTheme.titleMedium),
                ] else ...[
                  Text(joke.setup ?? '', style: textTheme.titleMedium),
                  const SizedBox(height: 8),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(joke.delivery ?? '', style: textTheme.bodyLarge),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
