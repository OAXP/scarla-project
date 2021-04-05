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
  int get timestamp;

  @nullable
  int get type;

  @nullable
  String get value;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GMessagesRecordBuilder builder) => builder
    ..authorId = ''
    ..timestamp = 0
    ..type = 0
    ..value = '';

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
  int timestamp,
  int type,
  String value,
}) =>
    serializers.serializeWith(
        GMessagesRecord.serializer,
        GMessagesRecord((g) => g
          ..authorId = authorId
          ..groupRef = groupRef
          ..timestamp = timestamp
          ..type = type
          ..value = value));

GMessagesRecord get dummyGMessagesRecord {
  final builder = GMessagesRecordBuilder()
    ..authorId = dummyString
    ..timestamp = dummyInteger
    ..type = dummyInteger
    ..value = dummyString;
  return builder.build();
}

List<GMessagesRecord> createDummyGMessagesRecord({int count}) =>
    List.generate(count, (_) => dummyGMessagesRecord);
