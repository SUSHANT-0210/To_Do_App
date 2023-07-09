import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/api/firebase_api.dart';
import 'package:to_do_app/main.dart';
import 'package:to_do_app/model/todo.dart';
import 'package:to_do_app/provider/todos.dart';
import 'package:to_do_app/widget/add_todo_dialog.dart';
import 'package:to_do_app/widget/completed_list_widget.dart';
import 'package:to_do_app/widget/todo_list_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  Widget build(BuildContext context) {
    final tabs = [ToDoListWidget(), CompletedListWidget()];
    return Scaffold(
      appBar: AppBar(
        title: const Text(MyApp.title),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        // onTap: (index) => setState(() {
        //   _pageController.animateToPage(index,
        //       duration: Duration(microseconds: 200), curve: Curves.linear);
        //   selectedIndex = index;
        // }),
        onTap: (index) {
          _pageController.animateToPage(index,
              duration: Duration(microseconds: 200), curve: Curves.linear);
          selectedIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined), label: 'Todos'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.done,
                size: 28,
              ),
              label: 'Completed'),
        ],
      ),
      body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              selectedIndex = page;
            });
          },
          children: <Widget>[
            StreamBuilder<List<ToDo>>(
                stream: FirebaseApi.readTodos(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    default:
                      if (snapshot.hasError) {
                        // print(snapshot.hasError);
                        return Center(
                            child: Text('Something Went Wrong Try Later'));
                      } else {
                        final todos = snapshot.data;

                        final provider = Provider.of<TodosProvider>(context);
                        provider.setTodos(todos!);

                        return tabs[selectedIndex];
                      }
                  }
                }),
          ]),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.black,
        onPressed: () => showDialog(
          context: context,
          // child: AddToDoDialogWidget(),
          barrierDismissible: false,
          builder: (BuildContext context) => AddToDoDialogWidget(),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
