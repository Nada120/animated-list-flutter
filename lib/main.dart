import 'package:flutter/material.dart';
import 'card_comp.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animated List',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // the items of list
  final items = [];

  // the key of the animated list which
  // helps to create animation
  final keyAnimated = GlobalKey<AnimatedListState>();

  // Add items to list with animation function
  void addItemToList() {
    // (start point, the item we insert to list)
    items.insert(0, 'Item ${items.length+1}');

    // will insert item in the list //start point // the animation time that will be displayed
    keyAnimated.currentState?.insertItem(0, duration: const Duration(seconds: 1));
  }
  
  // Remove items from list with animation function
  void removeItemFromList(int index) {
    // to save the deleted item so we can use it in latter
    final removedItem = items[index];
    // remove item from the list
    items.removeAt(index);
    // will remove item from the list with adding animation 
    keyAnimated.currentState?.removeItem(index, (_, animation) {
      return MyCardComp(
        // save the changes only on currnet item that will be removed 
        keyVal: ValueKey(removedItem),
        // add animation
        animation: animation,
        color: const Color.fromARGB(255, 152, 5, 86),
        item: 'Deleted',
      );
    },
    // the animation time that will be displayed
    duration: const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 253, 197, 140),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 110, 5, 35),
        centerTitle: true,
        title: const Text(
          'Flutter Mapp',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          // apple to click on the object
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: ElevatedButton(
                onPressed: () {
                  // on tap will add Item to the list
                  addItemToList();
                },
                // set the style of the button
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 197, 140),
                  elevation: 0,
                  // make the shape as rectagle shape
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 60,
                  color: Color.fromARGB(255, 110, 5, 35),
                ),
              ),
            ),
          ),
          SizedBox(
            // To set the height of the content that has the list Items
            height: MediaQuery.of(context).size.height / 1.4,
            // Can apply animation to the List
            child: AnimatedList(
              key: keyAnimated,
              // The nubmer of the items but will increase using function addItemToList()
              initialItemCount: 0,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              // Building the components of the list
              //      current page//index of list//type of animation
              itemBuilder: (_, index, animation) {
                // Make Animation which include transition animation
                //"moving items to specific direction & change size"
                return MyCardComp(
                  // add unique key to each widget that help us in remove specific widget
                  keyVal: UniqueKey(), 
                  // add the animation
                  animation: animation, 
                  color: const Color.fromARGB(255, 21, 2, 74),
                  item: items[index],
                  // on pressed delete icon the removeItem function will display
                  process: () => removeItemFromList(index),
                ); 
              },
            ),
          ),
        ],
      ),
    );
  }
}
