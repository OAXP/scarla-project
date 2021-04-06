import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'friends_record.g.dart';

abstract class FriendsRecord
    implements Built<FriendsRecord, FriendsRecordBuilder> {
  static Serializer<FriendsRecord> get serializer => _$friendsRecordSerializer;

  @nullable
  String get id;

  @nullable
  DocumentReference get friendA;

  @nullable
  DocumentReference get friendB;

  @nullable
  int get timestemp;

  @nullable
  int get status;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FriendsRecordBuilder builder) => builder
    ..id = ''
    ..timestemp = 0
    ..status = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('friends');

  static Stream<FriendsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FriendsRecord._();
  factory FriendsRecord([void Function(FriendsRecordBuilder) updates]) =
      _$FriendsRecord;
}

Map<String, dynamic> createFriendsRecordData({
  String id,
  DocumentReference friendA,
  DocumentReference friendB,
  int timestemp,
  int status,
}) =>
    serializers.serializeWith(
        FriendsRecord.serializer,
        FriendsRecord((f) => f
          ..id = id
          ..friendA = friendA
          ..friendB = friendB
          ..timestemp = timestemp
          ..status = status));

FriendsRecord get dummyFriendsRecord {
  final builder = FriendsRecordBuilder()
    ..id = dummyString
    ..timestemp = dummyInteger
    ..status = dummyInteger;
  return builder.build();
}

List<FriendsRecord> createDummyFriendsRecord({int count}) =>
    List.generate(count, (_) => dummyFriendsRecord);
