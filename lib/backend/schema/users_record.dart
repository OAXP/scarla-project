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
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'TAG')
  String get tag;

  @nullable
  int get sexe;

  @nullable
  bool get isAdult;

  @nullable
  bool get isCompetitive;

  @nullable
  bool get isToxic;

  @nullable
  DocumentReference get ranksRef;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  Timestamp get createdTime;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'selected_games')
  BuiltList<bool> get selectedGames;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..about = ''
    ..id = ''
    ..name = ''
    ..photoUrl = ''
    ..bgProfile = ''
    ..email = ''
    ..displayName = ''
    ..tag = ''
    ..sexe = 0
    ..isAdult = false
    ..isCompetitive = false
    ..isToxic = false
    ..uid = ''
    ..selectedGames = ListBuilder();

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
  String email,
  String displayName,
  String tag,
  int sexe,
  bool isAdult,
  bool isCompetitive,
  bool isToxic,
  DocumentReference ranksRef,
  Timestamp createdTime,
  String uid,
}) =>
    serializers.serializeWith(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..about = about
          ..id = id
          ..name = name
          ..photoUrl = photoUrl
          ..bgProfile = bgProfile
          ..email = email
          ..displayName = displayName
          ..tag = tag
          ..sexe = sexe
          ..isAdult = isAdult
          ..isCompetitive = isCompetitive
          ..isToxic = isToxic
          ..ranksRef = ranksRef
          ..createdTime = createdTime
          ..uid = uid));

UsersRecord get dummyUsersRecord {
  final builder = UsersRecordBuilder()
    ..about = dummyString
    ..id = dummyString
    ..name = dummyString
    ..photoUrl = dummyImagePath
    ..bgProfile = dummyImagePath
    ..email = dummyString
    ..displayName = dummyString
    ..tag = dummyString
    ..sexe = dummyInteger
    ..isAdult = dummyBoolean
    ..isCompetitive = dummyBoolean
    ..isToxic = dummyBoolean
    ..createdTime = dummyTimestamp
    ..uid = dummyString
    ..selectedGames = ListBuilder([dummyBoolean, dummyBoolean]);
  return builder.build();
}

List<UsersRecord> createDummyUsersRecord({int count}) =>
    List.generate(count, (_) => dummyUsersRecord);
