import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'g_messages_record.g.dart';

abstract class GMessagesRecord
    implements Built<GMessagesRecord, GMessagesRecordBuilder> {
  static Serializer<GMessagesRecord> get serializer =>
      _$gMessagesRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'author_id')
  String get authorId;

  @nullable
  @BuiltValueField(wireName: 'group_ref')
  DocumentReference get groupRef;

  @nullable
  int get type;

  @nullable
  String get value;

  @nullable
  @BuiltValueField(wireName: 'author_name')
  String get authorName;

  @nullable
  @BuiltValueField(wireName: 'author_pf')
  String get authorPf;

  @nullable
  Timestamp get timestamp;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GMessagesRecordBuilder builder) => builder
    ..authorId = ''
    ..type = 0
    ..value = ''
    ..authorName = ''
    ..authorPf = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('g_messages');

  static Stream<GMessagesRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GMessagesRecord._();
  factory GMessagesRecord([void Function(GMessagesRecordBuilder) updates]) =
      _$GMessagesRecord;
}

Map<String, dynamic> createGMessagesRecordData({
  String authorId,
  DocumentReference groupRef,
  int type,
  String value,
  String authorName,
  String authorPf,
  Timestamp timestamp,
}) =>
    serializers.serializeWith(
        GMessagesRecord.serializer,
        GMessagesRecord((g) => g
          ..authorId = authorId
          ..groupRef = groupRef
          ..type = type
          ..value = value
          ..authorName = authorName
          ..authorPf = authorPf
          ..timestamp = timestamp));

GMessagesRecord get dummyGMessagesRecord {
  final builder = GMessagesRecordBuilder()
    ..authorId = dummyString
    ..type = dummyInteger
    ..value = dummyString
    ..authorName = dummyString
    ..authorPf = dummyImagePath
    ..timestamp = dummyTimestamp;
  return builder.build();
}

List<GMessagesRecord> createDummyGMessagesRecord({int count}) =>
    List.generate(count, (_) => dummyGMessagesRecord);
