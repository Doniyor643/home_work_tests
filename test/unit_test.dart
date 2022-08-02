import 'package:flutter_test/flutter_test.dart';
import 'package:home_work_tests/model/post_model.dart';
import 'package:home_work_tests/services/http_service.dart';

void main() {
  test('Posts is not null', () async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response!);
    expect(posts, isNotNull);
  });

  test('Posts is exactly 100', () async {
    var response = await Network.GET(Network.API_LIST, Network.paramsEmpty());
    List<Post> posts = Network.parsePostList(response!);
    expect(posts.length, equals(100));
  });
}