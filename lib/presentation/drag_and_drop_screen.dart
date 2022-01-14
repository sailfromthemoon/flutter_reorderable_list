import 'package:drag_and_drop_lists/drag_and_drop_list_interface.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:reordable_listview_task/domain/model/ext_training.dart';
import 'package:reordable_listview_task/domain/model/training.dart';
import 'package:reordable_listview_task/domain/repository/training_repository.dart';
import 'package:reordable_listview_task/internal/dependencies/repository_module.dart';

class DragAndDropScreen extends StatefulWidget {
  const DragAndDropScreen({Key? key}) : super(key: key);

  @override
  _DragAndDropScreenState createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  List<DragAndDropList> lists = [];

  @override
  void didChangeDependencies() async {
    var trainings = await getExtTrainings();

    print(trainings);
    setState(() {
      lists = trainings.map(buildList).toList();
    });

    super.didChangeDependencies();
  }

  Future<List<ExtTrainingList>> getExtTrainings() async {
    final TrainingRepository repo = RepositoryModule.trainingRepository();
    var trainings = await repo.getExtTrainings();
    return trainings;
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(255, 243, 242, 248);

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: FloatingActionButton(
                      heroTag: "removeButton",
                      backgroundColor: Colors.red,
                      elevation: 0.0,
                      child: const Icon(Icons.remove),
                      onPressed: () {
                        if (lists
                            .where((element) => element.children.isEmpty)
                            .isNotEmpty) {
                          var index = lists.lastIndexWhere(
                              (element) => element.children.isEmpty);
                          setState(() {
                            lists.removeAt(index);
                          });
                        }
                      }),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 50,
                height: 50,
                child: FittedBox(
                  child: FloatingActionButton(
                      heroTag: "addButton",
                      elevation: 0.0,
                      backgroundColor: Colors.green,
                      child: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          lists.add(
                            DragAndDropList(
                              children: [],
                              header: Container(
                                padding: EdgeInsets.all(8),
                                child: Text(
                                  (lists.length + 1).toString(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ),
                          );
                        });
                      }),
                ),
              )
            ],
          ),
          // SizedBox(
          //   width: 50,
          //   height: 50,
          //   child: FittedBox(
          //     child: FloatingActionButton(
          //         heroTag: "sendButton",
          //         elevation: 0.0,
          //         child: const Icon(Icons.send),
          //         onPressed: () {
          //           setState(() {
          //             lists.add(
          //               DragAndDropList(
          //                 children: [],
          //                 header: Container(
          //                   padding: const EdgeInsets.all(8),
          //                   child: Text(
          //                     (lists.length + 1).toString(),
          //                     style: const TextStyle(
          //                         fontWeight: FontWeight.bold, fontSize: 16),
          //                   ),
          //                 ),
          //               ),
          //             );
          //           });
          //         }),
          //   ),
          // )
        ],
      ),
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Drag And Drop'),
        centerTitle: true,
      ),
      body: DragAndDropLists(
        listPadding: const EdgeInsets.all(16),
        listInnerDecoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        children: lists,
        itemDivider:
            const Divider(thickness: 2, height: 2, color: backgroundColor),
        itemDecorationWhileDragging: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        listDragHandle: buildDragHandle(isList: true),
        onItemReorder: onReorderListItem,
        onListReorder: onReorderList,
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.black26;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Container(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(Icons.drag_handle, color: color),
      ),
    );
  }

  DragAndDropList buildList(ExtTrainingList list) => DragAndDropList(
        header: Container(
          padding: const EdgeInsets.all(8),
          child: Text(
            'order: ${list.order.toString()}',
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.orange),
          ),
        ),
        children: list.superset
            .map((item) => DragAndDropItem(
                  child: ListTile(
                    leading: Text(item.orderPrefix),
                    title: Text(
                      'id: ${item.id.toString()}',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;

      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }
}
