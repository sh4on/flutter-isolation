import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: const Text('Isolation Demo')),
      body: Column(
        spacing: 10,
        children: [
          const SizedBox(height: 10),

          // to demonstrate UI freeze
          const CircularProgressIndicator(),

          const Text('Watch this spinner. If it stops, the UI is frozen.'),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => controller.fetchDataWithoutIsolation(),
                child: const Text('Without Isolation'),
              ),
              ElevatedButton(
                onPressed: () => controller.fetchDataWithIsolation(),
                child: const Text('With Isolation'),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Expanded(
            child: Obx(() {
              final status = controller.status.value;

              if (status.isLoading) {
                return const Center(child: Text('Loading data...'));
              } else if (status.isError) {
                return Center(child: Text('Error: ${status.errorMessage}'));
              } else if (controller.dataList.isEmpty) {
                return const Center(child: Text('No data loaded'));
              } else {
                return ListView.builder(
                  itemCount: controller.dataList.length,
                  itemBuilder: (context, index) {
                    final item = controller.dataList[index];
                    return ListTile(
                      title: Text(item['name']?.toString() ?? 'No Name'),
                      subtitle: Text(
                        item['language']?.toString() ?? 'No Language',
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
