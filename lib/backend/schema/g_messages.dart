import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'g_messages.g.dart';

abstract class GMessages implements Built<GMessages, GMessagesBuilder> {
  static Serializer<GMessages> get serializer => _$gMessagesSerializer;

  @nullable
  @BuiltValueField(wireName: 'g_id')
  int get gId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GMessagesBuilder builder) => builder..gId = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('g_messages');

  static Stream<GMessages> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GMessages._();
  factory GMessages([void Function(GMessagesBuilder) updates]) = _$GMessages;
}

Map<String, dynamic> createGMessagesRecordData({
  int gId,
}) =>
    serializers.serializeWith(
        GMessages.serializer, GMessages((g) => g..gId = gId));

GMessages get dummyGMessages {
  final builder = GMessagesBuilder()..gId = dummyInteger;
  return builder.build();
}

List<GMessages> createDummyGMessages({int count}) =>
    List.generate(count, (_) => dummyGMessages);
