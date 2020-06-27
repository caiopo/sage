// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Survey extends DataClass implements Insertable<Survey> {
  final String uuid;
  final String title;
  final String owner;
  final int uploadedAnswers;
  Survey(
      {@required this.uuid,
      @required this.title,
      @required this.owner,
      @required this.uploadedAnswers});
  factory Survey.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final intType = db.typeSystem.forDartType<int>();
    return Survey(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      owner:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}owner']),
      uploadedAnswers: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}uploaded_answers']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || owner != null) {
      map['owner'] = Variable<String>(owner);
    }
    if (!nullToAbsent || uploadedAnswers != null) {
      map['uploaded_answers'] = Variable<int>(uploadedAnswers);
    }
    return map;
  }

  SurveysCompanion toCompanion(bool nullToAbsent) {
    return SurveysCompanion(
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      owner:
          owner == null && nullToAbsent ? const Value.absent() : Value(owner),
      uploadedAnswers: uploadedAnswers == null && nullToAbsent
          ? const Value.absent()
          : Value(uploadedAnswers),
    );
  }

  factory Survey.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Survey(
      uuid: serializer.fromJson<String>(json['uuid']),
      title: serializer.fromJson<String>(json['title']),
      owner: serializer.fromJson<String>(json['owner']),
      uploadedAnswers: serializer.fromJson<int>(json['uploadedAnswers']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'title': serializer.toJson<String>(title),
      'owner': serializer.toJson<String>(owner),
      'uploadedAnswers': serializer.toJson<int>(uploadedAnswers),
    };
  }

  Survey copyWith(
          {String uuid, String title, String owner, int uploadedAnswers}) =>
      Survey(
        uuid: uuid ?? this.uuid,
        title: title ?? this.title,
        owner: owner ?? this.owner,
        uploadedAnswers: uploadedAnswers ?? this.uploadedAnswers,
      );
  @override
  String toString() {
    return (StringBuffer('Survey(')
          ..write('uuid: $uuid, ')
          ..write('title: $title, ')
          ..write('owner: $owner, ')
          ..write('uploadedAnswers: $uploadedAnswers')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(uuid.hashCode,
      $mrjc(title.hashCode, $mrjc(owner.hashCode, uploadedAnswers.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Survey &&
          other.uuid == this.uuid &&
          other.title == this.title &&
          other.owner == this.owner &&
          other.uploadedAnswers == this.uploadedAnswers);
}

class SurveysCompanion extends UpdateCompanion<Survey> {
  final Value<String> uuid;
  final Value<String> title;
  final Value<String> owner;
  final Value<int> uploadedAnswers;
  const SurveysCompanion({
    this.uuid = const Value.absent(),
    this.title = const Value.absent(),
    this.owner = const Value.absent(),
    this.uploadedAnswers = const Value.absent(),
  });
  SurveysCompanion.insert({
    @required String uuid,
    @required String title,
    @required String owner,
    @required int uploadedAnswers,
  })  : uuid = Value(uuid),
        title = Value(title),
        owner = Value(owner),
        uploadedAnswers = Value(uploadedAnswers);
  static Insertable<Survey> custom({
    Expression<String> uuid,
    Expression<String> title,
    Expression<String> owner,
    Expression<int> uploadedAnswers,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (title != null) 'title': title,
      if (owner != null) 'owner': owner,
      if (uploadedAnswers != null) 'uploaded_answers': uploadedAnswers,
    });
  }

  SurveysCompanion copyWith(
      {Value<String> uuid,
      Value<String> title,
      Value<String> owner,
      Value<int> uploadedAnswers}) {
    return SurveysCompanion(
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      owner: owner ?? this.owner,
      uploadedAnswers: uploadedAnswers ?? this.uploadedAnswers,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (owner.present) {
      map['owner'] = Variable<String>(owner.value);
    }
    if (uploadedAnswers.present) {
      map['uploaded_answers'] = Variable<int>(uploadedAnswers.value);
    }
    return map;
  }
}

class $SurveysTable extends Surveys with TableInfo<$SurveysTable, Survey> {
  final GeneratedDatabase _db;
  final String _alias;
  $SurveysTable(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn(
      'uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _ownerMeta = const VerificationMeta('owner');
  GeneratedTextColumn _owner;
  @override
  GeneratedTextColumn get owner => _owner ??= _constructOwner();
  GeneratedTextColumn _constructOwner() {
    return GeneratedTextColumn(
      'owner',
      $tableName,
      false,
    );
  }

  final VerificationMeta _uploadedAnswersMeta =
      const VerificationMeta('uploadedAnswers');
  GeneratedIntColumn _uploadedAnswers;
  @override
  GeneratedIntColumn get uploadedAnswers =>
      _uploadedAnswers ??= _constructUploadedAnswers();
  GeneratedIntColumn _constructUploadedAnswers() {
    return GeneratedIntColumn(
      'uploaded_answers',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [uuid, title, owner, uploadedAnswers];
  @override
  $SurveysTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'surveys';
  @override
  final String actualTableName = 'surveys';
  @override
  VerificationContext validateIntegrity(Insertable<Survey> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid'], _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('owner')) {
      context.handle(
          _ownerMeta, owner.isAcceptableOrUnknown(data['owner'], _ownerMeta));
    } else if (isInserting) {
      context.missing(_ownerMeta);
    }
    if (data.containsKey('uploaded_answers')) {
      context.handle(
          _uploadedAnswersMeta,
          uploadedAnswers.isAcceptableOrUnknown(
              data['uploaded_answers'], _uploadedAnswersMeta));
    } else if (isInserting) {
      context.missing(_uploadedAnswersMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Survey map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Survey.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SurveysTable createAlias(String alias) {
    return $SurveysTable(_db, alias);
  }
}

class Question extends DataClass implements Insertable<Question> {
  final String uuid;
  final QuestionType type;
  final String title;
  final String description;
  final QuestionExtras extras;
  final bool optional;
  final String surveyUuid;
  Question(
      {@required this.uuid,
      @required this.type,
      @required this.title,
      @required this.description,
      @required this.extras,
      @required this.optional,
      @required this.surveyUuid});
  factory Question.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Question(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      type: $QuestionsTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}type'])),
      title:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}title']),
      description: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}description']),
      extras: $QuestionsTable.$converter1.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}extras'])),
      optional:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}optional']),
      surveyUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_uuid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    if (!nullToAbsent || type != null) {
      final converter = $QuestionsTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type));
    }
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || extras != null) {
      final converter = $QuestionsTable.$converter1;
      map['extras'] = Variable<String>(converter.mapToSql(extras));
    }
    if (!nullToAbsent || optional != null) {
      map['optional'] = Variable<bool>(optional);
    }
    if (!nullToAbsent || surveyUuid != null) {
      map['survey_uuid'] = Variable<String>(surveyUuid);
    }
    return map;
  }

  QuestionsCompanion toCompanion(bool nullToAbsent) {
    return QuestionsCompanion(
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      type: type == null && nullToAbsent ? const Value.absent() : Value(type),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      extras:
          extras == null && nullToAbsent ? const Value.absent() : Value(extras),
      optional: optional == null && nullToAbsent
          ? const Value.absent()
          : Value(optional),
      surveyUuid: surveyUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(surveyUuid),
    );
  }

  factory Question.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Question(
      uuid: serializer.fromJson<String>(json['uuid']),
      type: serializer.fromJson<QuestionType>(json['type']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      extras: serializer.fromJson<QuestionExtras>(json['extras']),
      optional: serializer.fromJson<bool>(json['optional']),
      surveyUuid: serializer.fromJson<String>(json['surveyUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'type': serializer.toJson<QuestionType>(type),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'extras': serializer.toJson<QuestionExtras>(extras),
      'optional': serializer.toJson<bool>(optional),
      'surveyUuid': serializer.toJson<String>(surveyUuid),
    };
  }

  Question copyWith(
          {String uuid,
          QuestionType type,
          String title,
          String description,
          QuestionExtras extras,
          bool optional,
          String surveyUuid}) =>
      Question(
        uuid: uuid ?? this.uuid,
        type: type ?? this.type,
        title: title ?? this.title,
        description: description ?? this.description,
        extras: extras ?? this.extras,
        optional: optional ?? this.optional,
        surveyUuid: surveyUuid ?? this.surveyUuid,
      );
  @override
  String toString() {
    return (StringBuffer('Question(')
          ..write('uuid: $uuid, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('extras: $extras, ')
          ..write('optional: $optional, ')
          ..write('surveyUuid: $surveyUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      uuid.hashCode,
      $mrjc(
          type.hashCode,
          $mrjc(
              title.hashCode,
              $mrjc(
                  description.hashCode,
                  $mrjc(extras.hashCode,
                      $mrjc(optional.hashCode, surveyUuid.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Question &&
          other.uuid == this.uuid &&
          other.type == this.type &&
          other.title == this.title &&
          other.description == this.description &&
          other.extras == this.extras &&
          other.optional == this.optional &&
          other.surveyUuid == this.surveyUuid);
}

class QuestionsCompanion extends UpdateCompanion<Question> {
  final Value<String> uuid;
  final Value<QuestionType> type;
  final Value<String> title;
  final Value<String> description;
  final Value<QuestionExtras> extras;
  final Value<bool> optional;
  final Value<String> surveyUuid;
  const QuestionsCompanion({
    this.uuid = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.extras = const Value.absent(),
    this.optional = const Value.absent(),
    this.surveyUuid = const Value.absent(),
  });
  QuestionsCompanion.insert({
    @required String uuid,
    @required QuestionType type,
    @required String title,
    @required String description,
    @required QuestionExtras extras,
    @required bool optional,
    @required String surveyUuid,
  })  : uuid = Value(uuid),
        type = Value(type),
        title = Value(title),
        description = Value(description),
        extras = Value(extras),
        optional = Value(optional),
        surveyUuid = Value(surveyUuid);
  static Insertable<Question> custom({
    Expression<String> uuid,
    Expression<String> type,
    Expression<String> title,
    Expression<String> description,
    Expression<String> extras,
    Expression<bool> optional,
    Expression<String> surveyUuid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (extras != null) 'extras': extras,
      if (optional != null) 'optional': optional,
      if (surveyUuid != null) 'survey_uuid': surveyUuid,
    });
  }

  QuestionsCompanion copyWith(
      {Value<String> uuid,
      Value<QuestionType> type,
      Value<String> title,
      Value<String> description,
      Value<QuestionExtras> extras,
      Value<bool> optional,
      Value<String> surveyUuid}) {
    return QuestionsCompanion(
      uuid: uuid ?? this.uuid,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      extras: extras ?? this.extras,
      optional: optional ?? this.optional,
      surveyUuid: surveyUuid ?? this.surveyUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (type.present) {
      final converter = $QuestionsTable.$converter0;
      map['type'] = Variable<String>(converter.mapToSql(type.value));
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (extras.present) {
      final converter = $QuestionsTable.$converter1;
      map['extras'] = Variable<String>(converter.mapToSql(extras.value));
    }
    if (optional.present) {
      map['optional'] = Variable<bool>(optional.value);
    }
    if (surveyUuid.present) {
      map['survey_uuid'] = Variable<String>(surveyUuid.value);
    }
    return map;
  }
}

class $QuestionsTable extends Questions
    with TableInfo<$QuestionsTable, Question> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuestionsTable(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn(
      'uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _typeMeta = const VerificationMeta('type');
  GeneratedTextColumn _type;
  @override
  GeneratedTextColumn get type => _type ??= _constructType();
  GeneratedTextColumn _constructType() {
    return GeneratedTextColumn(
      'type',
      $tableName,
      false,
    );
  }

  final VerificationMeta _titleMeta = const VerificationMeta('title');
  GeneratedTextColumn _title;
  @override
  GeneratedTextColumn get title => _title ??= _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn(
      'title',
      $tableName,
      false,
    );
  }

  final VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  GeneratedTextColumn _description;
  @override
  GeneratedTextColumn get description =>
      _description ??= _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn(
      'description',
      $tableName,
      false,
    );
  }

  final VerificationMeta _extrasMeta = const VerificationMeta('extras');
  GeneratedTextColumn _extras;
  @override
  GeneratedTextColumn get extras => _extras ??= _constructExtras();
  GeneratedTextColumn _constructExtras() {
    return GeneratedTextColumn(
      'extras',
      $tableName,
      false,
    );
  }

  final VerificationMeta _optionalMeta = const VerificationMeta('optional');
  GeneratedBoolColumn _optional;
  @override
  GeneratedBoolColumn get optional => _optional ??= _constructOptional();
  GeneratedBoolColumn _constructOptional() {
    return GeneratedBoolColumn(
      'optional',
      $tableName,
      false,
    );
  }

  final VerificationMeta _surveyUuidMeta = const VerificationMeta('surveyUuid');
  GeneratedTextColumn _surveyUuid;
  @override
  GeneratedTextColumn get surveyUuid => _surveyUuid ??= _constructSurveyUuid();
  GeneratedTextColumn _constructSurveyUuid() {
    return GeneratedTextColumn('survey_uuid', $tableName, false,
        $customConstraints: 'REFERENCES surveys(uuid)');
  }

  @override
  List<GeneratedColumn> get $columns =>
      [uuid, type, title, description, extras, optional, surveyUuid];
  @override
  $QuestionsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'questions';
  @override
  final String actualTableName = 'questions';
  @override
  VerificationContext validateIntegrity(Insertable<Question> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid'], _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title'], _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description'], _descriptionMeta));
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    context.handle(_extrasMeta, const VerificationResult.success());
    if (data.containsKey('optional')) {
      context.handle(_optionalMeta,
          optional.isAcceptableOrUnknown(data['optional'], _optionalMeta));
    } else if (isInserting) {
      context.missing(_optionalMeta);
    }
    if (data.containsKey('survey_uuid')) {
      context.handle(
          _surveyUuidMeta,
          surveyUuid.isAcceptableOrUnknown(
              data['survey_uuid'], _surveyUuidMeta));
    } else if (isInserting) {
      context.missing(_surveyUuidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Question map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Question.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $QuestionsTable createAlias(String alias) {
    return $QuestionsTable(_db, alias);
  }

  static TypeConverter<QuestionType, String> $converter0 =
      const EnumConverter(QuestionType.values);
  static TypeConverter<QuestionExtras, String> $converter1 =
      const QuestionExtrasConverter();
}

class Answer extends DataClass implements Insertable<Answer> {
  final String uuid;
  final DateTime createdAt;
  final bool finished;
  final String surveyUuid;
  Answer(
      {@required this.uuid,
      @required this.createdAt,
      @required this.finished,
      @required this.surveyUuid});
  factory Answer.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    final dateTimeType = db.typeSystem.forDartType<DateTime>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Answer(
      uuid: stringType.mapFromDatabaseResponse(data['${effectivePrefix}uuid']),
      createdAt: dateTimeType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      finished:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}finished']),
      surveyUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}survey_uuid']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || uuid != null) {
      map['uuid'] = Variable<String>(uuid);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    if (!nullToAbsent || finished != null) {
      map['finished'] = Variable<bool>(finished);
    }
    if (!nullToAbsent || surveyUuid != null) {
      map['survey_uuid'] = Variable<String>(surveyUuid);
    }
    return map;
  }

  AnswersCompanion toCompanion(bool nullToAbsent) {
    return AnswersCompanion(
      uuid: uuid == null && nullToAbsent ? const Value.absent() : Value(uuid),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      finished: finished == null && nullToAbsent
          ? const Value.absent()
          : Value(finished),
      surveyUuid: surveyUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(surveyUuid),
    );
  }

  factory Answer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Answer(
      uuid: serializer.fromJson<String>(json['uuid']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      finished: serializer.fromJson<bool>(json['finished']),
      surveyUuid: serializer.fromJson<String>(json['surveyUuid']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'finished': serializer.toJson<bool>(finished),
      'surveyUuid': serializer.toJson<String>(surveyUuid),
    };
  }

  Answer copyWith(
          {String uuid,
          DateTime createdAt,
          bool finished,
          String surveyUuid}) =>
      Answer(
        uuid: uuid ?? this.uuid,
        createdAt: createdAt ?? this.createdAt,
        finished: finished ?? this.finished,
        surveyUuid: surveyUuid ?? this.surveyUuid,
      );
  @override
  String toString() {
    return (StringBuffer('Answer(')
          ..write('uuid: $uuid, ')
          ..write('createdAt: $createdAt, ')
          ..write('finished: $finished, ')
          ..write('surveyUuid: $surveyUuid')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      uuid.hashCode,
      $mrjc(
          createdAt.hashCode, $mrjc(finished.hashCode, surveyUuid.hashCode))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Answer &&
          other.uuid == this.uuid &&
          other.createdAt == this.createdAt &&
          other.finished == this.finished &&
          other.surveyUuid == this.surveyUuid);
}

class AnswersCompanion extends UpdateCompanion<Answer> {
  final Value<String> uuid;
  final Value<DateTime> createdAt;
  final Value<bool> finished;
  final Value<String> surveyUuid;
  const AnswersCompanion({
    this.uuid = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.finished = const Value.absent(),
    this.surveyUuid = const Value.absent(),
  });
  AnswersCompanion.insert({
    @required String uuid,
    this.createdAt = const Value.absent(),
    this.finished = const Value.absent(),
    @required String surveyUuid,
  })  : uuid = Value(uuid),
        surveyUuid = Value(surveyUuid);
  static Insertable<Answer> custom({
    Expression<String> uuid,
    Expression<DateTime> createdAt,
    Expression<bool> finished,
    Expression<String> surveyUuid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (createdAt != null) 'created_at': createdAt,
      if (finished != null) 'finished': finished,
      if (surveyUuid != null) 'survey_uuid': surveyUuid,
    });
  }

  AnswersCompanion copyWith(
      {Value<String> uuid,
      Value<DateTime> createdAt,
      Value<bool> finished,
      Value<String> surveyUuid}) {
    return AnswersCompanion(
      uuid: uuid ?? this.uuid,
      createdAt: createdAt ?? this.createdAt,
      finished: finished ?? this.finished,
      surveyUuid: surveyUuid ?? this.surveyUuid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (finished.present) {
      map['finished'] = Variable<bool>(finished.value);
    }
    if (surveyUuid.present) {
      map['survey_uuid'] = Variable<String>(surveyUuid.value);
    }
    return map;
  }
}

class $AnswersTable extends Answers with TableInfo<$AnswersTable, Answer> {
  final GeneratedDatabase _db;
  final String _alias;
  $AnswersTable(this._db, [this._alias]);
  final VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  GeneratedTextColumn _uuid;
  @override
  GeneratedTextColumn get uuid => _uuid ??= _constructUuid();
  GeneratedTextColumn _constructUuid() {
    return GeneratedTextColumn(
      'uuid',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedDateTimeColumn _createdAt;
  @override
  GeneratedDateTimeColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn(
      'created_at',
      $tableName,
      false,
    )..clientDefault = () => DateTime.now();
  }

  final VerificationMeta _finishedMeta = const VerificationMeta('finished');
  GeneratedBoolColumn _finished;
  @override
  GeneratedBoolColumn get finished => _finished ??= _constructFinished();
  GeneratedBoolColumn _constructFinished() {
    return GeneratedBoolColumn('finished', $tableName, false,
        defaultValue: const Constant(false));
  }

  final VerificationMeta _surveyUuidMeta = const VerificationMeta('surveyUuid');
  GeneratedTextColumn _surveyUuid;
  @override
  GeneratedTextColumn get surveyUuid => _surveyUuid ??= _constructSurveyUuid();
  GeneratedTextColumn _constructSurveyUuid() {
    return GeneratedTextColumn('survey_uuid', $tableName, false,
        $customConstraints: 'REFERENCES surveys(uuid)');
  }

  @override
  List<GeneratedColumn> get $columns => [uuid, createdAt, finished, surveyUuid];
  @override
  $AnswersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'answers';
  @override
  final String actualTableName = 'answers';
  @override
  VerificationContext validateIntegrity(Insertable<Answer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uuid')) {
      context.handle(
          _uuidMeta, uuid.isAcceptableOrUnknown(data['uuid'], _uuidMeta));
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    }
    if (data.containsKey('finished')) {
      context.handle(_finishedMeta,
          finished.isAcceptableOrUnknown(data['finished'], _finishedMeta));
    }
    if (data.containsKey('survey_uuid')) {
      context.handle(
          _surveyUuidMeta,
          surveyUuid.isAcceptableOrUnknown(
              data['survey_uuid'], _surveyUuidMeta));
    } else if (isInserting) {
      context.missing(_surveyUuidMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uuid};
  @override
  Answer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Answer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $AnswersTable createAlias(String alias) {
    return $AnswersTable(_db, alias);
  }
}

class QuestionAnswer extends DataClass implements Insertable<QuestionAnswer> {
  final String answerUuid;
  final String questionUuid;
  final AnswerExtras extras;
  QuestionAnswer(
      {@required this.answerUuid,
      @required this.questionUuid,
      @required this.extras});
  factory QuestionAnswer.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return QuestionAnswer(
      answerUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}answer_uuid']),
      questionUuid: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}question_uuid']),
      extras: $QuestionAnswersTable.$converter0.mapToDart(
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}extras'])),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || answerUuid != null) {
      map['answer_uuid'] = Variable<String>(answerUuid);
    }
    if (!nullToAbsent || questionUuid != null) {
      map['question_uuid'] = Variable<String>(questionUuid);
    }
    if (!nullToAbsent || extras != null) {
      final converter = $QuestionAnswersTable.$converter0;
      map['extras'] = Variable<String>(converter.mapToSql(extras));
    }
    return map;
  }

  QuestionAnswersCompanion toCompanion(bool nullToAbsent) {
    return QuestionAnswersCompanion(
      answerUuid: answerUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(answerUuid),
      questionUuid: questionUuid == null && nullToAbsent
          ? const Value.absent()
          : Value(questionUuid),
      extras:
          extras == null && nullToAbsent ? const Value.absent() : Value(extras),
    );
  }

  factory QuestionAnswer.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return QuestionAnswer(
      answerUuid: serializer.fromJson<String>(json['answerUuid']),
      questionUuid: serializer.fromJson<String>(json['questionUuid']),
      extras: serializer.fromJson<AnswerExtras>(json['extras']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'answerUuid': serializer.toJson<String>(answerUuid),
      'questionUuid': serializer.toJson<String>(questionUuid),
      'extras': serializer.toJson<AnswerExtras>(extras),
    };
  }

  QuestionAnswer copyWith(
          {String answerUuid, String questionUuid, AnswerExtras extras}) =>
      QuestionAnswer(
        answerUuid: answerUuid ?? this.answerUuid,
        questionUuid: questionUuid ?? this.questionUuid,
        extras: extras ?? this.extras,
      );
  @override
  String toString() {
    return (StringBuffer('QuestionAnswer(')
          ..write('answerUuid: $answerUuid, ')
          ..write('questionUuid: $questionUuid, ')
          ..write('extras: $extras')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      answerUuid.hashCode, $mrjc(questionUuid.hashCode, extras.hashCode)));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is QuestionAnswer &&
          other.answerUuid == this.answerUuid &&
          other.questionUuid == this.questionUuid &&
          other.extras == this.extras);
}

class QuestionAnswersCompanion extends UpdateCompanion<QuestionAnswer> {
  final Value<String> answerUuid;
  final Value<String> questionUuid;
  final Value<AnswerExtras> extras;
  const QuestionAnswersCompanion({
    this.answerUuid = const Value.absent(),
    this.questionUuid = const Value.absent(),
    this.extras = const Value.absent(),
  });
  QuestionAnswersCompanion.insert({
    @required String answerUuid,
    @required String questionUuid,
    @required AnswerExtras extras,
  })  : answerUuid = Value(answerUuid),
        questionUuid = Value(questionUuid),
        extras = Value(extras);
  static Insertable<QuestionAnswer> custom({
    Expression<String> answerUuid,
    Expression<String> questionUuid,
    Expression<String> extras,
  }) {
    return RawValuesInsertable({
      if (answerUuid != null) 'answer_uuid': answerUuid,
      if (questionUuid != null) 'question_uuid': questionUuid,
      if (extras != null) 'extras': extras,
    });
  }

  QuestionAnswersCompanion copyWith(
      {Value<String> answerUuid,
      Value<String> questionUuid,
      Value<AnswerExtras> extras}) {
    return QuestionAnswersCompanion(
      answerUuid: answerUuid ?? this.answerUuid,
      questionUuid: questionUuid ?? this.questionUuid,
      extras: extras ?? this.extras,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (answerUuid.present) {
      map['answer_uuid'] = Variable<String>(answerUuid.value);
    }
    if (questionUuid.present) {
      map['question_uuid'] = Variable<String>(questionUuid.value);
    }
    if (extras.present) {
      final converter = $QuestionAnswersTable.$converter0;
      map['extras'] = Variable<String>(converter.mapToSql(extras.value));
    }
    return map;
  }
}

class $QuestionAnswersTable extends QuestionAnswers
    with TableInfo<$QuestionAnswersTable, QuestionAnswer> {
  final GeneratedDatabase _db;
  final String _alias;
  $QuestionAnswersTable(this._db, [this._alias]);
  final VerificationMeta _answerUuidMeta = const VerificationMeta('answerUuid');
  GeneratedTextColumn _answerUuid;
  @override
  GeneratedTextColumn get answerUuid => _answerUuid ??= _constructAnswerUuid();
  GeneratedTextColumn _constructAnswerUuid() {
    return GeneratedTextColumn('answer_uuid', $tableName, false,
        $customConstraints: 'REFERENCES answers(uuid)');
  }

  final VerificationMeta _questionUuidMeta =
      const VerificationMeta('questionUuid');
  GeneratedTextColumn _questionUuid;
  @override
  GeneratedTextColumn get questionUuid =>
      _questionUuid ??= _constructQuestionUuid();
  GeneratedTextColumn _constructQuestionUuid() {
    return GeneratedTextColumn('question_uuid', $tableName, false,
        $customConstraints: 'REFERENCES questions(uuid)');
  }

  final VerificationMeta _extrasMeta = const VerificationMeta('extras');
  GeneratedTextColumn _extras;
  @override
  GeneratedTextColumn get extras => _extras ??= _constructExtras();
  GeneratedTextColumn _constructExtras() {
    return GeneratedTextColumn(
      'extras',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [answerUuid, questionUuid, extras];
  @override
  $QuestionAnswersTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'question_answers';
  @override
  final String actualTableName = 'question_answers';
  @override
  VerificationContext validateIntegrity(Insertable<QuestionAnswer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('answer_uuid')) {
      context.handle(
          _answerUuidMeta,
          answerUuid.isAcceptableOrUnknown(
              data['answer_uuid'], _answerUuidMeta));
    } else if (isInserting) {
      context.missing(_answerUuidMeta);
    }
    if (data.containsKey('question_uuid')) {
      context.handle(
          _questionUuidMeta,
          questionUuid.isAcceptableOrUnknown(
              data['question_uuid'], _questionUuidMeta));
    } else if (isInserting) {
      context.missing(_questionUuidMeta);
    }
    context.handle(_extrasMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  QuestionAnswer map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return QuestionAnswer.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $QuestionAnswersTable createAlias(String alias) {
    return $QuestionAnswersTable(_db, alias);
  }

  static TypeConverter<AnswerExtras, String> $converter0 =
      const AnswerExtrasConverter();
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $SurveysTable _surveys;
  $SurveysTable get surveys => _surveys ??= $SurveysTable(this);
  $QuestionsTable _questions;
  $QuestionsTable get questions => _questions ??= $QuestionsTable(this);
  $AnswersTable _answers;
  $AnswersTable get answers => _answers ??= $AnswersTable(this);
  $QuestionAnswersTable _questionAnswers;
  $QuestionAnswersTable get questionAnswers =>
      _questionAnswers ??= $QuestionAnswersTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [surveys, questions, answers, questionAnswers];
}
