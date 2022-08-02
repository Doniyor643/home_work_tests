import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:home_work_tests/pages/update_page.dart';

import '../model/post_model.dart';
import '../services/http_service.dart';
import 'create_page.dart';
import 'detail_page.dart';


class HomePage extends StatefulWidget {
  static final String id = 'home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];
  bool isLoading = false;

  _apiPostList() async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());

    setState(() {
      if (response != null) {
        items = Network.parsePostList(response);
      }

      isLoading = false;
    });
  }

  _apiPostDelete(Post post) async {
    setState(() {
      isLoading = true;
    });

    var response = await Network.DEL(
        Network.API_DELETE + post.id.toString(), Network.paramsEmpty());

    setState(() {
      if (response != null) {
        _apiPostList();
      }

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _apiPostList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetState'),
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPosts(items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.pushNamed(context, CreatePage.id);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget itemOfPosts(Post post) {
    return Slidable(
      endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.red,
              onPressed: (context){
                _apiPostDelete(post);
              },
              icon: Icons.delete_outline,
              label: "Delete",),
          ]),
      startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              backgroundColor: Colors.green,
              onPressed: (context){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UpdatePage(title: post.title, body: post.body)));
              },
              icon: Icons.drive_file_rename_outline,
              label: "Rename",),
          ]),
      child:  GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(uid: post.id!),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                post.title.toUpperCase(),
                style:
                const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),

              const SizedBox(
                height: 5,
              ),

              // Body
              Text(post.body),
            ],
          ),
        ),
      ),
    );

  }
}
