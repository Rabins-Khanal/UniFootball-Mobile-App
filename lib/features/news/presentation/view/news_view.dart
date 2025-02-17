import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Importing intl package for date formatting

import '../view_model/news_bloc.dart';
import '../view_model/news_event.dart';
import '../view_model/news_state.dart';

class NewsView extends StatefulWidget {
  const NewsView({super.key});

  @override
  NewsViewState createState() => NewsViewState();
}

class NewsViewState extends State<NewsView> {
  @override
  void initState() {
    super.initState();
    // Triggering event to fetch news overview
    context.read<NewsBloc>().add(FetchNewsOverview());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Overview'),
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsOverviewLoaded) {
            return ListView.builder(
              itemCount: state.newsList.length,
              itemBuilder: (context, index) {
                final newsItem = state.newsList[index];

                // Format datePublished to a string using DateFormat
                final formattedDate =
                    DateFormat('yyyy-MM-dd').format(newsItem.datePublished);

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10.0),
                    leading: newsItem.newsImage != null
                        ? Image.network(
                            newsItem.newsImage!,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          )
                        : const Icon(Icons.image_not_supported,
                            size: 80), // Placeholder for null image
                    title: Text(newsItem.title,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(formattedDate), // Display the formatted date
                    onTap: () {
                      // Trigger event to fetch details of clicked news
                      context
                          .read<NewsBloc>()
                          .add(FetchNewsDetails(newsItem.newsId));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailView(newsId: newsItem.newsId),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No News Available'));
        },
      ),
    );
  }
}

class NewsDetailView extends StatelessWidget {
  final String newsId;
  const NewsDetailView({super.key, required this.newsId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
        backgroundColor: Colors.cyan,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsDetailsLoaded) {
            final news = state.news;

            // Format datePublished to string
            final formattedDate =
                DateFormat('yyyy-MM-dd').format(news.datePublished);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child:
                        Image.network(news.newsImage ?? '', fit: BoxFit.cover),
                  ),
                  const SizedBox(height: 10),
                  Text(news.title,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(
                    'By ${news.author}, $formattedDate', // Display author and formatted date
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  Text(news.body, style: const TextStyle(fontSize: 16)),
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text('No News Available'));
        },
      ),
    );
  }
}
