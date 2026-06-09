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
  int get hashCode => Object.hash(id, title, dueDate, shortGoalId, category,
      notes, status, priority, habitId, createdAt, completedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.title == this.title &&
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

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LongGoalsTable longGoals = $LongGoalsTable(this);
  late final $ShortGoalsTable shortGoals = $ShortGoalsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $TimeLogsTable timeLogs = $TimeLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [longGoals, shortGoals, tasks, timeLogs];
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

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LongGoalsTableTableManager get longGoals =>
      $$LongGoalsTableTableManager(_db, _db.longGoals);
  $$ShortGoalsTableTableManager get shortGoals =>
      $$ShortGoalsTableTableManager(_db, _db.shortGoals);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$TimeLogsTableTableManager get timeLogs =>
      $$TimeLogsTableTableManager(_db, _db.timeLogs);
}
