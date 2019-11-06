import 'dart:convert';
import 'dart:core' as prefix1;
import 'dart:core';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_chopper/data/post_api_service.dart';
import 'package:flutter_app_chopper/single_posts_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      appBar: AppBar(
        title: Text('Chopper Blog'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final response = await Provider.of<PostApiService>(context)
              .postPost({'key': 'value'});

          print(response.body);
        },
      ),
    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder<Response>(
        future: Provider.of<PostApiService>(context).getPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final List posts = json.decode(snapshot.data.bodyString);
            return _buildPosts(context, posts);
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
    );
  }

  ListView _buildPosts(BuildContext context, List posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child:ListTile(
            title: Text(
              posts[index]['title'],
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index]['body']),
            onTap: () => _navigateToPost(context,posts[index]['id']),
          ),
        );
      },
    );
  }

  void _navigateToPost(BuildContext context,int id){
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SinglePostPage(postId:id),
    ));
  }
}
