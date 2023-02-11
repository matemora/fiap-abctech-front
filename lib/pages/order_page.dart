import 'package:abctech/controller/order_controller.dart';
import 'package:abctech/model/assist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class OrderPage extends GetView<OrderController> {
  OrderPage({Key? key}) : super(key: key);

  Widget _renderAssists(List<Assist> assists) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: assists.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(assists[index].name),
          subtitle: Text(assists[index].description),
        );
      },
    );
  }

  @override
  Widget buildForm(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: controller.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(children: [
              Expanded(
                child: Text(
                  "Preencha o formulário de ordem de serviço",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ]),
            TextFormField(
              controller: controller.operatorIdController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                labelText: 'Código do prestador',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'O código do prestador é obrigatório';
                }
                return null;
              },
            ),
            Row(
              children: [
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(top: 25, bottom: 25),
                  child: Text(
                    "Selecione as assistências a serem realizadas:",
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                )),
                Ink(
                  decoration: const ShapeDecoration(
                      shape: CircleBorder(), color: Colors.orange),
                  width: 40,
                  height: 40,
                  child: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () => controller.selectAssists()),
                ),
              ],
            ),
            Obx(() => _renderAssists(controller.selectedAssists)),
            Row(children: [
              Expanded(
                child: Obx(() {
                  if (controller.screenState.value == OrderState.started) {
                    return const Text(
                      "Ordem de serviço iniciada",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    );
                  }
                  return const SizedBox();
                }),
              ),
            ]),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => controller.finishStartOrder(),
                  child: Obx(() {
                    if (controller.screenState.value == OrderState.creating) {
                      return const Text("Iniciar");
                    } else {
                      return const Text("Finalizar");
                    }
                  }),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário'),
      ),
      body: Container(
        constraints: const BoxConstraints.expand(),
        padding: const EdgeInsets.all(10),
        child: controller.obx(
          (state) => buildForm(context),
          onLoading: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
