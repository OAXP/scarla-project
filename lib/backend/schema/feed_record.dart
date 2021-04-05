import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'feed_record.g.dart';

abstract class FeedRecord implements Built<FeedRecord, FeedRecordBuilder> {
  static Serializer<FeedRecord> get serializer => _$feedRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'author_id')
  String get authorId;

  @nullable
  @BuiltValueField(wireName: 'author_name')
  String get authorName;

  @nullable
  String get content;

  @nullable
  String get game;

  @nullable
  String get id;

  @nullable
  int get timestamp;

  @nullable
  int get type;

  @nullable
  @BuiltValueField(wireName: 'author_photo_url')
  String get authorPhotoUrl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(FeedRecordBuilder builder) => builder
    ..authorId = ''
    ..authorName = ''
    ..content = ''
    ..game = ''
    ..id = ''
    ..timestamp = 0
    ..type = 0
    ..authorPhotoUrl = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('feed');

  static Stream<FeedRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  FeedRecord._();
  factory FeedRecord([void Function(FeedRecordBuilder) updates]) = _$FeedRecord;
}

Map<String, dynamic> createFeedRecordData({
  String authorId,
  String authorName,
  String content,
  String game,
  String id,
  int timestamp,
  int type,
  String authorPhotoUrl,
}) =>
    serializers.serializeWith(
        FeedRecord.serializer,
        FeedRecord((f) => f
          ..authorId = authorId
          ..authorName = authorName
          ..content = content
          ..game = game
          ..id = id
          ..timestamp = timestamp
          ..type = type
          ..authorPhotoUrl = authorPhotoUrl));

FeedRecord get dummyFeedRecord {
  final builder = FeedRecordBuilder()
    ..authorId = dummyString
    ..authorName = dummyString
    ..content = dummyString
    ..game = dummyString
    ..id = dummyString
    ..timestamp = dummyInteger
    ..type = dummyInteger
    ..authorPhotoUrl = dummyImagePath;
  return builder.build();
}

List<FeedRecord> createDummyFeedRecord({int count}) =>
    List.generate(count, (_) => dummyFeedRecord);