import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'groups.g.dart';

abstract class Groups implements Built<Groups, GroupsBuilder> {
  static Serializer<Groups> get serializer => _$groupsSerializer;

  @nullable
  @BuiltValueField(wireName: 'g_id')
  String get gId;

  @nullable
  @BuiltValueField(wireName: 'g_name')
  String get gName;

  @nullable
  @BuiltValueField(wireName: 'g_photo_url')
  String get gPhotoUrl;

  @nullable
  @BuiltValueField(wireName: 'last_message')
  String get lastMessage;

  @nullable
  DocumentReference get messages;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GroupsBuilder builder) => builder
    ..gId = ''
    ..gName = ''
    ..gPhotoUrl = ''
    ..lastMessage = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('groups');

  static Stream<Groups> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  Groups._();
  factory Groups([void Function(GroupsBuilder) updates]) = _$Groups;
}

Map<String, dynamic> createGroupsRecordData({
  String gId,
  String gName,
  String gPhotoUrl,
  String lastMessage,
  DocumentReference messages,
}) =>
    serializers.serializeWith(
        Groups.serializer,
        Groups((g) => g
          ..gId = gId
          ..gName = gName
          ..gPhotoUrl = gPhotoUrl
          ..lastMessage = lastMessage
          ..messages = messages));

Groups get dummyGroups {
  final builder = GroupsBuilder()
    ..gId = dummyString
    ..gName = dummyString
    ..gPhotoUrl = dummyImagePath
    ..lastMessage = dummyString;
  return builder.build();
}

List<Groups> createDummyGroups({int count}) =>
    List.generate(count, (_) => dummyGroups);
