import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Importing intl package for date formatting

import '../view_model/fixtures_bloc.dart';
import '../view_model/fixtures_event.dart';
import '../view_model/fixtures_state.dart';

class FixturesView extends StatefulWidget {
  const FixturesView({super.key});

  @override
  FixturesViewState createState() => FixturesViewState();
}

class FixturesViewState extends State<FixturesView> {
  @override
  void initState() {
    super.initState();
    // Triggering event to fetch fixtures
    context.read<FixturesBloc>().add(FetchFixtures());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fixtures Overview'),
        backgroundColor: Colors.green,
      ),
      body: BlocBuilder<FixturesBloc, FixturesState>(
        builder: (context, state) {
          if (state is FixturesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FixturesLoaded) {
            return ListView.builder(
              itemCount: state.fixturesList.length,
              itemBuilder: (context, index) {
                final fixture = state.fixturesList[index];

                // Format date and time
                final formattedDate = DateFormat('yyyy-MM-dd').format(fixture.date);
                final formattedTime = DateFormat('HH:mm').format(fixture.date);

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: fixture.team1Logo != null
                        ? Image.network(
                            fixture.team1Logo!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 50),
                    title: Text('${fixture.team1} vs ${fixture.team2}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('$formattedDate at $formattedTime - ${fixture.venue}'),
                    trailing: fixture.team2Logo != null
                        ? Image.network(
                            fixture.team2Logo!,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported, size: 50),
                    onTap: () {
                      // Navigate to fixture details (if needed)
                    },
                  ),
                );
              },
            );
          } else if (state is FixturesError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No Fixtures Available'));
        },
      ),
    );
  }
}
