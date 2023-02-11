import 'package:abctech/controller/assists_controller.dart';
import 'package:abctech/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<AssistsController> {
  const HomePage({Key? key}) : super(key: key);

  Widget _renderList(List<Assist>? assists) {
    if (assists == null) {
      return Container();
    }
    return ListView.builder(
        shrinkWrap: true,
        itemCount: assists.length,
        itemBuilder: (context, index) => ListTile(
              selectedColor: Colors.orange,
              selected: controller.isSelected(index),
              title: Text(assists[index].name),
              onTap: () => controller.selectAssist(index),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Lista de assistências")),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(
                children: [
                  Expanded(
                      child: Text("Os serviços disponíveis são:",
                          textAlign: TextAlign.center)),
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: TextButton(
                    onPressed: controller.getAssistList,
                    child: const Text("Recarregar"),
                  )),
                ],
              ),
              controller.obx((state) => _renderList(state),
                  onLoading: const Text("Sem assistências"),
                  onError: (error) => Text(error.toString()))
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: controller.finishSelectAssist,
          child: const Icon(Icons.done)),
    );
  }
}
