import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'users.g.dart';

abstract class Users implements Built<Users, UsersBuilder> {
  static Serializer<Users> get serializer => _$usersSerializer;

  @nullable
  String get about;

  @nullable
  String get id;

  @nullable
  String get name;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersBuilder builder) => builder
    ..about = ''
    ..id = ''
    ..name = ''
    ..photoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<Users> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  Users._();
  factory Users([void Function(UsersBuilder) updates]) = _$Users;
}

Map<String, dynamic> createUsersRecordData({
  String about,
  String id,
  String name,
  String photoUrl,
}) =>
    serializers.serializeWith(
        Users.serializer,
        Users((u) => u
          ..about = about
          ..id = id
          ..name = name
          ..photoUrl = photoUrl));

Users get dummyUsers {
  final builder = UsersBuilder()
    ..about = dummyString
    ..id = dummyString
    ..name = dummyString
    ..photoUrl = dummyImagePath;
  return builder.build();
}

List<Users> createDummyUsers({int count}) =>
    List.generate(count, (_) => dummyUsers);
