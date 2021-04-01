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
  @BuiltValueField(wireName: 'g_id')
  int get gId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GMessagesRecordBuilder builder) =>
      builder..gId = 0;

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
  int gId,
}) =>
    serializers.serializeWith(
        GMessagesRecord.serializer, GMessagesRecord((g) => g..gId = gId));

GMessagesRecord get dummyGMessagesRecord {
  final builder = GMessagesRecordBuilder()..gId = dummyInteger;
  return builder.build();
}

List<GMessagesRecord> createDummyGMessagesRecord({int count}) =>
    List.generate(count, (_) => dummyGMessagesRecord);
