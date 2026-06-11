// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LongGoalsTable extends LongGoals
    with TableInfo<$LongGoalsTable, LongGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LongGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, description, deadline, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'long_goals';
  @override
  VerificationContext validateIntegrity(Insertable<LongGoal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LongGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LongGoal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LongGoalsTable createAlias(String alias) {
    return $LongGoalsTable(attachedDatabase, alias);
  }
}

class LongGoal extends DataClass implements Insertable<LongGoal> {
  final String id;
  final String title;
  final String? description;
  final DateTime? deadline;
  final String status;
  final DateTime createdAt;
  const LongGoal(
      {required this.id,
      required this.title,
      this.description,
      this.deadline,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LongGoalsCompanion toCompanion(bool nullToAbsent) {
    return LongGoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory LongGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LongGoal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LongGoal copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      LongGoal(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        deadline: deadline.present ? deadline.value : this.deadline,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  LongGoal copyWithCompanion(LongGoalsCompanion data) {
    return LongGoal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LongGoal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, description, deadline, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LongGoal &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.deadline == this.deadline &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class LongGoalsCompanion extends UpdateCompanion<LongGoal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> deadline;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LongGoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LongGoalsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    this.deadline = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<LongGoal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? deadline,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (deadline != null) 'deadline': deadline,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LongGoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime?>? deadline,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LongGoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LongGoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShortGoalsTable extends ShortGoals
    with TableInfo<$ShortGoalsTable, ShortGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShortGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _longGoalIdMeta =
      const VerificationMeta('longGoalId');
  @override
  late final GeneratedColumn<String> longGoalId = GeneratedColumn<String>(
      'long_goal_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES long_goals (id)'));
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, longGoalId, deadline, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'short_goals';
  @override
  VerificationContext validateIntegrity(Insertable<ShortGoal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('long_goal_id')) {
      context.handle(
          _longGoalIdMeta,
          longGoalId.isAcceptableOrUnknown(
              data['long_goal_id']!, _longGoalIdMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShortGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShortGoal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      longGoalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}long_goal_id']),
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ShortGoalsTable createAlias(String alias) {
    return $ShortGoalsTable(attachedDatabase, alias);
  }
}

class ShortGoal extends DataClass implements Insertable<ShortGoal> {
  final String id;
  final String title;
  final String? longGoalId;
  final DateTime? deadline;
  final String status;
  final DateTime createdAt;
  const ShortGoal(
      {required this.id,
      required this.title,
      this.longGoalId,
      this.deadline,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || longGoalId != null) {
      map['long_goal_id'] = Variable<String>(longGoalId);
    }
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ShortGoalsCompanion toCompanion(bool nullToAbsent) {
    return ShortGoalsCompanion(
      id: Value(id),
      title: Value(title),
      longGoalId: longGoalId == null && nullToAbsent
          ? const Value.absent()
          : Value(longGoalId),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory ShortGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShortGoal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      longGoalId: serializer.fromJson<String?>(json['longGoalId']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'longGoalId': serializer.toJson<String?>(longGoalId),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ShortGoal copyWith(
          {String? id,
          String? title,
          Value<String?> longGoalId = const Value.absent(),
          Value<DateTime?> deadline = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      ShortGoal(
        id: id ?? this.id,
        title: title ?? this.title,
        longGoalId: longGoalId.present ? longGoalId.value : this.longGoalId,
        deadline: deadline.present ? deadline.value : this.deadline,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  ShortGoal copyWithCompanion(ShortGoalsCompanion data) {
    return ShortGoal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      longGoalId:
          data.longGoalId.present ? data.longGoalId.value : this.longGoalId,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShortGoal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('longGoalId: $longGoalId, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, longGoalId, deadline, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShortGoal &&
          other.id == this.id &&
          other.title == this.title &&
          other.longGoalId == this.longGoalId &&
          other.deadline == this.deadline &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class ShortGoalsCompanion extends UpdateCompanion<ShortGoal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> longGoalId;
  final Value<DateTime?> deadline;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const ShortGoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.longGoalId = const Value.absent(),
    this.deadline = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShortGoalsCompanion.insert({
    required String id,
    required String title,
    this.longGoalId = const Value.absent(),
    this.deadline = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<ShortGoal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? longGoalId,
    Expression<DateTime>? deadline,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (longGoalId != null) 'long_goal_id': longGoalId,
      if (deadline != null) 'deadline': deadline,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShortGoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? longGoalId,
      Value<DateTime?>? deadline,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return ShortGoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      longGoalId: longGoalId ?? this.longGoalId,
      deadline: deadline ?? this.deadline,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (longGoalId.present) {
      map['long_goal_id'] = Variable<String>(longGoalId.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShortGoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('longGoalId: $longGoalId, ')
          ..write('deadline: $deadline, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _shortGoalIdMeta =
      const VerificationMeta('shortGoalId');
  @override
  late final GeneratedColumn<String> shortGoalId = GeneratedColumn<String>(
      'short_goal_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES short_goals (id)'));
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('pending'));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<String> priority = GeneratedColumn<String>(
      'priority', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('medium'));
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _completedAtMeta =
      const VerificationMeta('completedAt');
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
      'completed_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        description,
        dueDate,
        shortGoalId,
        category,
        notes,
        status,
        priority,
        habitId,
        createdAt,
        completedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<Task> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('short_goal_id')) {
      context.handle(
          _shortGoalIdMeta,
          shortGoalId.isAcceptableOrUnknown(
              data['short_goal_id']!, _shortGoalIdMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('completed_at')) {
      context.handle(
          _completedAtMeta,
          completedAt.isAcceptableOrUnknown(
              data['completed_at']!, _completedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date'])!,
      shortGoalId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_goal_id']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}priority'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      completedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}completed_at']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String title;
  final String? description;
  final DateTime dueDate;
  final String? shortGoalId;
  final String? category;
  final String? notes;
  final String status;
  final String priority;
  final String? habitId;
  final DateTime createdAt;
  final DateTime? completedAt;
  const Task(
      {required this.id,
      required this.title,
      this.description,
      required this.dueDate,
      this.shortGoalId,
      this.category,
      this.notes,
      required this.status,
      required this.priority,
      this.habitId,
      required this.createdAt,
      this.completedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || shortGoalId != null) {
      map['short_goal_id'] = Variable<String>(shortGoalId);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(category);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['priority'] = Variable<String>(priority);
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<String>(habitId);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      dueDate: Value(dueDate),
      shortGoalId: shortGoalId == null && nullToAbsent
          ? const Value.absent()
          : Value(shortGoalId),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      priority: Value(priority),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
      createdAt: Value(createdAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Task.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      shortGoalId: serializer.fromJson<String?>(json['shortGoalId']),
      category: serializer.fromJson<String?>(json['category']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      priority: serializer.fromJson<String>(json['priority']),
      habitId: serializer.fromJson<String?>(json['habitId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'shortGoalId': serializer.toJson<String?>(shortGoalId),
      'category': serializer.toJson<String?>(category),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'priority': serializer.toJson<String>(priority),
      'habitId': serializer.toJson<String?>(habitId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Task copyWith(
          {String? id,
          String? title,
          Value<String?> description = const Value.absent(),
          DateTime? dueDate,
          Value<String?> shortGoalId = const Value.absent(),
          Value<String?> category = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status,
          String? priority,
          Value<String?> habitId = const Value.absent(),
          DateTime? createdAt,
          Value<DateTime?> completedAt = const Value.absent()}) =>
      Task(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        dueDate: dueDate ?? this.dueDate,
        shortGoalId: shortGoalId.present ? shortGoalId.value : this.shortGoalId,
        category: category.present ? category.value : this.category,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        priority: priority ?? this.priority,
        habitId: habitId.present ? habitId.value : this.habitId,
        createdAt: createdAt ?? this.createdAt,
        completedAt: completedAt.present ? completedAt.value : this.completedAt,
      );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      shortGoalId:
          data.shortGoalId.present ? data.shortGoalId.value : this.shortGoalId,
      category: data.category.present ? data.category.value : this.category,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      priority: data.priority.present ? data.priority.value : this.priority,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      completedAt:
          data.completedAt.present ? data.completedAt.value : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('shortGoalId: $shortGoalId, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('habitId: $habitId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, description, dueDate, shortGoalId,
      category, notes, status, priority, habitId, createdAt, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.dueDate == this.dueDate &&
          other.shortGoalId == this.shortGoalId &&
          other.category == this.category &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.priority == this.priority &&
          other.habitId == this.habitId &&
          other.createdAt == this.createdAt &&
          other.completedAt == this.completedAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> dueDate;
  final Value<String?> shortGoalId;
  final Value<String?> category;
  final Value<String?> notes;
  final Value<String> status;
  final Value<String> priority;
  final Value<String?> habitId;
  final Value<DateTime> createdAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.shortGoalId = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.habitId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required DateTime dueDate,
    this.shortGoalId = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.priority = const Value.absent(),
    this.habitId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        dueDate = Value(dueDate);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? dueDate,
    Expression<String>? shortGoalId,
    Expression<String>? category,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<String>? priority,
    Expression<String>? habitId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (dueDate != null) 'due_date': dueDate,
      if (shortGoalId != null) 'short_goal_id': shortGoalId,
      if (category != null) 'category': category,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (priority != null) 'priority': priority,
      if (habitId != null) 'habit_id': habitId,
      if (createdAt != null) 'created_at': createdAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime>? dueDate,
      Value<String?>? shortGoalId,
      Value<String?>? category,
      Value<String?>? notes,
      Value<String>? status,
      Value<String>? priority,
      Value<String?>? habitId,
      Value<DateTime>? createdAt,
      Value<DateTime?>? completedAt,
      Value<int>? rowid}) {
    return TasksCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      shortGoalId: shortGoalId ?? this.shortGoalId,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      habitId: habitId ?? this.habitId,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (shortGoalId.present) {
      map['short_goal_id'] = Variable<String>(shortGoalId.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (priority.present) {
      map['priority'] = Variable<String>(priority.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('dueDate: $dueDate, ')
          ..write('shortGoalId: $shortGoalId, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('priority: $priority, ')
          ..write('habitId: $habitId, ')
          ..write('createdAt: $createdAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TransactionsTable extends Transactions
    with TableInfo<$TransactionsTable, Transaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, amount, type, category, notes, date, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'transactions';
  @override
  VerificationContext validateIntegrity(Insertable<Transaction> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Transaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Transaction(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TransactionsTable createAlias(String alias) {
    return $TransactionsTable(attachedDatabase, alias);
  }
}

class Transaction extends DataClass implements Insertable<Transaction> {
  final String id;
  final String title;
  final double amount;
  final String type;
  final String category;
  final String? notes;
  final DateTime date;
  final DateTime createdAt;
  const Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.type,
      required this.category,
      this.notes,
      required this.date,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['amount'] = Variable<double>(amount);
    map['type'] = Variable<String>(type);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['date'] = Variable<DateTime>(date);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TransactionsCompanion toCompanion(bool nullToAbsent) {
    return TransactionsCompanion(
      id: Value(id),
      title: Value(title),
      amount: Value(amount),
      type: Value(type),
      category: Value(category),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      date: Value(date),
      createdAt: Value(createdAt),
    );
  }

  factory Transaction.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Transaction(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      type: serializer.fromJson<String>(json['type']),
      category: serializer.fromJson<String>(json['category']),
      notes: serializer.fromJson<String?>(json['notes']),
      date: serializer.fromJson<DateTime>(json['date']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'amount': serializer.toJson<double>(amount),
      'type': serializer.toJson<String>(type),
      'category': serializer.toJson<String>(category),
      'notes': serializer.toJson<String?>(notes),
      'date': serializer.toJson<DateTime>(date),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Transaction copyWith(
          {String? id,
          String? title,
          double? amount,
          String? type,
          String? category,
          Value<String?> notes = const Value.absent(),
          DateTime? date,
          DateTime? createdAt}) =>
      Transaction(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        type: type ?? this.type,
        category: category ?? this.category,
        notes: notes.present ? notes.value : this.notes,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
      );
  Transaction copyWithCompanion(TransactionsCompanion data) {
    return Transaction(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      type: data.type.present ? data.type.value : this.type,
      category: data.category.present ? data.category.value : this.category,
      notes: data.notes.present ? data.notes.value : this.notes,
      date: data.date.present ? data.date.value : this.date,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Transaction(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, amount, type, category, notes, date, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Transaction &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.type == this.type &&
          other.category == this.category &&
          other.notes == this.notes &&
          other.date == this.date &&
          other.createdAt == this.createdAt);
}

class TransactionsCompanion extends UpdateCompanion<Transaction> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> amount;
  final Value<String> type;
  final Value<String> category;
  final Value<String?> notes;
  final Value<DateTime> date;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TransactionsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.type = const Value.absent(),
    this.category = const Value.absent(),
    this.notes = const Value.absent(),
    this.date = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TransactionsCompanion.insert({
    required String id,
    required String title,
    required double amount,
    required String type,
    required String category,
    this.notes = const Value.absent(),
    required DateTime date,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        amount = Value(amount),
        type = Value(type),
        category = Value(category),
        date = Value(date);
  static Insertable<Transaction> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? type,
    Expression<String>? category,
    Expression<String>? notes,
    Expression<DateTime>? date,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (type != null) 'type': type,
      if (category != null) 'category': category,
      if (notes != null) 'notes': notes,
      if (date != null) 'date': date,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TransactionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<double>? amount,
      Value<String>? type,
      Value<String>? category,
      Value<String?>? notes,
      Value<DateTime>? date,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return TransactionsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      category: category ?? this.category,
      notes: notes ?? this.notes,
      date: date ?? this.date,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TransactionsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('type: $type, ')
          ..write('category: $category, ')
          ..write('notes: $notes, ')
          ..write('date: $date, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DebtsTable extends Debts with TableInfo<$DebtsTable, Debt> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DebtsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _personMeta = const VerificationMeta('person');
  @override
  late final GeneratedColumn<String> person = GeneratedColumn<String>(
      'person', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dueDateMeta =
      const VerificationMeta('dueDate');
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
      'due_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, amount, person, direction, dueDate, notes, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'debts';
  @override
  VerificationContext validateIntegrity(Insertable<Debt> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('person')) {
      context.handle(_personMeta,
          person.isAcceptableOrUnknown(data['person']!, _personMeta));
    } else if (isInserting) {
      context.missing(_personMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(_dueDateMeta,
          dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Debt map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Debt(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      person: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}person'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction'])!,
      dueDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}due_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $DebtsTable createAlias(String alias) {
    return $DebtsTable(attachedDatabase, alias);
  }
}

class Debt extends DataClass implements Insertable<Debt> {
  final String id;
  final String? title;
  final double amount;
  final String person;
  final String direction;
  final DateTime? dueDate;
  final String? notes;
  final String status;
  final DateTime createdAt;
  const Debt(
      {required this.id,
      this.title,
      required this.amount,
      required this.person,
      required this.direction,
      this.dueDate,
      this.notes,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    map['amount'] = Variable<double>(amount);
    map['person'] = Variable<String>(person);
    map['direction'] = Variable<String>(direction);
    if (!nullToAbsent || dueDate != null) {
      map['due_date'] = Variable<DateTime>(dueDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  DebtsCompanion toCompanion(bool nullToAbsent) {
    return DebtsCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      amount: Value(amount),
      person: Value(person),
      direction: Value(direction),
      dueDate: dueDate == null && nullToAbsent
          ? const Value.absent()
          : Value(dueDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Debt.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Debt(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      amount: serializer.fromJson<double>(json['amount']),
      person: serializer.fromJson<String>(json['person']),
      direction: serializer.fromJson<String>(json['direction']),
      dueDate: serializer.fromJson<DateTime?>(json['dueDate']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String?>(title),
      'amount': serializer.toJson<double>(amount),
      'person': serializer.toJson<String>(person),
      'direction': serializer.toJson<String>(direction),
      'dueDate': serializer.toJson<DateTime?>(dueDate),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Debt copyWith(
          {String? id,
          Value<String?> title = const Value.absent(),
          double? amount,
          String? person,
          String? direction,
          Value<DateTime?> dueDate = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      Debt(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        amount: amount ?? this.amount,
        person: person ?? this.person,
        direction: direction ?? this.direction,
        dueDate: dueDate.present ? dueDate.value : this.dueDate,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Debt copyWithCompanion(DebtsCompanion data) {
    return Debt(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      amount: data.amount.present ? data.amount.value : this.amount,
      person: data.person.present ? data.person.value : this.person,
      direction: data.direction.present ? data.direction.value : this.direction,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Debt(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('person: $person, ')
          ..write('direction: $direction, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, amount, person, direction, dueDate, notes, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Debt &&
          other.id == this.id &&
          other.title == this.title &&
          other.amount == this.amount &&
          other.person == this.person &&
          other.direction == this.direction &&
          other.dueDate == this.dueDate &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class DebtsCompanion extends UpdateCompanion<Debt> {
  final Value<String> id;
  final Value<String?> title;
  final Value<double> amount;
  final Value<String> person;
  final Value<String> direction;
  final Value<DateTime?> dueDate;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const DebtsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.amount = const Value.absent(),
    this.person = const Value.absent(),
    this.direction = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DebtsCompanion.insert({
    required String id,
    this.title = const Value.absent(),
    required double amount,
    required String person,
    required String direction,
    this.dueDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        amount = Value(amount),
        person = Value(person),
        direction = Value(direction);
  static Insertable<Debt> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? amount,
    Expression<String>? person,
    Expression<String>? direction,
    Expression<DateTime>? dueDate,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (amount != null) 'amount': amount,
      if (person != null) 'person': person,
      if (direction != null) 'direction': direction,
      if (dueDate != null) 'due_date': dueDate,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DebtsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? title,
      Value<double>? amount,
      Value<String>? person,
      Value<String>? direction,
      Value<DateTime?>? dueDate,
      Value<String?>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return DebtsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      person: person ?? this.person,
      direction: direction ?? this.direction,
      dueDate: dueDate ?? this.dueDate,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (person.present) {
      map['person'] = Variable<String>(person.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DebtsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('amount: $amount, ')
          ..write('person: $person, ')
          ..write('direction: $direction, ')
          ..write('dueDate: $dueDate, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinancialGoalsTable extends FinancialGoals
    with TableInfo<$FinancialGoalsTable, FinancialGoal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinancialGoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _targetAmountMeta =
      const VerificationMeta('targetAmount');
  @override
  late final GeneratedColumn<double> targetAmount = GeneratedColumn<double>(
      'target_amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _currentAmountMeta =
      const VerificationMeta('currentAmount');
  @override
  late final GeneratedColumn<double> currentAmount = GeneratedColumn<double>(
      'current_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant<double>(0));
  static const VerificationMeta _deadlineMeta =
      const VerificationMeta('deadline');
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
      'deadline', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        title,
        targetAmount,
        currentAmount,
        deadline,
        notes,
        status,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'financial_goals';
  @override
  VerificationContext validateIntegrity(Insertable<FinancialGoal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_amount')) {
      context.handle(
          _targetAmountMeta,
          targetAmount.isAcceptableOrUnknown(
              data['target_amount']!, _targetAmountMeta));
    } else if (isInserting) {
      context.missing(_targetAmountMeta);
    }
    if (data.containsKey('current_amount')) {
      context.handle(
          _currentAmountMeta,
          currentAmount.isAcceptableOrUnknown(
              data['current_amount']!, _currentAmountMeta));
    }
    if (data.containsKey('deadline')) {
      context.handle(_deadlineMeta,
          deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinancialGoal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinancialGoal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      targetAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_amount'])!,
      currentAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_amount'])!,
      deadline: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deadline']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $FinancialGoalsTable createAlias(String alias) {
    return $FinancialGoalsTable(attachedDatabase, alias);
  }
}

class FinancialGoal extends DataClass implements Insertable<FinancialGoal> {
  final String id;
  final String title;
  final double targetAmount;
  final double currentAmount;
  final DateTime? deadline;
  final String? notes;
  final String status;
  final DateTime createdAt;
  const FinancialGoal(
      {required this.id,
      required this.title,
      required this.targetAmount,
      required this.currentAmount,
      this.deadline,
      this.notes,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['target_amount'] = Variable<double>(targetAmount);
    map['current_amount'] = Variable<double>(currentAmount);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FinancialGoalsCompanion toCompanion(bool nullToAbsent) {
    return FinancialGoalsCompanion(
      id: Value(id),
      title: Value(title),
      targetAmount: Value(targetAmount),
      currentAmount: Value(currentAmount),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory FinancialGoal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinancialGoal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      targetAmount: serializer.fromJson<double>(json['targetAmount']),
      currentAmount: serializer.fromJson<double>(json['currentAmount']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      notes: serializer.fromJson<String?>(json['notes']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'targetAmount': serializer.toJson<double>(targetAmount),
      'currentAmount': serializer.toJson<double>(currentAmount),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'notes': serializer.toJson<String?>(notes),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FinancialGoal copyWith(
          {String? id,
          String? title,
          double? targetAmount,
          double? currentAmount,
          Value<DateTime?> deadline = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      FinancialGoal(
        id: id ?? this.id,
        title: title ?? this.title,
        targetAmount: targetAmount ?? this.targetAmount,
        currentAmount: currentAmount ?? this.currentAmount,
        deadline: deadline.present ? deadline.value : this.deadline,
        notes: notes.present ? notes.value : this.notes,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  FinancialGoal copyWithCompanion(FinancialGoalsCompanion data) {
    return FinancialGoal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      targetAmount: data.targetAmount.present
          ? data.targetAmount.value
          : this.targetAmount,
      currentAmount: data.currentAmount.present
          ? data.currentAmount.value
          : this.currentAmount,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      notes: data.notes.present ? data.notes.value : this.notes,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinancialGoal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('deadline: $deadline, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, targetAmount, currentAmount,
      deadline, notes, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinancialGoal &&
          other.id == this.id &&
          other.title == this.title &&
          other.targetAmount == this.targetAmount &&
          other.currentAmount == this.currentAmount &&
          other.deadline == this.deadline &&
          other.notes == this.notes &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class FinancialGoalsCompanion extends UpdateCompanion<FinancialGoal> {
  final Value<String> id;
  final Value<String> title;
  final Value<double> targetAmount;
  final Value<double> currentAmount;
  final Value<DateTime?> deadline;
  final Value<String?> notes;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const FinancialGoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.targetAmount = const Value.absent(),
    this.currentAmount = const Value.absent(),
    this.deadline = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinancialGoalsCompanion.insert({
    required String id,
    required String title,
    required double targetAmount,
    this.currentAmount = const Value.absent(),
    this.deadline = const Value.absent(),
    this.notes = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        targetAmount = Value(targetAmount);
  static Insertable<FinancialGoal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<double>? targetAmount,
    Expression<double>? currentAmount,
    Expression<DateTime>? deadline,
    Expression<String>? notes,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (targetAmount != null) 'target_amount': targetAmount,
      if (currentAmount != null) 'current_amount': currentAmount,
      if (deadline != null) 'deadline': deadline,
      if (notes != null) 'notes': notes,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinancialGoalsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<double>? targetAmount,
      Value<double>? currentAmount,
      Value<DateTime?>? deadline,
      Value<String?>? notes,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return FinancialGoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      targetAmount: targetAmount ?? this.targetAmount,
      currentAmount: currentAmount ?? this.currentAmount,
      deadline: deadline ?? this.deadline,
      notes: notes ?? this.notes,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetAmount.present) {
      map['target_amount'] = Variable<double>(targetAmount.value);
    }
    if (currentAmount.present) {
      map['current_amount'] = Variable<double>(currentAmount.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinancialGoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('targetAmount: $targetAmount, ')
          ..write('currentAmount: $currentAmount, ')
          ..write('deadline: $deadline, ')
          ..write('notes: $notes, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('✅'));
  static const VerificationMeta _timeOfDayMeta =
      const VerificationMeta('timeOfDay');
  @override
  late final GeneratedColumn<String> timeOfDay = GeneratedColumn<String>(
      'time_of_day', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('any'));
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, emoji, timeOfDay, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(Insertable<Habit> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    if (data.containsKey('time_of_day')) {
      context.handle(
          _timeOfDayMeta,
          timeOfDay.isAcceptableOrUnknown(
              data['time_of_day']!, _timeOfDayMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
      timeOfDay: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}time_of_day'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String title;
  final String emoji;
  final String timeOfDay;
  final String status;
  final DateTime createdAt;
  const Habit(
      {required this.id,
      required this.title,
      required this.emoji,
      required this.timeOfDay,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['emoji'] = Variable<String>(emoji);
    map['time_of_day'] = Variable<String>(timeOfDay);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      emoji: Value(emoji),
      timeOfDay: Value(timeOfDay),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      emoji: serializer.fromJson<String>(json['emoji']),
      timeOfDay: serializer.fromJson<String>(json['timeOfDay']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'emoji': serializer.toJson<String>(emoji),
      'timeOfDay': serializer.toJson<String>(timeOfDay),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith(
          {String? id,
          String? title,
          String? emoji,
          String? timeOfDay,
          String? status,
          DateTime? createdAt}) =>
      Habit(
        id: id ?? this.id,
        title: title ?? this.title,
        emoji: emoji ?? this.emoji,
        timeOfDay: timeOfDay ?? this.timeOfDay,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      timeOfDay: data.timeOfDay.present ? data.timeOfDay.value : this.timeOfDay,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('emoji: $emoji, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, emoji, timeOfDay, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.title == this.title &&
          other.emoji == this.emoji &&
          other.timeOfDay == this.timeOfDay &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> emoji;
  final Value<String> timeOfDay;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.emoji = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    this.emoji = const Value.absent(),
    this.timeOfDay = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? emoji,
    Expression<String>? timeOfDay,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (emoji != null) 'emoji': emoji,
      if (timeOfDay != null) 'time_of_day': timeOfDay,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? emoji,
      Value<String>? timeOfDay,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      emoji: emoji ?? this.emoji,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (timeOfDay.present) {
      map['time_of_day'] = Variable<String>(timeOfDay.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('emoji: $emoji, ')
          ..write('timeOfDay: $timeOfDay, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _habitIdMeta =
      const VerificationMeta('habitId');
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
      'habit_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES habits (id)'));
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('done'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, habitId, date, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(Insertable<HabitLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(_habitIdMeta,
          habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta));
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      habitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}habit_id'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final String id;
  final String habitId;
  final DateTime date;
  final String status;
  final DateTime createdAt;
  const HabitLog(
      {required this.id,
      required this.habitId,
      required this.date,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['date'] = Variable<DateTime>(date);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      date: Value(date),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory HabitLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      date: serializer.fromJson<DateTime>(json['date']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'date': serializer.toJson<DateTime>(date),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitLog copyWith(
          {String? id,
          String? habitId,
          DateTime? date,
          String? status,
          DateTime? createdAt}) =>
      HabitLog(
        id: id ?? this.id,
        habitId: habitId ?? this.habitId,
        date: date ?? this.date,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      date: data.date.present ? data.date.value : this.date,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, date, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.date == this.date &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<DateTime> date;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.date = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String id,
    required String habitId,
    required DateTime date,
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        habitId = Value(habitId),
        date = Value(date);
  static Insertable<HabitLog> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<DateTime>? date,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (date != null) 'date': date,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? habitId,
      Value<DateTime>? date,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      date: date ?? this.date,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('date: $date, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TimeLogsTable extends TimeLogs with TableInfo<$TimeLogsTable, TimeLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TimeLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _taskIdMeta = const VerificationMeta('taskId');
  @override
  late final GeneratedColumn<String> taskId = GeneratedColumn<String>(
      'task_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _durationSecondsMeta =
      const VerificationMeta('durationSeconds');
  @override
  late final GeneratedColumn<int> durationSeconds = GeneratedColumn<int>(
      'duration_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startedAtMeta =
      const VerificationMeta('startedAt');
  @override
  late final GeneratedColumn<DateTime> startedAt = GeneratedColumn<DateTime>(
      'started_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endedAtMeta =
      const VerificationMeta('endedAt');
  @override
  late final GeneratedColumn<DateTime> endedAt = GeneratedColumn<DateTime>(
      'ended_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        category,
        taskId,
        durationSeconds,
        notes,
        startedAt,
        endedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'time_logs';
  @override
  VerificationContext validateIntegrity(Insertable<TimeLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('task_id')) {
      context.handle(_taskIdMeta,
          taskId.isAcceptableOrUnknown(data['task_id']!, _taskIdMeta));
    }
    if (data.containsKey('duration_seconds')) {
      context.handle(
          _durationSecondsMeta,
          durationSeconds.isAcceptableOrUnknown(
              data['duration_seconds']!, _durationSecondsMeta));
    } else if (isInserting) {
      context.missing(_durationSecondsMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('started_at')) {
      context.handle(_startedAtMeta,
          startedAt.isAcceptableOrUnknown(data['started_at']!, _startedAtMeta));
    } else if (isInserting) {
      context.missing(_startedAtMeta);
    }
    if (data.containsKey('ended_at')) {
      context.handle(_endedAtMeta,
          endedAt.isAcceptableOrUnknown(data['ended_at']!, _endedAtMeta));
    } else if (isInserting) {
      context.missing(_endedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TimeLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TimeLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      taskId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}task_id']),
      durationSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_seconds'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      startedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}started_at'])!,
      endedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}ended_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $TimeLogsTable createAlias(String alias) {
    return $TimeLogsTable(attachedDatabase, alias);
  }
}

class TimeLog extends DataClass implements Insertable<TimeLog> {
  final String id;
  final String category;
  final String? taskId;
  final int durationSeconds;
  final String? notes;
  final DateTime startedAt;
  final DateTime endedAt;
  final DateTime createdAt;
  const TimeLog(
      {required this.id,
      required this.category,
      this.taskId,
      required this.durationSeconds,
      this.notes,
      required this.startedAt,
      required this.endedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || taskId != null) {
      map['task_id'] = Variable<String>(taskId);
    }
    map['duration_seconds'] = Variable<int>(durationSeconds);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['started_at'] = Variable<DateTime>(startedAt);
    map['ended_at'] = Variable<DateTime>(endedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TimeLogsCompanion toCompanion(bool nullToAbsent) {
    return TimeLogsCompanion(
      id: Value(id),
      category: Value(category),
      taskId:
          taskId == null && nullToAbsent ? const Value.absent() : Value(taskId),
      durationSeconds: Value(durationSeconds),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      startedAt: Value(startedAt),
      endedAt: Value(endedAt),
      createdAt: Value(createdAt),
    );
  }

  factory TimeLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TimeLog(
      id: serializer.fromJson<String>(json['id']),
      category: serializer.fromJson<String>(json['category']),
      taskId: serializer.fromJson<String?>(json['taskId']),
      durationSeconds: serializer.fromJson<int>(json['durationSeconds']),
      notes: serializer.fromJson<String?>(json['notes']),
      startedAt: serializer.fromJson<DateTime>(json['startedAt']),
      endedAt: serializer.fromJson<DateTime>(json['endedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'category': serializer.toJson<String>(category),
      'taskId': serializer.toJson<String?>(taskId),
      'durationSeconds': serializer.toJson<int>(durationSeconds),
      'notes': serializer.toJson<String?>(notes),
      'startedAt': serializer.toJson<DateTime>(startedAt),
      'endedAt': serializer.toJson<DateTime>(endedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  TimeLog copyWith(
          {String? id,
          String? category,
          Value<String?> taskId = const Value.absent(),
          int? durationSeconds,
          Value<String?> notes = const Value.absent(),
          DateTime? startedAt,
          DateTime? endedAt,
          DateTime? createdAt}) =>
      TimeLog(
        id: id ?? this.id,
        category: category ?? this.category,
        taskId: taskId.present ? taskId.value : this.taskId,
        durationSeconds: durationSeconds ?? this.durationSeconds,
        notes: notes.present ? notes.value : this.notes,
        startedAt: startedAt ?? this.startedAt,
        endedAt: endedAt ?? this.endedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  TimeLog copyWithCompanion(TimeLogsCompanion data) {
    return TimeLog(
      id: data.id.present ? data.id.value : this.id,
      category: data.category.present ? data.category.value : this.category,
      taskId: data.taskId.present ? data.taskId.value : this.taskId,
      durationSeconds: data.durationSeconds.present
          ? data.durationSeconds.value
          : this.durationSeconds,
      notes: data.notes.present ? data.notes.value : this.notes,
      startedAt: data.startedAt.present ? data.startedAt.value : this.startedAt,
      endedAt: data.endedAt.present ? data.endedAt.value : this.endedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TimeLog(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('taskId: $taskId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category, taskId, durationSeconds, notes,
      startedAt, endedAt, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TimeLog &&
          other.id == this.id &&
          other.category == this.category &&
          other.taskId == this.taskId &&
          other.durationSeconds == this.durationSeconds &&
          other.notes == this.notes &&
          other.startedAt == this.startedAt &&
          other.endedAt == this.endedAt &&
          other.createdAt == this.createdAt);
}

class TimeLogsCompanion extends UpdateCompanion<TimeLog> {
  final Value<String> id;
  final Value<String> category;
  final Value<String?> taskId;
  final Value<int> durationSeconds;
  final Value<String?> notes;
  final Value<DateTime> startedAt;
  final Value<DateTime> endedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TimeLogsCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
    this.taskId = const Value.absent(),
    this.durationSeconds = const Value.absent(),
    this.notes = const Value.absent(),
    this.startedAt = const Value.absent(),
    this.endedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TimeLogsCompanion.insert({
    required String id,
    required String category,
    this.taskId = const Value.absent(),
    required int durationSeconds,
    this.notes = const Value.absent(),
    required DateTime startedAt,
    required DateTime endedAt,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        category = Value(category),
        durationSeconds = Value(durationSeconds),
        startedAt = Value(startedAt),
        endedAt = Value(endedAt);
  static Insertable<TimeLog> custom({
    Expression<String>? id,
    Expression<String>? category,
    Expression<String>? taskId,
    Expression<int>? durationSeconds,
    Expression<String>? notes,
    Expression<DateTime>? startedAt,
    Expression<DateTime>? endedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
      if (taskId != null) 'task_id': taskId,
      if (durationSeconds != null) 'duration_seconds': durationSeconds,
      if (notes != null) 'notes': notes,
      if (startedAt != null) 'started_at': startedAt,
      if (endedAt != null) 'ended_at': endedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TimeLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? category,
      Value<String?>? taskId,
      Value<int>? durationSeconds,
      Value<String?>? notes,
      Value<DateTime>? startedAt,
      Value<DateTime>? endedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return TimeLogsCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
      taskId: taskId ?? this.taskId,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      notes: notes ?? this.notes,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (taskId.present) {
      map['task_id'] = Variable<String>(taskId.value);
    }
    if (durationSeconds.present) {
      map['duration_seconds'] = Variable<int>(durationSeconds.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (startedAt.present) {
      map['started_at'] = Variable<DateTime>(startedAt.value);
    }
    if (endedAt.present) {
      map['ended_at'] = Variable<DateTime>(endedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TimeLogsCompanion(')
          ..write('id: $id, ')
          ..write('category: $category, ')
          ..write('taskId: $taskId, ')
          ..write('durationSeconds: $durationSeconds, ')
          ..write('notes: $notes, ')
          ..write('startedAt: $startedAt, ')
          ..write('endedAt: $endedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KpisTable extends Kpis with TableInfo<$KpisTable, Kpi> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KpisTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _emojiMeta = const VerificationMeta('emoji');
  @override
  late final GeneratedColumn<String> emoji = GeneratedColumn<String>(
      'emoji', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('📊'));
  static const VerificationMeta _directionMeta =
      const VerificationMeta('direction');
  @override
  late final GeneratedColumn<String> direction = GeneratedColumn<String>(
      'direction', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('higher_better'));
  static const VerificationMeta _targetValueMeta =
      const VerificationMeta('targetValue');
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
      'target_value', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('active'));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, unit, emoji, direction, targetValue, status, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kpis';
  @override
  VerificationContext validateIntegrity(Insertable<Kpi> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('emoji')) {
      context.handle(
          _emojiMeta, emoji.isAcceptableOrUnknown(data['emoji']!, _emojiMeta));
    }
    if (data.containsKey('direction')) {
      context.handle(_directionMeta,
          direction.isAcceptableOrUnknown(data['direction']!, _directionMeta));
    }
    if (data.containsKey('target_value')) {
      context.handle(
          _targetValueMeta,
          targetValue.isAcceptableOrUnknown(
              data['target_value']!, _targetValueMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Kpi map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Kpi(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
      emoji: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}emoji'])!,
      direction: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}direction'])!,
      targetValue: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_value']),
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KpisTable createAlias(String alias) {
    return $KpisTable(attachedDatabase, alias);
  }
}

class Kpi extends DataClass implements Insertable<Kpi> {
  final String id;
  final String title;
  final String unit;
  final String emoji;
  final String direction;
  final double? targetValue;
  final String status;
  final DateTime createdAt;
  const Kpi(
      {required this.id,
      required this.title,
      required this.unit,
      required this.emoji,
      required this.direction,
      this.targetValue,
      required this.status,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['unit'] = Variable<String>(unit);
    map['emoji'] = Variable<String>(emoji);
    map['direction'] = Variable<String>(direction);
    if (!nullToAbsent || targetValue != null) {
      map['target_value'] = Variable<double>(targetValue);
    }
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KpisCompanion toCompanion(bool nullToAbsent) {
    return KpisCompanion(
      id: Value(id),
      title: Value(title),
      unit: Value(unit),
      emoji: Value(emoji),
      direction: Value(direction),
      targetValue: targetValue == null && nullToAbsent
          ? const Value.absent()
          : Value(targetValue),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory Kpi.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Kpi(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      unit: serializer.fromJson<String>(json['unit']),
      emoji: serializer.fromJson<String>(json['emoji']),
      direction: serializer.fromJson<String>(json['direction']),
      targetValue: serializer.fromJson<double?>(json['targetValue']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'unit': serializer.toJson<String>(unit),
      'emoji': serializer.toJson<String>(emoji),
      'direction': serializer.toJson<String>(direction),
      'targetValue': serializer.toJson<double?>(targetValue),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Kpi copyWith(
          {String? id,
          String? title,
          String? unit,
          String? emoji,
          String? direction,
          Value<double?> targetValue = const Value.absent(),
          String? status,
          DateTime? createdAt}) =>
      Kpi(
        id: id ?? this.id,
        title: title ?? this.title,
        unit: unit ?? this.unit,
        emoji: emoji ?? this.emoji,
        direction: direction ?? this.direction,
        targetValue: targetValue.present ? targetValue.value : this.targetValue,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Kpi copyWithCompanion(KpisCompanion data) {
    return Kpi(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      unit: data.unit.present ? data.unit.value : this.unit,
      emoji: data.emoji.present ? data.emoji.value : this.emoji,
      direction: data.direction.present ? data.direction.value : this.direction,
      targetValue:
          data.targetValue.present ? data.targetValue.value : this.targetValue,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Kpi(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('unit: $unit, ')
          ..write('emoji: $emoji, ')
          ..write('direction: $direction, ')
          ..write('targetValue: $targetValue, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, unit, emoji, direction, targetValue, status, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Kpi &&
          other.id == this.id &&
          other.title == this.title &&
          other.unit == this.unit &&
          other.emoji == this.emoji &&
          other.direction == this.direction &&
          other.targetValue == this.targetValue &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class KpisCompanion extends UpdateCompanion<Kpi> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> unit;
  final Value<String> emoji;
  final Value<String> direction;
  final Value<double?> targetValue;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const KpisCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.unit = const Value.absent(),
    this.emoji = const Value.absent(),
    this.direction = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KpisCompanion.insert({
    required String id,
    required String title,
    required String unit,
    this.emoji = const Value.absent(),
    this.direction = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        title = Value(title),
        unit = Value(unit);
  static Insertable<Kpi> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? unit,
    Expression<String>? emoji,
    Expression<String>? direction,
    Expression<double>? targetValue,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (unit != null) 'unit': unit,
      if (emoji != null) 'emoji': emoji,
      if (direction != null) 'direction': direction,
      if (targetValue != null) 'target_value': targetValue,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KpisCompanion copyWith(
      {Value<String>? id,
      Value<String>? title,
      Value<String>? unit,
      Value<String>? emoji,
      Value<String>? direction,
      Value<double?>? targetValue,
      Value<String>? status,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return KpisCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      unit: unit ?? this.unit,
      emoji: emoji ?? this.emoji,
      direction: direction ?? this.direction,
      targetValue: targetValue ?? this.targetValue,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (emoji.present) {
      map['emoji'] = Variable<String>(emoji.value);
    }
    if (direction.present) {
      map['direction'] = Variable<String>(direction.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KpisCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('unit: $unit, ')
          ..write('emoji: $emoji, ')
          ..write('direction: $direction, ')
          ..write('targetValue: $targetValue, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $KpiLogsTable extends KpiLogs with TableInfo<$KpiLogsTable, KpiLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $KpiLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _kpiIdMeta = const VerificationMeta('kpiId');
  @override
  late final GeneratedColumn<String> kpiId = GeneratedColumn<String>(
      'kpi_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES kpis (id)'));
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
      'value', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, kpiId, value, date, notes, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kpi_logs';
  @override
  VerificationContext validateIntegrity(Insertable<KpiLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('kpi_id')) {
      context.handle(
          _kpiIdMeta, kpiId.isAcceptableOrUnknown(data['kpi_id']!, _kpiIdMeta));
    } else if (isInserting) {
      context.missing(_kpiIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
          _valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  KpiLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KpiLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      kpiId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}kpi_id'])!,
      value: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}value'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $KpiLogsTable createAlias(String alias) {
    return $KpiLogsTable(attachedDatabase, alias);
  }
}

class KpiLog extends DataClass implements Insertable<KpiLog> {
  final String id;
  final String kpiId;
  final double value;
  final DateTime date;
  final String? notes;
  final DateTime createdAt;
  const KpiLog(
      {required this.id,
      required this.kpiId,
      required this.value,
      required this.date,
      this.notes,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['kpi_id'] = Variable<String>(kpiId);
    map['value'] = Variable<double>(value);
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  KpiLogsCompanion toCompanion(bool nullToAbsent) {
    return KpiLogsCompanion(
      id: Value(id),
      kpiId: Value(kpiId),
      value: Value(value),
      date: Value(date),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory KpiLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KpiLog(
      id: serializer.fromJson<String>(json['id']),
      kpiId: serializer.fromJson<String>(json['kpiId']),
      value: serializer.fromJson<double>(json['value']),
      date: serializer.fromJson<DateTime>(json['date']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kpiId': serializer.toJson<String>(kpiId),
      'value': serializer.toJson<double>(value),
      'date': serializer.toJson<DateTime>(date),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  KpiLog copyWith(
          {String? id,
          String? kpiId,
          double? value,
          DateTime? date,
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt}) =>
      KpiLog(
        id: id ?? this.id,
        kpiId: kpiId ?? this.kpiId,
        value: value ?? this.value,
        date: date ?? this.date,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
      );
  KpiLog copyWithCompanion(KpiLogsCompanion data) {
    return KpiLog(
      id: data.id.present ? data.id.value : this.id,
      kpiId: data.kpiId.present ? data.kpiId.value : this.kpiId,
      value: data.value.present ? data.value.value : this.value,
      date: data.date.present ? data.date.value : this.date,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('KpiLog(')
          ..write('id: $id, ')
          ..write('kpiId: $kpiId, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, kpiId, value, date, notes, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KpiLog &&
          other.id == this.id &&
          other.kpiId == this.kpiId &&
          other.value == this.value &&
          other.date == this.date &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class KpiLogsCompanion extends UpdateCompanion<KpiLog> {
  final Value<String> id;
  final Value<String> kpiId;
  final Value<double> value;
  final Value<DateTime> date;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const KpiLogsCompanion({
    this.id = const Value.absent(),
    this.kpiId = const Value.absent(),
    this.value = const Value.absent(),
    this.date = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KpiLogsCompanion.insert({
    required String id,
    required String kpiId,
    required double value,
    required DateTime date,
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        kpiId = Value(kpiId),
        value = Value(value),
        date = Value(date);
  static Insertable<KpiLog> custom({
    Expression<String>? id,
    Expression<String>? kpiId,
    Expression<double>? value,
    Expression<DateTime>? date,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kpiId != null) 'kpi_id': kpiId,
      if (value != null) 'value': value,
      if (date != null) 'date': date,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KpiLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? kpiId,
      Value<double>? value,
      Value<DateTime>? date,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return KpiLogsCompanion(
      id: id ?? this.id,
      kpiId: kpiId ?? this.kpiId,
      value: value ?? this.value,
      date: date ?? this.date,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kpiId.present) {
      map['kpi_id'] = Variable<String>(kpiId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KpiLogsCompanion(')
          ..write('id: $id, ')
          ..write('kpiId: $kpiId, ')
          ..write('value: $value, ')
          ..write('date: $date, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _weekStartMeta =
      const VerificationMeta('weekStart');
  @override
  late final GeneratedColumn<DateTime> weekStart = GeneratedColumn<DateTime>(
      'week_start', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _completedTasksMeta =
      const VerificationMeta('completedTasks');
  @override
  late final GeneratedColumn<int> completedTasks = GeneratedColumn<int>(
      'completed_tasks', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalTasksMeta =
      const VerificationMeta('totalTasks');
  @override
  late final GeneratedColumn<int> totalTasks = GeneratedColumn<int>(
      'total_tasks', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _habitSuccessRateMeta =
      const VerificationMeta('habitSuccessRate');
  @override
  late final GeneratedColumn<double> habitSuccessRate = GeneratedColumn<double>(
      'habit_success_rate', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant<double>(0));
  static const VerificationMeta _totalMinutesMeta =
      const VerificationMeta('totalMinutes');
  @override
  late final GeneratedColumn<int> totalMinutes = GeneratedColumn<int>(
      'total_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _deepWorkMinutesMeta =
      const VerificationMeta('deepWorkMinutes');
  @override
  late final GeneratedColumn<int> deepWorkMinutes = GeneratedColumn<int>(
      'deep_work_minutes', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _incomeMeta = const VerificationMeta('income');
  @override
  late final GeneratedColumn<double> income = GeneratedColumn<double>(
      'income', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant<double>(0));
  static const VerificationMeta _expenseMeta =
      const VerificationMeta('expense');
  @override
  late final GeneratedColumn<double> expense = GeneratedColumn<double>(
      'expense', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant<double>(0));
  static const VerificationMeta _activeGoalsCountMeta =
      const VerificationMeta('activeGoalsCount');
  @override
  late final GeneratedColumn<int> activeGoalsCount = GeneratedColumn<int>(
      'active_goals_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _completedGoalsCountMeta =
      const VerificationMeta('completedGoalsCount');
  @override
  late final GeneratedColumn<int> completedGoalsCount = GeneratedColumn<int>(
      'completed_goals_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _answeredWorkedMeta =
      const VerificationMeta('answeredWorked');
  @override
  late final GeneratedColumn<String> answeredWorked = GeneratedColumn<String>(
      'answered_worked', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answeredFailedMeta =
      const VerificationMeta('answeredFailed');
  @override
  late final GeneratedColumn<String> answeredFailed = GeneratedColumn<String>(
      'answered_failed', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answeredLearnedMeta =
      const VerificationMeta('answeredLearned');
  @override
  late final GeneratedColumn<String> answeredLearned = GeneratedColumn<String>(
      'answered_learned', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        weekStart,
        completedTasks,
        totalTasks,
        habitSuccessRate,
        totalMinutes,
        deepWorkMinutes,
        income,
        expense,
        activeGoalsCount,
        completedGoalsCount,
        answeredWorked,
        answeredFailed,
        answeredLearned,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(Insertable<WeeklyReview> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('week_start')) {
      context.handle(_weekStartMeta,
          weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta));
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('completed_tasks')) {
      context.handle(
          _completedTasksMeta,
          completedTasks.isAcceptableOrUnknown(
              data['completed_tasks']!, _completedTasksMeta));
    }
    if (data.containsKey('total_tasks')) {
      context.handle(
          _totalTasksMeta,
          totalTasks.isAcceptableOrUnknown(
              data['total_tasks']!, _totalTasksMeta));
    }
    if (data.containsKey('habit_success_rate')) {
      context.handle(
          _habitSuccessRateMeta,
          habitSuccessRate.isAcceptableOrUnknown(
              data['habit_success_rate']!, _habitSuccessRateMeta));
    }
    if (data.containsKey('total_minutes')) {
      context.handle(
          _totalMinutesMeta,
          totalMinutes.isAcceptableOrUnknown(
              data['total_minutes']!, _totalMinutesMeta));
    }
    if (data.containsKey('deep_work_minutes')) {
      context.handle(
          _deepWorkMinutesMeta,
          deepWorkMinutes.isAcceptableOrUnknown(
              data['deep_work_minutes']!, _deepWorkMinutesMeta));
    }
    if (data.containsKey('income')) {
      context.handle(_incomeMeta,
          income.isAcceptableOrUnknown(data['income']!, _incomeMeta));
    }
    if (data.containsKey('expense')) {
      context.handle(_expenseMeta,
          expense.isAcceptableOrUnknown(data['expense']!, _expenseMeta));
    }
    if (data.containsKey('active_goals_count')) {
      context.handle(
          _activeGoalsCountMeta,
          activeGoalsCount.isAcceptableOrUnknown(
              data['active_goals_count']!, _activeGoalsCountMeta));
    }
    if (data.containsKey('completed_goals_count')) {
      context.handle(
          _completedGoalsCountMeta,
          completedGoalsCount.isAcceptableOrUnknown(
              data['completed_goals_count']!, _completedGoalsCountMeta));
    }
    if (data.containsKey('answered_worked')) {
      context.handle(
          _answeredWorkedMeta,
          answeredWorked.isAcceptableOrUnknown(
              data['answered_worked']!, _answeredWorkedMeta));
    }
    if (data.containsKey('answered_failed')) {
      context.handle(
          _answeredFailedMeta,
          answeredFailed.isAcceptableOrUnknown(
              data['answered_failed']!, _answeredFailedMeta));
    }
    if (data.containsKey('answered_learned')) {
      context.handle(
          _answeredLearnedMeta,
          answeredLearned.isAcceptableOrUnknown(
              data['answered_learned']!, _answeredLearnedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeeklyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReview(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      weekStart: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}week_start'])!,
      completedTasks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}completed_tasks'])!,
      totalTasks: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_tasks'])!,
      habitSuccessRate: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}habit_success_rate'])!,
      totalMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_minutes'])!,
      deepWorkMinutes: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}deep_work_minutes'])!,
      income: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}income'])!,
      expense: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}expense'])!,
      activeGoalsCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}active_goals_count'])!,
      completedGoalsCount: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}completed_goals_count'])!,
      answeredWorked: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answered_worked']),
      answeredFailed: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answered_failed']),
      answeredLearned: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}answered_learned']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReview extends DataClass implements Insertable<WeeklyReview> {
  final String id;
  final DateTime weekStart;
  final int completedTasks;
  final int totalTasks;
  final double habitSuccessRate;
  final int totalMinutes;
  final int deepWorkMinutes;
  final double income;
  final double expense;
  final int activeGoalsCount;
  final int completedGoalsCount;
  final String? answeredWorked;
  final String? answeredFailed;
  final String? answeredLearned;
  final DateTime createdAt;
  const WeeklyReview(
      {required this.id,
      required this.weekStart,
      required this.completedTasks,
      required this.totalTasks,
      required this.habitSuccessRate,
      required this.totalMinutes,
      required this.deepWorkMinutes,
      required this.income,
      required this.expense,
      required this.activeGoalsCount,
      required this.completedGoalsCount,
      this.answeredWorked,
      this.answeredFailed,
      this.answeredLearned,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['week_start'] = Variable<DateTime>(weekStart);
    map['completed_tasks'] = Variable<int>(completedTasks);
    map['total_tasks'] = Variable<int>(totalTasks);
    map['habit_success_rate'] = Variable<double>(habitSuccessRate);
    map['total_minutes'] = Variable<int>(totalMinutes);
    map['deep_work_minutes'] = Variable<int>(deepWorkMinutes);
    map['income'] = Variable<double>(income);
    map['expense'] = Variable<double>(expense);
    map['active_goals_count'] = Variable<int>(activeGoalsCount);
    map['completed_goals_count'] = Variable<int>(completedGoalsCount);
    if (!nullToAbsent || answeredWorked != null) {
      map['answered_worked'] = Variable<String>(answeredWorked);
    }
    if (!nullToAbsent || answeredFailed != null) {
      map['answered_failed'] = Variable<String>(answeredFailed);
    }
    if (!nullToAbsent || answeredLearned != null) {
      map['answered_learned'] = Variable<String>(answeredLearned);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      id: Value(id),
      weekStart: Value(weekStart),
      completedTasks: Value(completedTasks),
      totalTasks: Value(totalTasks),
      habitSuccessRate: Value(habitSuccessRate),
      totalMinutes: Value(totalMinutes),
      deepWorkMinutes: Value(deepWorkMinutes),
      income: Value(income),
      expense: Value(expense),
      activeGoalsCount: Value(activeGoalsCount),
      completedGoalsCount: Value(completedGoalsCount),
      answeredWorked: answeredWorked == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredWorked),
      answeredFailed: answeredFailed == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredFailed),
      answeredLearned: answeredLearned == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredLearned),
      createdAt: Value(createdAt),
    );
  }

  factory WeeklyReview.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReview(
      id: serializer.fromJson<String>(json['id']),
      weekStart: serializer.fromJson<DateTime>(json['weekStart']),
      completedTasks: serializer.fromJson<int>(json['completedTasks']),
      totalTasks: serializer.fromJson<int>(json['totalTasks']),
      habitSuccessRate: serializer.fromJson<double>(json['habitSuccessRate']),
      totalMinutes: serializer.fromJson<int>(json['totalMinutes']),
      deepWorkMinutes: serializer.fromJson<int>(json['deepWorkMinutes']),
      income: serializer.fromJson<double>(json['income']),
      expense: serializer.fromJson<double>(json['expense']),
      activeGoalsCount: serializer.fromJson<int>(json['activeGoalsCount']),
      completedGoalsCount:
          serializer.fromJson<int>(json['completedGoalsCount']),
      answeredWorked: serializer.fromJson<String?>(json['answeredWorked']),
      answeredFailed: serializer.fromJson<String?>(json['answeredFailed']),
      answeredLearned: serializer.fromJson<String?>(json['answeredLearned']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'weekStart': serializer.toJson<DateTime>(weekStart),
      'completedTasks': serializer.toJson<int>(completedTasks),
      'totalTasks': serializer.toJson<int>(totalTasks),
      'habitSuccessRate': serializer.toJson<double>(habitSuccessRate),
      'totalMinutes': serializer.toJson<int>(totalMinutes),
      'deepWorkMinutes': serializer.toJson<int>(deepWorkMinutes),
      'income': serializer.toJson<double>(income),
      'expense': serializer.toJson<double>(expense),
      'activeGoalsCount': serializer.toJson<int>(activeGoalsCount),
      'completedGoalsCount': serializer.toJson<int>(completedGoalsCount),
      'answeredWorked': serializer.toJson<String?>(answeredWorked),
      'answeredFailed': serializer.toJson<String?>(answeredFailed),
      'answeredLearned': serializer.toJson<String?>(answeredLearned),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  WeeklyReview copyWith(
          {String? id,
          DateTime? weekStart,
          int? completedTasks,
          int? totalTasks,
          double? habitSuccessRate,
          int? totalMinutes,
          int? deepWorkMinutes,
          double? income,
          double? expense,
          int? activeGoalsCount,
          int? completedGoalsCount,
          Value<String?> answeredWorked = const Value.absent(),
          Value<String?> answeredFailed = const Value.absent(),
          Value<String?> answeredLearned = const Value.absent(),
          DateTime? createdAt}) =>
      WeeklyReview(
        id: id ?? this.id,
        weekStart: weekStart ?? this.weekStart,
        completedTasks: completedTasks ?? this.completedTasks,
        totalTasks: totalTasks ?? this.totalTasks,
        habitSuccessRate: habitSuccessRate ?? this.habitSuccessRate,
        totalMinutes: totalMinutes ?? this.totalMinutes,
        deepWorkMinutes: deepWorkMinutes ?? this.deepWorkMinutes,
        income: income ?? this.income,
        expense: expense ?? this.expense,
        activeGoalsCount: activeGoalsCount ?? this.activeGoalsCount,
        completedGoalsCount: completedGoalsCount ?? this.completedGoalsCount,
        answeredWorked:
            answeredWorked.present ? answeredWorked.value : this.answeredWorked,
        answeredFailed:
            answeredFailed.present ? answeredFailed.value : this.answeredFailed,
        answeredLearned: answeredLearned.present
            ? answeredLearned.value
            : this.answeredLearned,
        createdAt: createdAt ?? this.createdAt,
      );
  WeeklyReview copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReview(
      id: data.id.present ? data.id.value : this.id,
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      completedTasks: data.completedTasks.present
          ? data.completedTasks.value
          : this.completedTasks,
      totalTasks:
          data.totalTasks.present ? data.totalTasks.value : this.totalTasks,
      habitSuccessRate: data.habitSuccessRate.present
          ? data.habitSuccessRate.value
          : this.habitSuccessRate,
      totalMinutes: data.totalMinutes.present
          ? data.totalMinutes.value
          : this.totalMinutes,
      deepWorkMinutes: data.deepWorkMinutes.present
          ? data.deepWorkMinutes.value
          : this.deepWorkMinutes,
      income: data.income.present ? data.income.value : this.income,
      expense: data.expense.present ? data.expense.value : this.expense,
      activeGoalsCount: data.activeGoalsCount.present
          ? data.activeGoalsCount.value
          : this.activeGoalsCount,
      completedGoalsCount: data.completedGoalsCount.present
          ? data.completedGoalsCount.value
          : this.completedGoalsCount,
      answeredWorked: data.answeredWorked.present
          ? data.answeredWorked.value
          : this.answeredWorked,
      answeredFailed: data.answeredFailed.present
          ? data.answeredFailed.value
          : this.answeredFailed,
      answeredLearned: data.answeredLearned.present
          ? data.answeredLearned.value
          : this.answeredLearned,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReview(')
          ..write('id: $id, ')
          ..write('weekStart: $weekStart, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('totalTasks: $totalTasks, ')
          ..write('habitSuccessRate: $habitSuccessRate, ')
          ..write('totalMinutes: $totalMinutes, ')
          ..write('deepWorkMinutes: $deepWorkMinutes, ')
          ..write('income: $income, ')
          ..write('expense: $expense, ')
          ..write('activeGoalsCount: $activeGoalsCount, ')
          ..write('completedGoalsCount: $completedGoalsCount, ')
          ..write('answeredWorked: $answeredWorked, ')
          ..write('answeredFailed: $answeredFailed, ')
          ..write('answeredLearned: $answeredLearned, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      weekStart,
      completedTasks,
      totalTasks,
      habitSuccessRate,
      totalMinutes,
      deepWorkMinutes,
      income,
      expense,
      activeGoalsCount,
      completedGoalsCount,
      answeredWorked,
      answeredFailed,
      answeredLearned,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReview &&
          other.id == this.id &&
          other.weekStart == this.weekStart &&
          other.completedTasks == this.completedTasks &&
          other.totalTasks == this.totalTasks &&
          other.habitSuccessRate == this.habitSuccessRate &&
          other.totalMinutes == this.totalMinutes &&
          other.deepWorkMinutes == this.deepWorkMinutes &&
          other.income == this.income &&
          other.expense == this.expense &&
          other.activeGoalsCount == this.activeGoalsCount &&
          other.completedGoalsCount == this.completedGoalsCount &&
          other.answeredWorked == this.answeredWorked &&
          other.answeredFailed == this.answeredFailed &&
          other.answeredLearned == this.answeredLearned &&
          other.createdAt == this.createdAt);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReview> {
  final Value<String> id;
  final Value<DateTime> weekStart;
  final Value<int> completedTasks;
  final Value<int> totalTasks;
  final Value<double> habitSuccessRate;
  final Value<int> totalMinutes;
  final Value<int> deepWorkMinutes;
  final Value<double> income;
  final Value<double> expense;
  final Value<int> activeGoalsCount;
  final Value<int> completedGoalsCount;
  final Value<String?> answeredWorked;
  final Value<String?> answeredFailed;
  final Value<String?> answeredLearned;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.id = const Value.absent(),
    this.weekStart = const Value.absent(),
    this.completedTasks = const Value.absent(),
    this.totalTasks = const Value.absent(),
    this.habitSuccessRate = const Value.absent(),
    this.totalMinutes = const Value.absent(),
    this.deepWorkMinutes = const Value.absent(),
    this.income = const Value.absent(),
    this.expense = const Value.absent(),
    this.activeGoalsCount = const Value.absent(),
    this.completedGoalsCount = const Value.absent(),
    this.answeredWorked = const Value.absent(),
    this.answeredFailed = const Value.absent(),
    this.answeredLearned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    required String id,
    required DateTime weekStart,
    this.completedTasks = const Value.absent(),
    this.totalTasks = const Value.absent(),
    this.habitSuccessRate = const Value.absent(),
    this.totalMinutes = const Value.absent(),
    this.deepWorkMinutes = const Value.absent(),
    this.income = const Value.absent(),
    this.expense = const Value.absent(),
    this.activeGoalsCount = const Value.absent(),
    this.completedGoalsCount = const Value.absent(),
    this.answeredWorked = const Value.absent(),
    this.answeredFailed = const Value.absent(),
    this.answeredLearned = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        weekStart = Value(weekStart);
  static Insertable<WeeklyReview> custom({
    Expression<String>? id,
    Expression<DateTime>? weekStart,
    Expression<int>? completedTasks,
    Expression<int>? totalTasks,
    Expression<double>? habitSuccessRate,
    Expression<int>? totalMinutes,
    Expression<int>? deepWorkMinutes,
    Expression<double>? income,
    Expression<double>? expense,
    Expression<int>? activeGoalsCount,
    Expression<int>? completedGoalsCount,
    Expression<String>? answeredWorked,
    Expression<String>? answeredFailed,
    Expression<String>? answeredLearned,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (weekStart != null) 'week_start': weekStart,
      if (completedTasks != null) 'completed_tasks': completedTasks,
      if (totalTasks != null) 'total_tasks': totalTasks,
      if (habitSuccessRate != null) 'habit_success_rate': habitSuccessRate,
      if (totalMinutes != null) 'total_minutes': totalMinutes,
      if (deepWorkMinutes != null) 'deep_work_minutes': deepWorkMinutes,
      if (income != null) 'income': income,
      if (expense != null) 'expense': expense,
      if (activeGoalsCount != null) 'active_goals_count': activeGoalsCount,
      if (completedGoalsCount != null)
        'completed_goals_count': completedGoalsCount,
      if (answeredWorked != null) 'answered_worked': answeredWorked,
      if (answeredFailed != null) 'answered_failed': answeredFailed,
      if (answeredLearned != null) 'answered_learned': answeredLearned,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith(
      {Value<String>? id,
      Value<DateTime>? weekStart,
      Value<int>? completedTasks,
      Value<int>? totalTasks,
      Value<double>? habitSuccessRate,
      Value<int>? totalMinutes,
      Value<int>? deepWorkMinutes,
      Value<double>? income,
      Value<double>? expense,
      Value<int>? activeGoalsCount,
      Value<int>? completedGoalsCount,
      Value<String?>? answeredWorked,
      Value<String?>? answeredFailed,
      Value<String?>? answeredLearned,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return WeeklyReviewsCompanion(
      id: id ?? this.id,
      weekStart: weekStart ?? this.weekStart,
      completedTasks: completedTasks ?? this.completedTasks,
      totalTasks: totalTasks ?? this.totalTasks,
      habitSuccessRate: habitSuccessRate ?? this.habitSuccessRate,
      totalMinutes: totalMinutes ?? this.totalMinutes,
      deepWorkMinutes: deepWorkMinutes ?? this.deepWorkMinutes,
      income: income ?? this.income,
      expense: expense ?? this.expense,
      activeGoalsCount: activeGoalsCount ?? this.activeGoalsCount,
      completedGoalsCount: completedGoalsCount ?? this.completedGoalsCount,
      answeredWorked: answeredWorked ?? this.answeredWorked,
      answeredFailed: answeredFailed ?? this.answeredFailed,
      answeredLearned: answeredLearned ?? this.answeredLearned,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (weekStart.present) {
      map['week_start'] = Variable<DateTime>(weekStart.value);
    }
    if (completedTasks.present) {
      map['completed_tasks'] = Variable<int>(completedTasks.value);
    }
    if (totalTasks.present) {
      map['total_tasks'] = Variable<int>(totalTasks.value);
    }
    if (habitSuccessRate.present) {
      map['habit_success_rate'] = Variable<double>(habitSuccessRate.value);
    }
    if (totalMinutes.present) {
      map['total_minutes'] = Variable<int>(totalMinutes.value);
    }
    if (deepWorkMinutes.present) {
      map['deep_work_minutes'] = Variable<int>(deepWorkMinutes.value);
    }
    if (income.present) {
      map['income'] = Variable<double>(income.value);
    }
    if (expense.present) {
      map['expense'] = Variable<double>(expense.value);
    }
    if (activeGoalsCount.present) {
      map['active_goals_count'] = Variable<int>(activeGoalsCount.value);
    }
    if (completedGoalsCount.present) {
      map['completed_goals_count'] = Variable<int>(completedGoalsCount.value);
    }
    if (answeredWorked.present) {
      map['answered_worked'] = Variable<String>(answeredWorked.value);
    }
    if (answeredFailed.present) {
      map['answered_failed'] = Variable<String>(answeredFailed.value);
    }
    if (answeredLearned.present) {
      map['answered_learned'] = Variable<String>(answeredLearned.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('id: $id, ')
          ..write('weekStart: $weekStart, ')
          ..write('completedTasks: $completedTasks, ')
          ..write('totalTasks: $totalTasks, ')
          ..write('habitSuccessRate: $habitSuccessRate, ')
          ..write('totalMinutes: $totalMinutes, ')
          ..write('deepWorkMinutes: $deepWorkMinutes, ')
          ..write('income: $income, ')
          ..write('expense: $expense, ')
          ..write('activeGoalsCount: $activeGoalsCount, ')
          ..write('completedGoalsCount: $completedGoalsCount, ')
          ..write('answeredWorked: $answeredWorked, ')
          ..write('answeredFailed: $answeredFailed, ')
          ..write('answeredLearned: $answeredLearned, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyReflectionsTable extends MonthlyReflections
    with TableInfo<$MonthlyReflectionsTable, MonthlyReflection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyReflectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<int> year = GeneratedColumn<int>(
      'year', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _monthMeta = const VerificationMeta('month');
  @override
  late final GeneratedColumn<int> month = GeneratedColumn<int>(
      'month', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _answeredContinueMeta =
      const VerificationMeta('answeredContinue');
  @override
  late final GeneratedColumn<String> answeredContinue = GeneratedColumn<String>(
      'answered_continue', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answeredStopMeta =
      const VerificationMeta('answeredStop');
  @override
  late final GeneratedColumn<String> answeredStop = GeneratedColumn<String>(
      'answered_stop', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answeredStartMeta =
      const VerificationMeta('answeredStart');
  @override
  late final GeneratedColumn<String> answeredStart = GeneratedColumn<String>(
      'answered_start', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _answeredProudMeta =
      const VerificationMeta('answeredProud');
  @override
  late final GeneratedColumn<String> answeredProud = GeneratedColumn<String>(
      'answered_proud', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        year,
        month,
        answeredContinue,
        answeredStop,
        answeredStart,
        answeredProud,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_reflections';
  @override
  VerificationContext validateIntegrity(Insertable<MonthlyReflection> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    if (data.containsKey('month')) {
      context.handle(
          _monthMeta, month.isAcceptableOrUnknown(data['month']!, _monthMeta));
    } else if (isInserting) {
      context.missing(_monthMeta);
    }
    if (data.containsKey('answered_continue')) {
      context.handle(
          _answeredContinueMeta,
          answeredContinue.isAcceptableOrUnknown(
              data['answered_continue']!, _answeredContinueMeta));
    }
    if (data.containsKey('answered_stop')) {
      context.handle(
          _answeredStopMeta,
          answeredStop.isAcceptableOrUnknown(
              data['answered_stop']!, _answeredStopMeta));
    }
    if (data.containsKey('answered_start')) {
      context.handle(
          _answeredStartMeta,
          answeredStart.isAcceptableOrUnknown(
              data['answered_start']!, _answeredStartMeta));
    }
    if (data.containsKey('answered_proud')) {
      context.handle(
          _answeredProudMeta,
          answeredProud.isAcceptableOrUnknown(
              data['answered_proud']!, _answeredProudMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MonthlyReflection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyReflection(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}year'])!,
      month: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}month'])!,
      answeredContinue: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}answered_continue']),
      answeredStop: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answered_stop']),
      answeredStart: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answered_start']),
      answeredProud: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}answered_proud']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $MonthlyReflectionsTable createAlias(String alias) {
    return $MonthlyReflectionsTable(attachedDatabase, alias);
  }
}

class MonthlyReflection extends DataClass
    implements Insertable<MonthlyReflection> {
  final String id;
  final int year;
  final int month;
  final String? answeredContinue;
  final String? answeredStop;
  final String? answeredStart;
  final String? answeredProud;
  final DateTime createdAt;
  const MonthlyReflection(
      {required this.id,
      required this.year,
      required this.month,
      this.answeredContinue,
      this.answeredStop,
      this.answeredStart,
      this.answeredProud,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['year'] = Variable<int>(year);
    map['month'] = Variable<int>(month);
    if (!nullToAbsent || answeredContinue != null) {
      map['answered_continue'] = Variable<String>(answeredContinue);
    }
    if (!nullToAbsent || answeredStop != null) {
      map['answered_stop'] = Variable<String>(answeredStop);
    }
    if (!nullToAbsent || answeredStart != null) {
      map['answered_start'] = Variable<String>(answeredStart);
    }
    if (!nullToAbsent || answeredProud != null) {
      map['answered_proud'] = Variable<String>(answeredProud);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MonthlyReflectionsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyReflectionsCompanion(
      id: Value(id),
      year: Value(year),
      month: Value(month),
      answeredContinue: answeredContinue == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredContinue),
      answeredStop: answeredStop == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredStop),
      answeredStart: answeredStart == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredStart),
      answeredProud: answeredProud == null && nullToAbsent
          ? const Value.absent()
          : Value(answeredProud),
      createdAt: Value(createdAt),
    );
  }

  factory MonthlyReflection.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyReflection(
      id: serializer.fromJson<String>(json['id']),
      year: serializer.fromJson<int>(json['year']),
      month: serializer.fromJson<int>(json['month']),
      answeredContinue: serializer.fromJson<String?>(json['answeredContinue']),
      answeredStop: serializer.fromJson<String?>(json['answeredStop']),
      answeredStart: serializer.fromJson<String?>(json['answeredStart']),
      answeredProud: serializer.fromJson<String?>(json['answeredProud']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'year': serializer.toJson<int>(year),
      'month': serializer.toJson<int>(month),
      'answeredContinue': serializer.toJson<String?>(answeredContinue),
      'answeredStop': serializer.toJson<String?>(answeredStop),
      'answeredStart': serializer.toJson<String?>(answeredStart),
      'answeredProud': serializer.toJson<String?>(answeredProud),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MonthlyReflection copyWith(
          {String? id,
          int? year,
          int? month,
          Value<String?> answeredContinue = const Value.absent(),
          Value<String?> answeredStop = const Value.absent(),
          Value<String?> answeredStart = const Value.absent(),
          Value<String?> answeredProud = const Value.absent(),
          DateTime? createdAt}) =>
      MonthlyReflection(
        id: id ?? this.id,
        year: year ?? this.year,
        month: month ?? this.month,
        answeredContinue: answeredContinue.present
            ? answeredContinue.value
            : this.answeredContinue,
        answeredStop:
            answeredStop.present ? answeredStop.value : this.answeredStop,
        answeredStart:
            answeredStart.present ? answeredStart.value : this.answeredStart,
        answeredProud:
            answeredProud.present ? answeredProud.value : this.answeredProud,
        createdAt: createdAt ?? this.createdAt,
      );
  MonthlyReflection copyWithCompanion(MonthlyReflectionsCompanion data) {
    return MonthlyReflection(
      id: data.id.present ? data.id.value : this.id,
      year: data.year.present ? data.year.value : this.year,
      month: data.month.present ? data.month.value : this.month,
      answeredContinue: data.answeredContinue.present
          ? data.answeredContinue.value
          : this.answeredContinue,
      answeredStop: data.answeredStop.present
          ? data.answeredStop.value
          : this.answeredStop,
      answeredStart: data.answeredStart.present
          ? data.answeredStart.value
          : this.answeredStart,
      answeredProud: data.answeredProud.present
          ? data.answeredProud.value
          : this.answeredProud,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReflection(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('answeredContinue: $answeredContinue, ')
          ..write('answeredStop: $answeredStop, ')
          ..write('answeredStart: $answeredStart, ')
          ..write('answeredProud: $answeredProud, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, year, month, answeredContinue,
      answeredStop, answeredStart, answeredProud, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyReflection &&
          other.id == this.id &&
          other.year == this.year &&
          other.month == this.month &&
          other.answeredContinue == this.answeredContinue &&
          other.answeredStop == this.answeredStop &&
          other.answeredStart == this.answeredStart &&
          other.answeredProud == this.answeredProud &&
          other.createdAt == this.createdAt);
}

class MonthlyReflectionsCompanion extends UpdateCompanion<MonthlyReflection> {
  final Value<String> id;
  final Value<int> year;
  final Value<int> month;
  final Value<String?> answeredContinue;
  final Value<String?> answeredStop;
  final Value<String?> answeredStart;
  final Value<String?> answeredProud;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MonthlyReflectionsCompanion({
    this.id = const Value.absent(),
    this.year = const Value.absent(),
    this.month = const Value.absent(),
    this.answeredContinue = const Value.absent(),
    this.answeredStop = const Value.absent(),
    this.answeredStart = const Value.absent(),
    this.answeredProud = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyReflectionsCompanion.insert({
    required String id,
    required int year,
    required int month,
    this.answeredContinue = const Value.absent(),
    this.answeredStop = const Value.absent(),
    this.answeredStart = const Value.absent(),
    this.answeredProud = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        year = Value(year),
        month = Value(month);
  static Insertable<MonthlyReflection> custom({
    Expression<String>? id,
    Expression<int>? year,
    Expression<int>? month,
    Expression<String>? answeredContinue,
    Expression<String>? answeredStop,
    Expression<String>? answeredStart,
    Expression<String>? answeredProud,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (year != null) 'year': year,
      if (month != null) 'month': month,
      if (answeredContinue != null) 'answered_continue': answeredContinue,
      if (answeredStop != null) 'answered_stop': answeredStop,
      if (answeredStart != null) 'answered_start': answeredStart,
      if (answeredProud != null) 'answered_proud': answeredProud,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyReflectionsCompanion copyWith(
      {Value<String>? id,
      Value<int>? year,
      Value<int>? month,
      Value<String?>? answeredContinue,
      Value<String?>? answeredStop,
      Value<String?>? answeredStart,
      Value<String?>? answeredProud,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return MonthlyReflectionsCompanion(
      id: id ?? this.id,
      year: year ?? this.year,
      month: month ?? this.month,
      answeredContinue: answeredContinue ?? this.answeredContinue,
      answeredStop: answeredStop ?? this.answeredStop,
      answeredStart: answeredStart ?? this.answeredStart,
      answeredProud: answeredProud ?? this.answeredProud,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (year.present) {
      map['year'] = Variable<int>(year.value);
    }
    if (month.present) {
      map['month'] = Variable<int>(month.value);
    }
    if (answeredContinue.present) {
      map['answered_continue'] = Variable<String>(answeredContinue.value);
    }
    if (answeredStop.present) {
      map['answered_stop'] = Variable<String>(answeredStop.value);
    }
    if (answeredStart.present) {
      map['answered_start'] = Variable<String>(answeredStart.value);
    }
    if (answeredProud.present) {
      map['answered_proud'] = Variable<String>(answeredProud.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReflectionsCompanion(')
          ..write('id: $id, ')
          ..write('year: $year, ')
          ..write('month: $month, ')
          ..write('answeredContinue: $answeredContinue, ')
          ..write('answeredStop: $answeredStop, ')
          ..write('answeredStart: $answeredStart, ')
          ..write('answeredProud: $answeredProud, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LongGoalsTable longGoals = $LongGoalsTable(this);
  late final $ShortGoalsTable shortGoals = $ShortGoalsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TransactionsTable transactions = $TransactionsTable(this);
  late final $DebtsTable debts = $DebtsTable(this);
  late final $FinancialGoalsTable financialGoals = $FinancialGoalsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $TimeLogsTable timeLogs = $TimeLogsTable(this);
  late final $KpisTable kpis = $KpisTable(this);
  late final $KpiLogsTable kpiLogs = $KpiLogsTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $MonthlyReflectionsTable monthlyReflections =
      $MonthlyReflectionsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        longGoals,
        shortGoals,
        tasks,
        transactions,
        debts,
        financialGoals,
        habits,
        habitLogs,
        timeLogs,
        kpis,
        kpiLogs,
        weeklyReviews,
        monthlyReflections
      ];
}

typedef $$LongGoalsTableCreateCompanionBuilder = LongGoalsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  Value<DateTime?> deadline,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LongGoalsTableUpdateCompanionBuilder = LongGoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime?> deadline,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LongGoalsTableReferences
    extends BaseReferences<_$AppDatabase, $LongGoalsTable, LongGoal> {
  $$LongGoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ShortGoalsTable, List<ShortGoal>>
      _shortGoalsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.shortGoals,
          aliasName:
              $_aliasNameGenerator(db.longGoals.id, db.shortGoals.longGoalId));

  $$ShortGoalsTableProcessedTableManager get shortGoalsRefs {
    final manager = $$ShortGoalsTableTableManager($_db, $_db.shortGoals)
        .filter((f) => f.longGoalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_shortGoalsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LongGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $LongGoalsTable> {
  $$LongGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> shortGoalsRefs(
      Expression<bool> Function($$ShortGoalsTableFilterComposer f) f) {
    final $$ShortGoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.shortGoals,
        getReferencedColumn: (t) => t.longGoalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShortGoalsTableFilterComposer(
              $db: $db,
              $table: $db.shortGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LongGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $LongGoalsTable> {
  $$LongGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$LongGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LongGoalsTable> {
  $$LongGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> shortGoalsRefs<T extends Object>(
      Expression<T> Function($$ShortGoalsTableAnnotationComposer a) f) {
    final $$ShortGoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.shortGoals,
        getReferencedColumn: (t) => t.longGoalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShortGoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.shortGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LongGoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LongGoalsTable,
    LongGoal,
    $$LongGoalsTableFilterComposer,
    $$LongGoalsTableOrderingComposer,
    $$LongGoalsTableAnnotationComposer,
    $$LongGoalsTableCreateCompanionBuilder,
    $$LongGoalsTableUpdateCompanionBuilder,
    (LongGoal, $$LongGoalsTableReferences),
    LongGoal,
    PrefetchHooks Function({bool shortGoalsRefs})> {
  $$LongGoalsTableTableManager(_$AppDatabase db, $LongGoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LongGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LongGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LongGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LongGoalsCompanion(
            id: id,
            title: title,
            description: description,
            deadline: deadline,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LongGoalsCompanion.insert(
            id: id,
            title: title,
            description: description,
            deadline: deadline,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LongGoalsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({shortGoalsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (shortGoalsRefs) db.shortGoals],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (shortGoalsRefs)
                    await $_getPrefetchedData<LongGoal, $LongGoalsTable,
                            ShortGoal>(
                        currentTable: table,
                        referencedTable:
                            $$LongGoalsTableReferences._shortGoalsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LongGoalsTableReferences(db, table, p0)
                                .shortGoalsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.longGoalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LongGoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LongGoalsTable,
    LongGoal,
    $$LongGoalsTableFilterComposer,
    $$LongGoalsTableOrderingComposer,
    $$LongGoalsTableAnnotationComposer,
    $$LongGoalsTableCreateCompanionBuilder,
    $$LongGoalsTableUpdateCompanionBuilder,
    (LongGoal, $$LongGoalsTableReferences),
    LongGoal,
    PrefetchHooks Function({bool shortGoalsRefs})>;
typedef $$ShortGoalsTableCreateCompanionBuilder = ShortGoalsCompanion Function({
  required String id,
  required String title,
  Value<String?> longGoalId,
  Value<DateTime?> deadline,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$ShortGoalsTableUpdateCompanionBuilder = ShortGoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> longGoalId,
  Value<DateTime?> deadline,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$ShortGoalsTableReferences
    extends BaseReferences<_$AppDatabase, $ShortGoalsTable, ShortGoal> {
  $$ShortGoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LongGoalsTable _longGoalIdTable(_$AppDatabase db) =>
      db.longGoals.createAlias(
          $_aliasNameGenerator(db.shortGoals.longGoalId, db.longGoals.id));

  $$LongGoalsTableProcessedTableManager? get longGoalId {
    final $_column = $_itemColumn<String>('long_goal_id');
    if ($_column == null) return null;
    final manager = $$LongGoalsTableTableManager($_db, $_db.longGoals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_longGoalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.tasks,
          aliasName:
              $_aliasNameGenerator(db.shortGoals.id, db.tasks.shortGoalId));

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager($_db, $_db.tasks)
        .filter((f) => f.shortGoalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ShortGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $ShortGoalsTable> {
  $$ShortGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LongGoalsTableFilterComposer get longGoalId {
    final $$LongGoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.longGoalId,
        referencedTable: $db.longGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongGoalsTableFilterComposer(
              $db: $db,
              $table: $db.longGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> tasksRefs(
      Expression<bool> Function($$TasksTableFilterComposer f) f) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.shortGoalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableFilterComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ShortGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShortGoalsTable> {
  $$ShortGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LongGoalsTableOrderingComposer get longGoalId {
    final $$LongGoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.longGoalId,
        referencedTable: $db.longGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongGoalsTableOrderingComposer(
              $db: $db,
              $table: $db.longGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ShortGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShortGoalsTable> {
  $$ShortGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LongGoalsTableAnnotationComposer get longGoalId {
    final $$LongGoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.longGoalId,
        referencedTable: $db.longGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LongGoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.longGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> tasksRefs<T extends Object>(
      Expression<T> Function($$TasksTableAnnotationComposer a) f) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.tasks,
        getReferencedColumn: (t) => t.shortGoalId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TasksTableAnnotationComposer(
              $db: $db,
              $table: $db.tasks,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ShortGoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ShortGoalsTable,
    ShortGoal,
    $$ShortGoalsTableFilterComposer,
    $$ShortGoalsTableOrderingComposer,
    $$ShortGoalsTableAnnotationComposer,
    $$ShortGoalsTableCreateCompanionBuilder,
    $$ShortGoalsTableUpdateCompanionBuilder,
    (ShortGoal, $$ShortGoalsTableReferences),
    ShortGoal,
    PrefetchHooks Function({bool longGoalId, bool tasksRefs})> {
  $$ShortGoalsTableTableManager(_$AppDatabase db, $ShortGoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShortGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShortGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShortGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> longGoalId = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShortGoalsCompanion(
            id: id,
            title: title,
            longGoalId: longGoalId,
            deadline: deadline,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> longGoalId = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ShortGoalsCompanion.insert(
            id: id,
            title: title,
            longGoalId: longGoalId,
            deadline: deadline,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ShortGoalsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({longGoalId = false, tasksRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (tasksRefs) db.tasks],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (longGoalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.longGoalId,
                    referencedTable:
                        $$ShortGoalsTableReferences._longGoalIdTable(db),
                    referencedColumn:
                        $$ShortGoalsTableReferences._longGoalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (tasksRefs)
                    await $_getPrefetchedData<ShortGoal, $ShortGoalsTable,
                            Task>(
                        currentTable: table,
                        referencedTable:
                            $$ShortGoalsTableReferences._tasksRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ShortGoalsTableReferences(db, table, p0)
                                .tasksRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.shortGoalId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ShortGoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ShortGoalsTable,
    ShortGoal,
    $$ShortGoalsTableFilterComposer,
    $$ShortGoalsTableOrderingComposer,
    $$ShortGoalsTableAnnotationComposer,
    $$ShortGoalsTableCreateCompanionBuilder,
    $$ShortGoalsTableUpdateCompanionBuilder,
    (ShortGoal, $$ShortGoalsTableReferences),
    ShortGoal,
    PrefetchHooks Function({bool longGoalId, bool tasksRefs})>;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  required DateTime dueDate,
  Value<String?> shortGoalId,
  Value<String?> category,
  Value<String?> notes,
  Value<String> status,
  Value<String> priority,
  Value<String?> habitId,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<DateTime> dueDate,
  Value<String?> shortGoalId,
  Value<String?> category,
  Value<String?> notes,
  Value<String> status,
  Value<String> priority,
  Value<String?> habitId,
  Value<DateTime> createdAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ShortGoalsTable _shortGoalIdTable(_$AppDatabase db) =>
      db.shortGoals.createAlias(
          $_aliasNameGenerator(db.tasks.shortGoalId, db.shortGoals.id));

  $$ShortGoalsTableProcessedTableManager? get shortGoalId {
    final $_column = $_itemColumn<String>('short_goal_id');
    if ($_column == null) return null;
    final manager = $$ShortGoalsTableTableManager($_db, $_db.shortGoals)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_shortGoalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnFilters(column));

  $$ShortGoalsTableFilterComposer get shortGoalId {
    final $$ShortGoalsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.shortGoalId,
        referencedTable: $db.shortGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShortGoalsTableFilterComposer(
              $db: $db,
              $table: $db.shortGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get habitId => $composableBuilder(
      column: $table.habitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => ColumnOrderings(column));

  $$ShortGoalsTableOrderingComposer get shortGoalId {
    final $$ShortGoalsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.shortGoalId,
        referencedTable: $db.shortGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShortGoalsTableOrderingComposer(
              $db: $db,
              $table: $db.shortGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
      column: $table.completedAt, builder: (column) => column);

  $$ShortGoalsTableAnnotationComposer get shortGoalId {
    final $$ShortGoalsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.shortGoalId,
        referencedTable: $db.shortGoals,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ShortGoalsTableAnnotationComposer(
              $db: $db,
              $table: $db.shortGoals,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TasksTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool shortGoalId})> {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> dueDate = const Value.absent(),
            Value<String?> shortGoalId = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String?> habitId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            shortGoalId: shortGoalId,
            category: category,
            notes: notes,
            status: status,
            priority: priority,
            habitId: habitId,
            createdAt: createdAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String?> description = const Value.absent(),
            required DateTime dueDate,
            Value<String?> shortGoalId = const Value.absent(),
            Value<String?> category = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<String> priority = const Value.absent(),
            Value<String?> habitId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> completedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TasksCompanion.insert(
            id: id,
            title: title,
            description: description,
            dueDate: dueDate,
            shortGoalId: shortGoalId,
            category: category,
            notes: notes,
            status: status,
            priority: priority,
            habitId: habitId,
            createdAt: createdAt,
            completedAt: completedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$TasksTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({shortGoalId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (shortGoalId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.shortGoalId,
                    referencedTable:
                        $$TasksTableReferences._shortGoalIdTable(db),
                    referencedColumn:
                        $$TasksTableReferences._shortGoalIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TasksTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TasksTable,
    Task,
    $$TasksTableFilterComposer,
    $$TasksTableOrderingComposer,
    $$TasksTableAnnotationComposer,
    $$TasksTableCreateCompanionBuilder,
    $$TasksTableUpdateCompanionBuilder,
    (Task, $$TasksTableReferences),
    Task,
    PrefetchHooks Function({bool shortGoalId})>;
typedef $$TransactionsTableCreateCompanionBuilder = TransactionsCompanion
    Function({
  required String id,
  required String title,
  required double amount,
  required String type,
  required String category,
  Value<String?> notes,
  required DateTime date,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$TransactionsTableUpdateCompanionBuilder = TransactionsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<double> amount,
  Value<String> type,
  Value<String> category,
  Value<String?> notes,
  Value<DateTime> date,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$TransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TransactionsTable> {
  $$TransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TransactionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()> {
  $$TransactionsTableTableManager(_$AppDatabase db, $TransactionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TransactionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TransactionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion(
            id: id,
            title: title,
            amount: amount,
            type: type,
            category: category,
            notes: notes,
            date: date,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required double amount,
            required String type,
            required String category,
            Value<String?> notes = const Value.absent(),
            required DateTime date,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TransactionsCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            type: type,
            category: category,
            notes: notes,
            date: date,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TransactionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TransactionsTable,
    Transaction,
    $$TransactionsTableFilterComposer,
    $$TransactionsTableOrderingComposer,
    $$TransactionsTableAnnotationComposer,
    $$TransactionsTableCreateCompanionBuilder,
    $$TransactionsTableUpdateCompanionBuilder,
    (
      Transaction,
      BaseReferences<_$AppDatabase, $TransactionsTable, Transaction>
    ),
    Transaction,
    PrefetchHooks Function()>;
typedef $$DebtsTableCreateCompanionBuilder = DebtsCompanion Function({
  required String id,
  Value<String?> title,
  required double amount,
  required String person,
  required String direction,
  Value<DateTime?> dueDate,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$DebtsTableUpdateCompanionBuilder = DebtsCompanion Function({
  Value<String> id,
  Value<String?> title,
  Value<double> amount,
  Value<String> person,
  Value<String> direction,
  Value<DateTime?> dueDate,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$DebtsTableFilterComposer extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get person => $composableBuilder(
      column: $table.person, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$DebtsTableOrderingComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get person => $composableBuilder(
      column: $table.person, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
      column: $table.dueDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$DebtsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DebtsTable> {
  $$DebtsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get person =>
      $composableBuilder(column: $table.person, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$DebtsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DebtsTable,
    Debt,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (Debt, BaseReferences<_$AppDatabase, $DebtsTable, Debt>),
    Debt,
    PrefetchHooks Function()> {
  $$DebtsTableTableManager(_$AppDatabase db, $DebtsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DebtsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DebtsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DebtsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> person = const Value.absent(),
            Value<String> direction = const Value.absent(),
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtsCompanion(
            id: id,
            title: title,
            amount: amount,
            person: person,
            direction: direction,
            dueDate: dueDate,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> title = const Value.absent(),
            required double amount,
            required String person,
            required String direction,
            Value<DateTime?> dueDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              DebtsCompanion.insert(
            id: id,
            title: title,
            amount: amount,
            person: person,
            direction: direction,
            dueDate: dueDate,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$DebtsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DebtsTable,
    Debt,
    $$DebtsTableFilterComposer,
    $$DebtsTableOrderingComposer,
    $$DebtsTableAnnotationComposer,
    $$DebtsTableCreateCompanionBuilder,
    $$DebtsTableUpdateCompanionBuilder,
    (Debt, BaseReferences<_$AppDatabase, $DebtsTable, Debt>),
    Debt,
    PrefetchHooks Function()>;
typedef $$FinancialGoalsTableCreateCompanionBuilder = FinancialGoalsCompanion
    Function({
  required String id,
  required String title,
  required double targetAmount,
  Value<double> currentAmount,
  Value<DateTime?> deadline,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$FinancialGoalsTableUpdateCompanionBuilder = FinancialGoalsCompanion
    Function({
  Value<String> id,
  Value<String> title,
  Value<double> targetAmount,
  Value<double> currentAmount,
  Value<DateTime?> deadline,
  Value<String?> notes,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$FinancialGoalsTableFilterComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$FinancialGoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deadline => $composableBuilder(
      column: $table.deadline, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$FinancialGoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinancialGoalsTable> {
  $$FinancialGoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<double> get targetAmount => $composableBuilder(
      column: $table.targetAmount, builder: (column) => column);

  GeneratedColumn<double> get currentAmount => $composableBuilder(
      column: $table.currentAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FinancialGoalsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FinancialGoalsTable,
    FinancialGoal,
    $$FinancialGoalsTableFilterComposer,
    $$FinancialGoalsTableOrderingComposer,
    $$FinancialGoalsTableAnnotationComposer,
    $$FinancialGoalsTableCreateCompanionBuilder,
    $$FinancialGoalsTableUpdateCompanionBuilder,
    (
      FinancialGoal,
      BaseReferences<_$AppDatabase, $FinancialGoalsTable, FinancialGoal>
    ),
    FinancialGoal,
    PrefetchHooks Function()> {
  $$FinancialGoalsTableTableManager(
      _$AppDatabase db, $FinancialGoalsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinancialGoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinancialGoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FinancialGoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<double> targetAmount = const Value.absent(),
            Value<double> currentAmount = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialGoalsCompanion(
            id: id,
            title: title,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            deadline: deadline,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required double targetAmount,
            Value<double> currentAmount = const Value.absent(),
            Value<DateTime?> deadline = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FinancialGoalsCompanion.insert(
            id: id,
            title: title,
            targetAmount: targetAmount,
            currentAmount: currentAmount,
            deadline: deadline,
            notes: notes,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FinancialGoalsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FinancialGoalsTable,
    FinancialGoal,
    $$FinancialGoalsTableFilterComposer,
    $$FinancialGoalsTableOrderingComposer,
    $$FinancialGoalsTableAnnotationComposer,
    $$FinancialGoalsTableCreateCompanionBuilder,
    $$FinancialGoalsTableUpdateCompanionBuilder,
    (
      FinancialGoal,
      BaseReferences<_$AppDatabase, $FinancialGoalsTable, FinancialGoal>
    ),
    FinancialGoal,
    PrefetchHooks Function()>;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String title,
  Value<String> emoji,
  Value<String> timeOfDay,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> emoji,
  Value<String> timeOfDay,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
      _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
          db.habitLogs,
          aliasName: $_aliasNameGenerator(db.habits.id, db.habitLogs.habitId));

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager($_db, $_db.habitLogs)
        .filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> habitLogsRefs(
      Expression<bool> Function($$HabitLogsTableFilterComposer f) f) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitLogs,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitLogsTableFilterComposer(
              $db: $db,
              $table: $db.habitLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get timeOfDay => $composableBuilder(
      column: $table.timeOfDay, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<String> get timeOfDay =>
      $composableBuilder(column: $table.timeOfDay, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitLogsRefs<T extends Object>(
      Expression<T> Function($$HabitLogsTableAnnotationComposer a) f) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.habitLogs,
        getReferencedColumn: (t) => t.habitId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.habitLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$HabitsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool habitLogsRefs})> {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> emoji = const Value.absent(),
            Value<String> timeOfDay = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion(
            id: id,
            title: title,
            emoji: emoji,
            timeOfDay: timeOfDay,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            Value<String> emoji = const Value.absent(),
            Value<String> timeOfDay = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitsCompanion.insert(
            id: id,
            title: title,
            emoji: emoji,
            timeOfDay: timeOfDay,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$HabitsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({habitLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (habitLogsRefs) db.habitLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (habitLogsRefs)
                    await $_getPrefetchedData<Habit, $HabitsTable, HabitLog>(
                        currentTable: table,
                        referencedTable:
                            $$HabitsTableReferences._habitLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$HabitsTableReferences(db, table, p0)
                                .habitLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.habitId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$HabitsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitsTable,
    Habit,
    $$HabitsTableFilterComposer,
    $$HabitsTableOrderingComposer,
    $$HabitsTableAnnotationComposer,
    $$HabitsTableCreateCompanionBuilder,
    $$HabitsTableUpdateCompanionBuilder,
    (Habit, $$HabitsTableReferences),
    Habit,
    PrefetchHooks Function({bool habitLogsRefs})>;
typedef $$HabitLogsTableCreateCompanionBuilder = HabitLogsCompanion Function({
  required String id,
  required String habitId,
  required DateTime date,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$HabitLogsTableUpdateCompanionBuilder = HabitLogsCompanion Function({
  Value<String> id,
  Value<String> habitId,
  Value<DateTime> date,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) => db.habits
      .createAlias($_aliasNameGenerator(db.habitLogs.habitId, db.habits.id));

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager($_db, $_db.habits)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableFilterComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableOrderingComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.habitId,
        referencedTable: $db.habits,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$HabitsTableAnnotationComposer(
              $db: $db,
              $table: $db.habits,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$HabitLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, $$HabitLogsTableReferences),
    HabitLog,
    PrefetchHooks Function({bool habitId})> {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> habitId = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitLogsCompanion(
            id: id,
            habitId: habitId,
            date: date,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String habitId,
            required DateTime date,
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              HabitLogsCompanion.insert(
            id: id,
            habitId: habitId,
            date: date,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$HabitLogsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (habitId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.habitId,
                    referencedTable:
                        $$HabitLogsTableReferences._habitIdTable(db),
                    referencedColumn:
                        $$HabitLogsTableReferences._habitIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$HabitLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $HabitLogsTable,
    HabitLog,
    $$HabitLogsTableFilterComposer,
    $$HabitLogsTableOrderingComposer,
    $$HabitLogsTableAnnotationComposer,
    $$HabitLogsTableCreateCompanionBuilder,
    $$HabitLogsTableUpdateCompanionBuilder,
    (HabitLog, $$HabitLogsTableReferences),
    HabitLog,
    PrefetchHooks Function({bool habitId})>;
typedef $$TimeLogsTableCreateCompanionBuilder = TimeLogsCompanion Function({
  required String id,
  required String category,
  Value<String?> taskId,
  required int durationSeconds,
  Value<String?> notes,
  required DateTime startedAt,
  required DateTime endedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$TimeLogsTableUpdateCompanionBuilder = TimeLogsCompanion Function({
  Value<String> id,
  Value<String> category,
  Value<String?> taskId,
  Value<int> durationSeconds,
  Value<String?> notes,
  Value<DateTime> startedAt,
  Value<DateTime> endedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$TimeLogsTableFilterComposer
    extends Composer<_$AppDatabase, $TimeLogsTable> {
  $$TimeLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$TimeLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $TimeLogsTable> {
  $$TimeLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taskId => $composableBuilder(
      column: $table.taskId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startedAt => $composableBuilder(
      column: $table.startedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endedAt => $composableBuilder(
      column: $table.endedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$TimeLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TimeLogsTable> {
  $$TimeLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get taskId =>
      $composableBuilder(column: $table.taskId, builder: (column) => column);

  GeneratedColumn<int> get durationSeconds => $composableBuilder(
      column: $table.durationSeconds, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get startedAt =>
      $composableBuilder(column: $table.startedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get endedAt =>
      $composableBuilder(column: $table.endedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$TimeLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TimeLogsTable,
    TimeLog,
    $$TimeLogsTableFilterComposer,
    $$TimeLogsTableOrderingComposer,
    $$TimeLogsTableAnnotationComposer,
    $$TimeLogsTableCreateCompanionBuilder,
    $$TimeLogsTableUpdateCompanionBuilder,
    (TimeLog, BaseReferences<_$AppDatabase, $TimeLogsTable, TimeLog>),
    TimeLog,
    PrefetchHooks Function()> {
  $$TimeLogsTableTableManager(_$AppDatabase db, $TimeLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TimeLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TimeLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TimeLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String?> taskId = const Value.absent(),
            Value<int> durationSeconds = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> startedAt = const Value.absent(),
            Value<DateTime> endedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeLogsCompanion(
            id: id,
            category: category,
            taskId: taskId,
            durationSeconds: durationSeconds,
            notes: notes,
            startedAt: startedAt,
            endedAt: endedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String category,
            Value<String?> taskId = const Value.absent(),
            required int durationSeconds,
            Value<String?> notes = const Value.absent(),
            required DateTime startedAt,
            required DateTime endedAt,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              TimeLogsCompanion.insert(
            id: id,
            category: category,
            taskId: taskId,
            durationSeconds: durationSeconds,
            notes: notes,
            startedAt: startedAt,
            endedAt: endedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$TimeLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TimeLogsTable,
    TimeLog,
    $$TimeLogsTableFilterComposer,
    $$TimeLogsTableOrderingComposer,
    $$TimeLogsTableAnnotationComposer,
    $$TimeLogsTableCreateCompanionBuilder,
    $$TimeLogsTableUpdateCompanionBuilder,
    (TimeLog, BaseReferences<_$AppDatabase, $TimeLogsTable, TimeLog>),
    TimeLog,
    PrefetchHooks Function()>;
typedef $$KpisTableCreateCompanionBuilder = KpisCompanion Function({
  required String id,
  required String title,
  required String unit,
  Value<String> emoji,
  Value<String> direction,
  Value<double?> targetValue,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$KpisTableUpdateCompanionBuilder = KpisCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String> unit,
  Value<String> emoji,
  Value<String> direction,
  Value<double?> targetValue,
  Value<String> status,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$KpisTableReferences
    extends BaseReferences<_$AppDatabase, $KpisTable, Kpi> {
  $$KpisTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$KpiLogsTable, List<KpiLog>> _kpiLogsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.kpiLogs,
          aliasName: $_aliasNameGenerator(db.kpis.id, db.kpiLogs.kpiId));

  $$KpiLogsTableProcessedTableManager get kpiLogsRefs {
    final manager = $$KpiLogsTableTableManager($_db, $_db.kpiLogs)
        .filter((f) => f.kpiId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_kpiLogsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$KpisTableFilterComposer extends Composer<_$AppDatabase, $KpisTable> {
  $$KpisTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  Expression<bool> kpiLogsRefs(
      Expression<bool> Function($$KpiLogsTableFilterComposer f) f) {
    final $$KpiLogsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kpiLogs,
        getReferencedColumn: (t) => t.kpiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KpiLogsTableFilterComposer(
              $db: $db,
              $table: $db.kpiLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KpisTableOrderingComposer extends Composer<_$AppDatabase, $KpisTable> {
  $$KpisTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get emoji => $composableBuilder(
      column: $table.emoji, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get direction => $composableBuilder(
      column: $table.direction, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$KpisTableAnnotationComposer
    extends Composer<_$AppDatabase, $KpisTable> {
  $$KpisTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get emoji =>
      $composableBuilder(column: $table.emoji, builder: (column) => column);

  GeneratedColumn<String> get direction =>
      $composableBuilder(column: $table.direction, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
      column: $table.targetValue, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> kpiLogsRefs<T extends Object>(
      Expression<T> Function($$KpiLogsTableAnnotationComposer a) f) {
    final $$KpiLogsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.kpiLogs,
        getReferencedColumn: (t) => t.kpiId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KpiLogsTableAnnotationComposer(
              $db: $db,
              $table: $db.kpiLogs,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$KpisTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KpisTable,
    Kpi,
    $$KpisTableFilterComposer,
    $$KpisTableOrderingComposer,
    $$KpisTableAnnotationComposer,
    $$KpisTableCreateCompanionBuilder,
    $$KpisTableUpdateCompanionBuilder,
    (Kpi, $$KpisTableReferences),
    Kpi,
    PrefetchHooks Function({bool kpiLogsRefs})> {
  $$KpisTableTableManager(_$AppDatabase db, $KpisTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KpisTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KpisTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KpisTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> unit = const Value.absent(),
            Value<String> emoji = const Value.absent(),
            Value<String> direction = const Value.absent(),
            Value<double?> targetValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KpisCompanion(
            id: id,
            title: title,
            unit: unit,
            emoji: emoji,
            direction: direction,
            targetValue: targetValue,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String title,
            required String unit,
            Value<String> emoji = const Value.absent(),
            Value<String> direction = const Value.absent(),
            Value<double?> targetValue = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KpisCompanion.insert(
            id: id,
            title: title,
            unit: unit,
            emoji: emoji,
            direction: direction,
            targetValue: targetValue,
            status: status,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$KpisTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({kpiLogsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (kpiLogsRefs) db.kpiLogs],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (kpiLogsRefs)
                    await $_getPrefetchedData<Kpi, $KpisTable, KpiLog>(
                        currentTable: table,
                        referencedTable:
                            $$KpisTableReferences._kpiLogsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$KpisTableReferences(db, table, p0).kpiLogsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.kpiId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$KpisTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KpisTable,
    Kpi,
    $$KpisTableFilterComposer,
    $$KpisTableOrderingComposer,
    $$KpisTableAnnotationComposer,
    $$KpisTableCreateCompanionBuilder,
    $$KpisTableUpdateCompanionBuilder,
    (Kpi, $$KpisTableReferences),
    Kpi,
    PrefetchHooks Function({bool kpiLogsRefs})>;
typedef $$KpiLogsTableCreateCompanionBuilder = KpiLogsCompanion Function({
  required String id,
  required String kpiId,
  required double value,
  required DateTime date,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$KpiLogsTableUpdateCompanionBuilder = KpiLogsCompanion Function({
  Value<String> id,
  Value<String> kpiId,
  Value<double> value,
  Value<DateTime> date,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$KpiLogsTableReferences
    extends BaseReferences<_$AppDatabase, $KpiLogsTable, KpiLog> {
  $$KpiLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $KpisTable _kpiIdTable(_$AppDatabase db) =>
      db.kpis.createAlias($_aliasNameGenerator(db.kpiLogs.kpiId, db.kpis.id));

  $$KpisTableProcessedTableManager get kpiId {
    final $_column = $_itemColumn<String>('kpi_id')!;

    final manager = $$KpisTableTableManager($_db, $_db.kpis)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_kpiIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$KpiLogsTableFilterComposer
    extends Composer<_$AppDatabase, $KpiLogsTable> {
  $$KpiLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$KpisTableFilterComposer get kpiId {
    final $$KpisTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kpiId,
        referencedTable: $db.kpis,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KpisTableFilterComposer(
              $db: $db,
              $table: $db.kpis,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KpiLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $KpiLogsTable> {
  $$KpiLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get value => $composableBuilder(
      column: $table.value, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$KpisTableOrderingComposer get kpiId {
    final $$KpisTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kpiId,
        referencedTable: $db.kpis,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KpisTableOrderingComposer(
              $db: $db,
              $table: $db.kpis,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KpiLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $KpiLogsTable> {
  $$KpiLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$KpisTableAnnotationComposer get kpiId {
    final $$KpisTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.kpiId,
        referencedTable: $db.kpis,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$KpisTableAnnotationComposer(
              $db: $db,
              $table: $db.kpis,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$KpiLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $KpiLogsTable,
    KpiLog,
    $$KpiLogsTableFilterComposer,
    $$KpiLogsTableOrderingComposer,
    $$KpiLogsTableAnnotationComposer,
    $$KpiLogsTableCreateCompanionBuilder,
    $$KpiLogsTableUpdateCompanionBuilder,
    (KpiLog, $$KpiLogsTableReferences),
    KpiLog,
    PrefetchHooks Function({bool kpiId})> {
  $$KpiLogsTableTableManager(_$AppDatabase db, $KpiLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$KpiLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$KpiLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$KpiLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> kpiId = const Value.absent(),
            Value<double> value = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KpiLogsCompanion(
            id: id,
            kpiId: kpiId,
            value: value,
            date: date,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String kpiId,
            required double value,
            required DateTime date,
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              KpiLogsCompanion.insert(
            id: id,
            kpiId: kpiId,
            value: value,
            date: date,
            notes: notes,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$KpiLogsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: ({kpiId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (kpiId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.kpiId,
                    referencedTable: $$KpiLogsTableReferences._kpiIdTable(db),
                    referencedColumn:
                        $$KpiLogsTableReferences._kpiIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$KpiLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $KpiLogsTable,
    KpiLog,
    $$KpiLogsTableFilterComposer,
    $$KpiLogsTableOrderingComposer,
    $$KpiLogsTableAnnotationComposer,
    $$KpiLogsTableCreateCompanionBuilder,
    $$KpiLogsTableUpdateCompanionBuilder,
    (KpiLog, $$KpiLogsTableReferences),
    KpiLog,
    PrefetchHooks Function({bool kpiId})>;
typedef $$WeeklyReviewsTableCreateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  required String id,
  required DateTime weekStart,
  Value<int> completedTasks,
  Value<int> totalTasks,
  Value<double> habitSuccessRate,
  Value<int> totalMinutes,
  Value<int> deepWorkMinutes,
  Value<double> income,
  Value<double> expense,
  Value<int> activeGoalsCount,
  Value<int> completedGoalsCount,
  Value<String?> answeredWorked,
  Value<String?> answeredFailed,
  Value<String?> answeredLearned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$WeeklyReviewsTableUpdateCompanionBuilder = WeeklyReviewsCompanion
    Function({
  Value<String> id,
  Value<DateTime> weekStart,
  Value<int> completedTasks,
  Value<int> totalTasks,
  Value<double> habitSuccessRate,
  Value<int> totalMinutes,
  Value<int> deepWorkMinutes,
  Value<double> income,
  Value<double> expense,
  Value<int> activeGoalsCount,
  Value<int> completedGoalsCount,
  Value<String?> answeredWorked,
  Value<String?> answeredFailed,
  Value<String?> answeredLearned,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$WeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedTasks => $composableBuilder(
      column: $table.completedTasks,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalTasks => $composableBuilder(
      column: $table.totalTasks, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get habitSuccessRate => $composableBuilder(
      column: $table.habitSuccessRate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalMinutes => $composableBuilder(
      column: $table.totalMinutes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get deepWorkMinutes => $composableBuilder(
      column: $table.deepWorkMinutes,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get income => $composableBuilder(
      column: $table.income, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get expense => $composableBuilder(
      column: $table.expense, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get activeGoalsCount => $composableBuilder(
      column: $table.activeGoalsCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get completedGoalsCount => $composableBuilder(
      column: $table.completedGoalsCount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredWorked => $composableBuilder(
      column: $table.answeredWorked,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredFailed => $composableBuilder(
      column: $table.answeredFailed,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredLearned => $composableBuilder(
      column: $table.answeredLearned,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$WeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get weekStart => $composableBuilder(
      column: $table.weekStart, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedTasks => $composableBuilder(
      column: $table.completedTasks,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalTasks => $composableBuilder(
      column: $table.totalTasks, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get habitSuccessRate => $composableBuilder(
      column: $table.habitSuccessRate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalMinutes => $composableBuilder(
      column: $table.totalMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get deepWorkMinutes => $composableBuilder(
      column: $table.deepWorkMinutes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get income => $composableBuilder(
      column: $table.income, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get expense => $composableBuilder(
      column: $table.expense, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get activeGoalsCount => $composableBuilder(
      column: $table.activeGoalsCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get completedGoalsCount => $composableBuilder(
      column: $table.completedGoalsCount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredWorked => $composableBuilder(
      column: $table.answeredWorked,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredFailed => $composableBuilder(
      column: $table.answeredFailed,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredLearned => $composableBuilder(
      column: $table.answeredLearned,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$WeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<int> get completedTasks => $composableBuilder(
      column: $table.completedTasks, builder: (column) => column);

  GeneratedColumn<int> get totalTasks => $composableBuilder(
      column: $table.totalTasks, builder: (column) => column);

  GeneratedColumn<double> get habitSuccessRate => $composableBuilder(
      column: $table.habitSuccessRate, builder: (column) => column);

  GeneratedColumn<int> get totalMinutes => $composableBuilder(
      column: $table.totalMinutes, builder: (column) => column);

  GeneratedColumn<int> get deepWorkMinutes => $composableBuilder(
      column: $table.deepWorkMinutes, builder: (column) => column);

  GeneratedColumn<double> get income =>
      $composableBuilder(column: $table.income, builder: (column) => column);

  GeneratedColumn<double> get expense =>
      $composableBuilder(column: $table.expense, builder: (column) => column);

  GeneratedColumn<int> get activeGoalsCount => $composableBuilder(
      column: $table.activeGoalsCount, builder: (column) => column);

  GeneratedColumn<int> get completedGoalsCount => $composableBuilder(
      column: $table.completedGoalsCount, builder: (column) => column);

  GeneratedColumn<String> get answeredWorked => $composableBuilder(
      column: $table.answeredWorked, builder: (column) => column);

  GeneratedColumn<String> get answeredFailed => $composableBuilder(
      column: $table.answeredFailed, builder: (column) => column);

  GeneratedColumn<String> get answeredLearned => $composableBuilder(
      column: $table.answeredLearned, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$WeeklyReviewsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeeklyReviewsTable,
    WeeklyReview,
    $$WeeklyReviewsTableFilterComposer,
    $$WeeklyReviewsTableOrderingComposer,
    $$WeeklyReviewsTableAnnotationComposer,
    $$WeeklyReviewsTableCreateCompanionBuilder,
    $$WeeklyReviewsTableUpdateCompanionBuilder,
    (
      WeeklyReview,
      BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>
    ),
    WeeklyReview,
    PrefetchHooks Function()> {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<DateTime> weekStart = const Value.absent(),
            Value<int> completedTasks = const Value.absent(),
            Value<int> totalTasks = const Value.absent(),
            Value<double> habitSuccessRate = const Value.absent(),
            Value<int> totalMinutes = const Value.absent(),
            Value<int> deepWorkMinutes = const Value.absent(),
            Value<double> income = const Value.absent(),
            Value<double> expense = const Value.absent(),
            Value<int> activeGoalsCount = const Value.absent(),
            Value<int> completedGoalsCount = const Value.absent(),
            Value<String?> answeredWorked = const Value.absent(),
            Value<String?> answeredFailed = const Value.absent(),
            Value<String?> answeredLearned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion(
            id: id,
            weekStart: weekStart,
            completedTasks: completedTasks,
            totalTasks: totalTasks,
            habitSuccessRate: habitSuccessRate,
            totalMinutes: totalMinutes,
            deepWorkMinutes: deepWorkMinutes,
            income: income,
            expense: expense,
            activeGoalsCount: activeGoalsCount,
            completedGoalsCount: completedGoalsCount,
            answeredWorked: answeredWorked,
            answeredFailed: answeredFailed,
            answeredLearned: answeredLearned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required DateTime weekStart,
            Value<int> completedTasks = const Value.absent(),
            Value<int> totalTasks = const Value.absent(),
            Value<double> habitSuccessRate = const Value.absent(),
            Value<int> totalMinutes = const Value.absent(),
            Value<int> deepWorkMinutes = const Value.absent(),
            Value<double> income = const Value.absent(),
            Value<double> expense = const Value.absent(),
            Value<int> activeGoalsCount = const Value.absent(),
            Value<int> completedGoalsCount = const Value.absent(),
            Value<String?> answeredWorked = const Value.absent(),
            Value<String?> answeredFailed = const Value.absent(),
            Value<String?> answeredLearned = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeeklyReviewsCompanion.insert(
            id: id,
            weekStart: weekStart,
            completedTasks: completedTasks,
            totalTasks: totalTasks,
            habitSuccessRate: habitSuccessRate,
            totalMinutes: totalMinutes,
            deepWorkMinutes: deepWorkMinutes,
            income: income,
            expense: expense,
            activeGoalsCount: activeGoalsCount,
            completedGoalsCount: completedGoalsCount,
            answeredWorked: answeredWorked,
            answeredFailed: answeredFailed,
            answeredLearned: answeredLearned,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeeklyReviewsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeeklyReviewsTable,
    WeeklyReview,
    $$WeeklyReviewsTableFilterComposer,
    $$WeeklyReviewsTableOrderingComposer,
    $$WeeklyReviewsTableAnnotationComposer,
    $$WeeklyReviewsTableCreateCompanionBuilder,
    $$WeeklyReviewsTableUpdateCompanionBuilder,
    (
      WeeklyReview,
      BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>
    ),
    WeeklyReview,
    PrefetchHooks Function()>;
typedef $$MonthlyReflectionsTableCreateCompanionBuilder
    = MonthlyReflectionsCompanion Function({
  required String id,
  required int year,
  required int month,
  Value<String?> answeredContinue,
  Value<String?> answeredStop,
  Value<String?> answeredStart,
  Value<String?> answeredProud,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$MonthlyReflectionsTableUpdateCompanionBuilder
    = MonthlyReflectionsCompanion Function({
  Value<String> id,
  Value<int> year,
  Value<int> month,
  Value<String?> answeredContinue,
  Value<String?> answeredStop,
  Value<String?> answeredStart,
  Value<String?> answeredProud,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$MonthlyReflectionsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyReflectionsTable> {
  $$MonthlyReflectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredContinue => $composableBuilder(
      column: $table.answeredContinue,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredStop => $composableBuilder(
      column: $table.answeredStop, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredStart => $composableBuilder(
      column: $table.answeredStart, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get answeredProud => $composableBuilder(
      column: $table.answeredProud, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$MonthlyReflectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyReflectionsTable> {
  $$MonthlyReflectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get year => $composableBuilder(
      column: $table.year, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get month => $composableBuilder(
      column: $table.month, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredContinue => $composableBuilder(
      column: $table.answeredContinue,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredStop => $composableBuilder(
      column: $table.answeredStop,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredStart => $composableBuilder(
      column: $table.answeredStart,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get answeredProud => $composableBuilder(
      column: $table.answeredProud,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$MonthlyReflectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyReflectionsTable> {
  $$MonthlyReflectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get year =>
      $composableBuilder(column: $table.year, builder: (column) => column);

  GeneratedColumn<int> get month =>
      $composableBuilder(column: $table.month, builder: (column) => column);

  GeneratedColumn<String> get answeredContinue => $composableBuilder(
      column: $table.answeredContinue, builder: (column) => column);

  GeneratedColumn<String> get answeredStop => $composableBuilder(
      column: $table.answeredStop, builder: (column) => column);

  GeneratedColumn<String> get answeredStart => $composableBuilder(
      column: $table.answeredStart, builder: (column) => column);

  GeneratedColumn<String> get answeredProud => $composableBuilder(
      column: $table.answeredProud, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MonthlyReflectionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MonthlyReflectionsTable,
    MonthlyReflection,
    $$MonthlyReflectionsTableFilterComposer,
    $$MonthlyReflectionsTableOrderingComposer,
    $$MonthlyReflectionsTableAnnotationComposer,
    $$MonthlyReflectionsTableCreateCompanionBuilder,
    $$MonthlyReflectionsTableUpdateCompanionBuilder,
    (
      MonthlyReflection,
      BaseReferences<_$AppDatabase, $MonthlyReflectionsTable, MonthlyReflection>
    ),
    MonthlyReflection,
    PrefetchHooks Function()> {
  $$MonthlyReflectionsTableTableManager(
      _$AppDatabase db, $MonthlyReflectionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyReflectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyReflectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyReflectionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<int> year = const Value.absent(),
            Value<int> month = const Value.absent(),
            Value<String?> answeredContinue = const Value.absent(),
            Value<String?> answeredStop = const Value.absent(),
            Value<String?> answeredStart = const Value.absent(),
            Value<String?> answeredProud = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyReflectionsCompanion(
            id: id,
            year: year,
            month: month,
            answeredContinue: answeredContinue,
            answeredStop: answeredStop,
            answeredStart: answeredStart,
            answeredProud: answeredProud,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required int year,
            required int month,
            Value<String?> answeredContinue = const Value.absent(),
            Value<String?> answeredStop = const Value.absent(),
            Value<String?> answeredStart = const Value.absent(),
            Value<String?> answeredProud = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MonthlyReflectionsCompanion.insert(
            id: id,
            year: year,
            month: month,
            answeredContinue: answeredContinue,
            answeredStop: answeredStop,
            answeredStart: answeredStart,
            answeredProud: answeredProud,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MonthlyReflectionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MonthlyReflectionsTable,
    MonthlyReflection,
    $$MonthlyReflectionsTableFilterComposer,
    $$MonthlyReflectionsTableOrderingComposer,
    $$MonthlyReflectionsTableAnnotationComposer,
    $$MonthlyReflectionsTableCreateCompanionBuilder,
    $$MonthlyReflectionsTableUpdateCompanionBuilder,
    (
      MonthlyReflection,
      BaseReferences<_$AppDatabase, $MonthlyReflectionsTable, MonthlyReflection>
    ),
    MonthlyReflection,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LongGoalsTableTableManager get longGoals =>
      $$LongGoalsTableTableManager(_db, _db.longGoals);
  $$ShortGoalsTableTableManager get shortGoals =>
      $$ShortGoalsTableTableManager(_db, _db.shortGoals);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TransactionsTableTableManager get transactions =>
      $$TransactionsTableTableManager(_db, _db.transactions);
  $$DebtsTableTableManager get debts =>
      $$DebtsTableTableManager(_db, _db.debts);
  $$FinancialGoalsTableTableManager get financialGoals =>
      $$FinancialGoalsTableTableManager(_db, _db.financialGoals);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$TimeLogsTableTableManager get timeLogs =>
      $$TimeLogsTableTableManager(_db, _db.timeLogs);
  $$KpisTableTableManager get kpis => $$KpisTableTableManager(_db, _db.kpis);
  $$KpiLogsTableTableManager get kpiLogs =>
      $$KpiLogsTableTableManager(_db, _db.kpiLogs);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$MonthlyReflectionsTableTableManager get monthlyReflections =>
      $$MonthlyReflectionsTableTableManager(_db, _db.monthlyReflections);
}
