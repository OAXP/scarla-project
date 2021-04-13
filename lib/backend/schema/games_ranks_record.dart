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
  @BuiltValueField(wireName: 'RL')
  int get rl;

  @nullable
  int get lol;

  @nullable
  int get overwatch;

  @nullable
  int get valorant;

  @nullable
  DocumentReference get userRef;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GamesRanksRecordBuilder builder) => builder
    ..rl = 0
    ..lol = 0
    ..overwatch = 0
    ..valorant = 0;

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
  int rl,
  int lol,
  int overwatch,
  int valorant,
  DocumentReference userRef,
}) =>
    serializers.serializeWith(
        GamesRanksRecord.serializer,
        GamesRanksRecord((g) => g
          ..rl = rl
          ..lol = lol
          ..overwatch = overwatch
          ..valorant = valorant
          ..userRef = userRef));

GamesRanksRecord get dummyGamesRanksRecord {
  final builder = GamesRanksRecordBuilder()
    ..rl = dummyInteger
    ..lol = dummyInteger
    ..overwatch = dummyInteger
    ..valorant = dummyInteger;
  return builder.build();
}

List<GamesRanksRecord> createDummyGamesRanksRecord({int count}) =>
    List.generate(count, (_) => dummyGamesRanksRecord);
