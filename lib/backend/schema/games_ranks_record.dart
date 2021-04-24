import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:built_collection/built_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'schema_util.dart';
import 'serializers.dart';

part 'games_ranks_record.g.dart';

abstract class GamesRanksRecord
    implements Built<GamesRanksRecord, GamesRanksRecordBuilder> {
  static Serializer<GamesRanksRecord> get serializer =>
      _$gamesRanksRecordSerializer;

  @nullable
  DocumentReference get userRef;

  @nullable
  int get lol;

  @nullable
  int get valorant;

  @nullable
  int get mw;

  @nullable
  int get ow;

  @nullable
  int get rl;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GamesRanksRecordBuilder builder) => builder
    ..lol = 0
    ..valorant = 0
    ..mw = 0
    ..ow = 0
    ..rl = 0;

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('games_ranks');

  static Stream<GamesRanksRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GamesRanksRecord._();
  factory GamesRanksRecord([void Function(GamesRanksRecordBuilder) updates]) =
      _$GamesRanksRecord;
}

Map<String, dynamic> createGamesRanksRecordData({
  DocumentReference userRef,
  int lol,
  int valorant,
  int mw,
  int ow,
  int rl,
}) =>
    serializers.serializeWith(
        GamesRanksRecord.serializer,
        GamesRanksRecord((g) => g
          ..userRef = userRef
          ..lol = lol
          ..valorant = valorant
          ..mw = mw
          ..ow = ow
          ..rl = rl));

GamesRanksRecord get dummyGamesRanksRecord {
  final builder = GamesRanksRecordBuilder()
    ..lol = dummyInteger
    ..valorant = dummyInteger
    ..mw = dummyInteger
    ..ow = dummyInteger
    ..rl = dummyInteger;
  return builder.build();
}

List<GamesRanksRecord> createDummyGamesRanksRecord({int count}) =>
    List.generate(count, (_) => dummyGamesRanksRecord);
