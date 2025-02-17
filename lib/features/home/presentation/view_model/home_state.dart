import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_football_app/app/di/di.dart';
import 'package:uni_football_app/features/news/presentation/view/news_view.dart';
import 'package:uni_football_app/features/news/presentation/view_model/news_bloc.dart';

class HomeState extends Equatable {
  final int selectedIndex;
  final List<Widget> views;

  const HomeState({
    required this.selectedIndex,
    required this.views,
  });

  // Initial state
  static HomeState initial() {
    return HomeState(
      selectedIndex: 0,
      views: [
        const Center(
          child: Text('Dashboard'),
        ),
        BlocProvider(
          create: (context) => getIt<NewsBloc>(),
          child: NewsView(),
        ),
        const Center(
          child: Text('Standings'),
        ),
        const Center(
          child: Text('Account'),
        ),
      ],
    );
  }

  HomeState copyWith({
    int? selectedIndex,
    List<Widget>? views,
  }) {
    return HomeState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      views: views ?? this.views,
    );
  }

  @override
  List<Object?> get props => [selectedIndex, views];
}
