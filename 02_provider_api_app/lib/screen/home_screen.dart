import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/load_enum.dart';
import '../provider/api_provider.dart';
import '../widget/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() async {
      context.read<ApiProvider>().loadAlbum();
      print("mulai ${context.read<ApiProvider>().loadEnum}");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Provider API App"),
      ),
      body: Center(
        child: Consumer<ApiProvider>(
          builder: (context, value, child) {
            final loadState = value.loadEnum;

            if (loadState == LoadEnum.loading) {
              return const CircularProgressIndicator();
            } //
            else if (loadState == LoadEnum.loaded) {
              final album = value.album!;
              return TextWidget(
                text: "Album: ${album.title}",
              );
            } //
            else if (loadState == LoadEnum.error) {
              final message = value.message;
              return TextWidget(
                text: message,
              );
            } //
            else {
              return const TextWidget(
                text: "No Data",
              );
            }
          },
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<ApiProvider>().loadAlbum();
            },
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () {
              context.read<ApiProvider>().loadError();
            },
            child: const Icon(Icons.error),
          ),
        ],
      ),
    );
  }
}
