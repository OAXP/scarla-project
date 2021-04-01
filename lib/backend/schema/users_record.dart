import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

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
  String get bgProfile;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..about = ''
    ..id = ''
    ..name = ''
    ..photoUrl = ''
    ..bgProfile = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;
}

Map<String, dynamic> createUsersRecordData({
  String about,
  String id,
  String name,
  String photoUrl,
  String bgProfile,
}) =>
    serializers.serializeWith(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..about = about
          ..id = id
          ..name = name
          ..photoUrl = photoUrl
          ..bgProfile = bgProfile));

UsersRecord get dummyUsersRecord {
  final builder = UsersRecordBuilder()
    ..about = dummyString
    ..id = dummyString
    ..name = dummyString
    ..photoUrl = dummyImagePath
    ..bgProfile = dummyImagePath;
  return builder.build();
}

List<UsersRecord> createDummyUsersRecord({int count}) =>
    List.generate(count, (_) => dummyUsersRecord);
