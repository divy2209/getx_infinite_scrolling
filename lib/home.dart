import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ListDataX extends GetxController {
  List<int> numbers = List<int>.from([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14]);

  void httpCall() async {
    await Future.delayed(Duration(seconds: 1), () => numbers.add(numbers.last + 1));
    update();
  }

  void reset() {
    numbers = numbers.sublist(0, 14);
    update();
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();
  ListDataX dx = Get.put(ListDataX());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        dx.httpCall();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: GetBuilder<ListDataX>(
                builder: (_dx) => ListView.builder(
                    controller: scrollController,
                    itemCount: _dx.numbers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Number: ${_dx.numbers[index]}'),
                      );
                    }
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    child: Text('http request'),
                    onPressed: dx.httpCall,
                  ),
                  ElevatedButton(
                    child: Text('reset'),
                    onPressed: dx.reset,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
