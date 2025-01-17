import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/teams_bloc.dart';
import '../view_model/teams_event.dart';
import '../view_model/teams_state.dart';

class TeamsView extends StatelessWidget {
  TeamsView({super.key});

  final teamsNameController = TextEditingController();

  final _teamsViewFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _teamsViewFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: teamsNameController,
                decoration: const InputDecoration(
                  labelText: 'Team Name',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter team name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  if (_teamsViewFormKey.currentState!.validate()) {
                    context.read<TeamsBloc>().add(
                          AddTeams(teamsNameController.text.trim()),
                        );
                  }
                },
                child: BlocBuilder<TeamsBloc, TeamsState>(
                  builder: (context, state) {
                    return Text('Add Teams');
                  },
                ),
              ),
              SizedBox(height: 8),
              BlocBuilder<TeamsBloc, TeamsState>(builder: (context, state) {
                if (state.teams.isEmpty) {
                  return Text('No data found');
                } else if (state.isLoading) {
                  return CircularProgressIndicator();
                } else {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.teams.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(state.teams[index]
                              .teamsName), // Use teamsName directly
                          subtitle: Text(state.teams[index].teamsId!),
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              context.read<TeamsBloc>().add(
                                    DeleteTeams(state.teams[index].teamsId!),
                                  );
                            },
                          ),
                        );
                      });
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
