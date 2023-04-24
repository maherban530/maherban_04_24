import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:maherban_04_22/Controllers/task_controller.dart';
import 'package:maherban_04_22/View/screen2.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task1")),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.width / 8),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TextField(
                controller: taskController.sizeFieldController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 12),
            InkWell(
              onTap: () {
                taskController.fetchImageData(
                    size: int.parse(taskController.sizeFieldController.text));
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("OK"),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: Obx(
                () => PageView.builder(
                  itemCount: taskController.taskModelLo.length,
                  itemBuilder: (context, index) {
                    var taskData = taskController.taskModelLo[index] as List;
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ...List.generate(
                          taskData.length,
                          (i) => SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.width / 6,
                            child: taskData[i]['image_url'] == null ? const Icon(Icons.image) :
                             Image.network(
                              taskData[i]['image_url'].toString(),
                              fit: BoxFit.cover,
                              loadingBuilder: (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress.cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  onPageChanged: (value) {
                    taskController.selectScroll.value = value;
                  },
                ),
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                      taskController.taskModelLo.length,
                      (index) => Icon(
                            Icons.circle,
                            size: 10,
                            color: taskController.selectScroll.value == index
                                ? Colors.indigo
                                : Colors.grey,
                          )),
                ],
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width / 10),
            InkWell(
              onTap: () {
                Get.to(() => Screen2());
              },
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text("go to screen 2"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
