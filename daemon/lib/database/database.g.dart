// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StationTableTable extends StationTable
    with TableInfo<$StationTableTable, StationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    createdAt,
    longitude,
    latitude,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'station_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<StationTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_longitudeMeta);
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    } else if (isInserting) {
      context.missing(_latitudeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StationTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      )!,
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      )!,
    );
  }

  @override
  $StationTableTable createAlias(String alias) {
    return $StationTableTable(attachedDatabase, alias);
  }
}

class StationTableData extends DataClass
    implements Insertable<StationTableData> {
  final int id;
  final String name;
  final DateTime createdAt;
  final double longitude;
  final double latitude;
  const StationTableData({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.longitude,
    required this.latitude,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['longitude'] = Variable<double>(longitude);
    map['latitude'] = Variable<double>(latitude);
    return map;
  }

  StationTableCompanion toCompanion(bool nullToAbsent) {
    return StationTableCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      longitude: Value(longitude),
      latitude: Value(latitude),
    );
  }

  factory StationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StationTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      longitude: serializer.fromJson<double>(json['longitude']),
      latitude: serializer.fromJson<double>(json['latitude']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'longitude': serializer.toJson<double>(longitude),
      'latitude': serializer.toJson<double>(latitude),
    };
  }

  StationTableData copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    double? longitude,
    double? latitude,
  }) => StationTableData(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    longitude: longitude ?? this.longitude,
    latitude: latitude ?? this.latitude,
  );
  StationTableData copyWithCompanion(StationTableCompanion data) {
    return StationTableData(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StationTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, longitude, latitude);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StationTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude);
}

class StationTableCompanion extends UpdateCompanion<StationTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<double> longitude;
  final Value<double> latitude;
  const StationTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
  });
  StationTableCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required DateTime createdAt,
    required double longitude,
    required double latitude,
  }) : name = Value(name),
       createdAt = Value(createdAt),
       longitude = Value(longitude),
       latitude = Value(latitude);
  static Insertable<StationTableData> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<double>? longitude,
    Expression<double>? latitude,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
    });
  }

  StationTableCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<double>? longitude,
    Value<double>? latitude,
  }) {
    return StationTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StationTableCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude')
          ..write(')'))
        .toString();
  }
}

class $SensorTableTable extends SensorTable
    with TableInfo<$SensorTableTable, SensorTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SensorTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _stationIdMeta = const VerificationMeta(
    'stationId',
  );
  @override
  late final GeneratedColumn<int> stationId = GeneratedColumn<int>(
    'station_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES station_table (id) ON UPDATE CASCADE ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SensorElement, String> element =
      GeneratedColumn<String>(
        'element',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<SensorElement>($SensorTableTable.$converterelement);
  static const VerificationMeta _storageUnitIdMeta = const VerificationMeta(
    'storageUnitId',
  );
  @override
  late final GeneratedColumn<String> storageUnitId = GeneratedColumn<String>(
    'storage_unit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordIntervalSecondsMeta =
      const VerificationMeta('recordIntervalSeconds');
  @override
  late final GeneratedColumn<int> recordIntervalSeconds = GeneratedColumn<int>(
    'record_interval_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationId,
    element,
    storageUnitId,
    name,
    recordIntervalSeconds,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sensor_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<SensorTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('station_id')) {
      context.handle(
        _stationIdMeta,
        stationId.isAcceptableOrUnknown(data['station_id']!, _stationIdMeta),
      );
    } else if (isInserting) {
      context.missing(_stationIdMeta);
    }
    if (data.containsKey('storage_unit_id')) {
      context.handle(
        _storageUnitIdMeta,
        storageUnitId.isAcceptableOrUnknown(
          data['storage_unit_id']!,
          _storageUnitIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_storageUnitIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('record_interval_seconds')) {
      context.handle(
        _recordIntervalSecondsMeta,
        recordIntervalSeconds.isAcceptableOrUnknown(
          data['record_interval_seconds']!,
          _recordIntervalSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationId, name},
  ];
  @override
  SensorTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensorTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}station_id'],
      )!,
      element: $SensorTableTable.$converterelement.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}element'],
        )!,
      ),
      storageUnitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}storage_unit_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      recordIntervalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}record_interval_seconds'],
      )!,
    );
  }

  @override
  $SensorTableTable createAlias(String alias) {
    return $SensorTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SensorElement, String, String> $converterelement =
      const EnumNameConverter<SensorElement>(SensorElement.values);
}

class SensorTableData extends DataClass implements Insertable<SensorTableData> {
  final int id;
  final int stationId;
  final SensorElement element;
  final String storageUnitId;
  final String name;
  final int recordIntervalSeconds;
  const SensorTableData({
    required this.id,
    required this.stationId,
    required this.element,
    required this.storageUnitId,
    required this.name,
    required this.recordIntervalSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_id'] = Variable<int>(stationId);
    {
      map['element'] = Variable<String>(
        $SensorTableTable.$converterelement.toSql(element),
      );
    }
    map['storage_unit_id'] = Variable<String>(storageUnitId);
    map['name'] = Variable<String>(name);
    map['record_interval_seconds'] = Variable<int>(recordIntervalSeconds);
    return map;
  }

  SensorTableCompanion toCompanion(bool nullToAbsent) {
    return SensorTableCompanion(
      id: Value(id),
      stationId: Value(stationId),
      element: Value(element),
      storageUnitId: Value(storageUnitId),
      name: Value(name),
      recordIntervalSeconds: Value(recordIntervalSeconds),
    );
  }

  factory SensorTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensorTableData(
      id: serializer.fromJson<int>(json['id']),
      stationId: serializer.fromJson<int>(json['stationId']),
      element: $SensorTableTable.$converterelement.fromJson(
        serializer.fromJson<String>(json['element']),
      ),
      storageUnitId: serializer.fromJson<String>(json['storageUnitId']),
      name: serializer.fromJson<String>(json['name']),
      recordIntervalSeconds: serializer.fromJson<int>(
        json['recordIntervalSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationId': serializer.toJson<int>(stationId),
      'element': serializer.toJson<String>(
        $SensorTableTable.$converterelement.toJson(element),
      ),
      'storageUnitId': serializer.toJson<String>(storageUnitId),
      'name': serializer.toJson<String>(name),
      'recordIntervalSeconds': serializer.toJson<int>(recordIntervalSeconds),
    };
  }

  SensorTableData copyWith({
    int? id,
    int? stationId,
    SensorElement? element,
    String? storageUnitId,
    String? name,
    int? recordIntervalSeconds,
  }) => SensorTableData(
    id: id ?? this.id,
    stationId: stationId ?? this.stationId,
    element: element ?? this.element,
    storageUnitId: storageUnitId ?? this.storageUnitId,
    name: name ?? this.name,
    recordIntervalSeconds: recordIntervalSeconds ?? this.recordIntervalSeconds,
  );
  SensorTableData copyWithCompanion(SensorTableCompanion data) {
    return SensorTableData(
      id: data.id.present ? data.id.value : this.id,
      stationId: data.stationId.present ? data.stationId.value : this.stationId,
      element: data.element.present ? data.element.value : this.element,
      storageUnitId: data.storageUnitId.present
          ? data.storageUnitId.value
          : this.storageUnitId,
      name: data.name.present ? data.name.value : this.name,
      recordIntervalSeconds: data.recordIntervalSeconds.present
          ? data.recordIntervalSeconds.value
          : this.recordIntervalSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SensorTableData(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('element: $element, ')
          ..write('storageUnitId: $storageUnitId, ')
          ..write('name: $name, ')
          ..write('recordIntervalSeconds: $recordIntervalSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stationId,
    element,
    storageUnitId,
    name,
    recordIntervalSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorTableData &&
          other.id == this.id &&
          other.stationId == this.stationId &&
          other.element == this.element &&
          other.storageUnitId == this.storageUnitId &&
          other.name == this.name &&
          other.recordIntervalSeconds == this.recordIntervalSeconds);
}

class SensorTableCompanion extends UpdateCompanion<SensorTableData> {
  final Value<int> id;
  final Value<int> stationId;
  final Value<SensorElement> element;
  final Value<String> storageUnitId;
  final Value<String> name;
  final Value<int> recordIntervalSeconds;
  const SensorTableCompanion({
    this.id = const Value.absent(),
    this.stationId = const Value.absent(),
    this.element = const Value.absent(),
    this.storageUnitId = const Value.absent(),
    this.name = const Value.absent(),
    this.recordIntervalSeconds = const Value.absent(),
  });
  SensorTableCompanion.insert({
    this.id = const Value.absent(),
    required int stationId,
    required SensorElement element,
    required String storageUnitId,
    required String name,
    this.recordIntervalSeconds = const Value.absent(),
  }) : stationId = Value(stationId),
       element = Value(element),
       storageUnitId = Value(storageUnitId),
       name = Value(name);
  static Insertable<SensorTableData> custom({
    Expression<int>? id,
    Expression<int>? stationId,
    Expression<String>? element,
    Expression<String>? storageUnitId,
    Expression<String>? name,
    Expression<int>? recordIntervalSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationId != null) 'station_id': stationId,
      if (element != null) 'element': element,
      if (storageUnitId != null) 'storage_unit_id': storageUnitId,
      if (name != null) 'name': name,
      if (recordIntervalSeconds != null)
        'record_interval_seconds': recordIntervalSeconds,
    });
  }

  SensorTableCompanion copyWith({
    Value<int>? id,
    Value<int>? stationId,
    Value<SensorElement>? element,
    Value<String>? storageUnitId,
    Value<String>? name,
    Value<int>? recordIntervalSeconds,
  }) {
    return SensorTableCompanion(
      id: id ?? this.id,
      stationId: stationId ?? this.stationId,
      element: element ?? this.element,
      storageUnitId: storageUnitId ?? this.storageUnitId,
      name: name ?? this.name,
      recordIntervalSeconds:
          recordIntervalSeconds ?? this.recordIntervalSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationId.present) {
      map['station_id'] = Variable<int>(stationId.value);
    }
    if (element.present) {
      map['element'] = Variable<String>(
        $SensorTableTable.$converterelement.toSql(element.value),
      );
    }
    if (storageUnitId.present) {
      map['storage_unit_id'] = Variable<String>(storageUnitId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (recordIntervalSeconds.present) {
      map['record_interval_seconds'] = Variable<int>(
        recordIntervalSeconds.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensorTableCompanion(')
          ..write('id: $id, ')
          ..write('stationId: $stationId, ')
          ..write('element: $element, ')
          ..write('storageUnitId: $storageUnitId, ')
          ..write('name: $name, ')
          ..write('recordIntervalSeconds: $recordIntervalSeconds')
          ..write(')'))
        .toString();
  }
}

class $TokenTableTable extends TokenTable
    with TableInfo<$TokenTableTable, TokenTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TokenTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TokenRole, String> role =
      GeneratedColumn<String>(
        'role',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TokenRole>($TokenTableTable.$converterrole);
  @override
  List<GeneratedColumn> get $columns => [token, role];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'token_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<TokenTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  TokenTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TokenTableData(
      token: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}token'],
      )!,
      role: $TokenTableTable.$converterrole.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}role'],
        )!,
      ),
    );
  }

  @override
  $TokenTableTable createAlias(String alias) {
    return $TokenTableTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TokenRole, String, String> $converterrole =
      const EnumNameConverter<TokenRole>(TokenRole.values);
}

class TokenTableData extends DataClass implements Insertable<TokenTableData> {
  final String token;
  final TokenRole role;
  const TokenTableData({required this.token, required this.role});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['token'] = Variable<String>(token);
    {
      map['role'] = Variable<String>(
        $TokenTableTable.$converterrole.toSql(role),
      );
    }
    return map;
  }

  TokenTableCompanion toCompanion(bool nullToAbsent) {
    return TokenTableCompanion(token: Value(token), role: Value(role));
  }

  factory TokenTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TokenTableData(
      token: serializer.fromJson<String>(json['token']),
      role: $TokenTableTable.$converterrole.fromJson(
        serializer.fromJson<String>(json['role']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'token': serializer.toJson<String>(token),
      'role': serializer.toJson<String>(
        $TokenTableTable.$converterrole.toJson(role),
      ),
    };
  }

  TokenTableData copyWith({String? token, TokenRole? role}) =>
      TokenTableData(token: token ?? this.token, role: role ?? this.role);
  TokenTableData copyWithCompanion(TokenTableCompanion data) {
    return TokenTableData(
      token: data.token.present ? data.token.value : this.token,
      role: data.role.present ? data.role.value : this.role,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TokenTableData(')
          ..write('token: $token, ')
          ..write('role: $role')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(token, role);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TokenTableData &&
          other.token == this.token &&
          other.role == this.role);
}

class TokenTableCompanion extends UpdateCompanion<TokenTableData> {
  final Value<String> token;
  final Value<TokenRole> role;
  final Value<int> rowid;
  const TokenTableCompanion({
    this.token = const Value.absent(),
    this.role = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TokenTableCompanion.insert({
    required String token,
    required TokenRole role,
    this.rowid = const Value.absent(),
  }) : token = Value(token),
       role = Value(role);
  static Insertable<TokenTableData> custom({
    Expression<String>? token,
    Expression<String>? role,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (token != null) 'token': token,
      if (role != null) 'role': role,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TokenTableCompanion copyWith({
    Value<String>? token,
    Value<TokenRole>? role,
    Value<int>? rowid,
  }) {
    return TokenTableCompanion(
      token: token ?? this.token,
      role: role ?? this.role,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(
        $TokenTableTable.$converterrole.toSql(role.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TokenTableCompanion(')
          ..write('token: $token, ')
          ..write('role: $role, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $StationTableTable stationTable = $StationTableTable(this);
  late final $SensorTableTable sensorTable = $SensorTableTable(this);
  late final $TokenTableTable tokenTable = $TokenTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stationTable,
    sensorTable,
    tokenTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'station_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('sensor_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'station_table',
        limitUpdateKind: UpdateKind.update,
      ),
      result: [TableUpdate('sensor_table', kind: UpdateKind.update)],
    ),
  ]);
}

typedef $$StationTableTableCreateCompanionBuilder =
    StationTableCompanion Function({
      Value<int> id,
      required String name,
      required DateTime createdAt,
      required double longitude,
      required double latitude,
    });
typedef $$StationTableTableUpdateCompanionBuilder =
    StationTableCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<double> longitude,
      Value<double> latitude,
    });

final class $$StationTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $StationTableTable, StationTableData> {
  $$StationTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$SensorTableTable, List<SensorTableData>>
  _sensorTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.sensorTable,
    aliasName: $_aliasNameGenerator(
      db.stationTable.id,
      db.sensorTable.stationId,
    ),
  );

  $$SensorTableTableProcessedTableManager get sensorTableRefs {
    final manager = $$SensorTableTableTableManager(
      $_db,
      $_db.sensorTable,
    ).filter((f) => f.stationId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sensorTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StationTableTableFilterComposer
    extends Composer<_$AppDatabase, $StationTableTable> {
  $$StationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> sensorTableRefs(
    Expression<bool> Function($$SensorTableTableFilterComposer f) f,
  ) {
    final $$SensorTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sensorTable,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensorTableTableFilterComposer(
            $db: $db,
            $table: $db.sensorTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StationTableTableOrderingComposer
    extends Composer<_$AppDatabase, $StationTableTable> {
  $$StationTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StationTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $StationTableTable> {
  $$StationTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  Expression<T> sensorTableRefs<T extends Object>(
    Expression<T> Function($$SensorTableTableAnnotationComposer a) f,
  ) {
    final $$SensorTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.sensorTable,
      getReferencedColumn: (t) => t.stationId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SensorTableTableAnnotationComposer(
            $db: $db,
            $table: $db.sensorTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StationTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StationTableTable,
          StationTableData,
          $$StationTableTableFilterComposer,
          $$StationTableTableOrderingComposer,
          $$StationTableTableAnnotationComposer,
          $$StationTableTableCreateCompanionBuilder,
          $$StationTableTableUpdateCompanionBuilder,
          (StationTableData, $$StationTableTableReferences),
          StationTableData,
          PrefetchHooks Function({bool sensorTableRefs})
        > {
  $$StationTableTableTableManager(_$AppDatabase db, $StationTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StationTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StationTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StationTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double> longitude = const Value.absent(),
                Value<double> latitude = const Value.absent(),
              }) => StationTableCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                longitude: longitude,
                latitude: latitude,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required DateTime createdAt,
                required double longitude,
                required double latitude,
              }) => StationTableCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                longitude: longitude,
                latitude: latitude,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StationTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({sensorTableRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (sensorTableRefs) db.sensorTable],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (sensorTableRefs)
                    await $_getPrefetchedData<
                      StationTableData,
                      $StationTableTable,
                      SensorTableData
                    >(
                      currentTable: table,
                      referencedTable: $$StationTableTableReferences
                          ._sensorTableRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$StationTableTableReferences(
                            db,
                            table,
                            p0,
                          ).sensorTableRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.stationId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$StationTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StationTableTable,
      StationTableData,
      $$StationTableTableFilterComposer,
      $$StationTableTableOrderingComposer,
      $$StationTableTableAnnotationComposer,
      $$StationTableTableCreateCompanionBuilder,
      $$StationTableTableUpdateCompanionBuilder,
      (StationTableData, $$StationTableTableReferences),
      StationTableData,
      PrefetchHooks Function({bool sensorTableRefs})
    >;
typedef $$SensorTableTableCreateCompanionBuilder =
    SensorTableCompanion Function({
      Value<int> id,
      required int stationId,
      required SensorElement element,
      required String storageUnitId,
      required String name,
      Value<int> recordIntervalSeconds,
    });
typedef $$SensorTableTableUpdateCompanionBuilder =
    SensorTableCompanion Function({
      Value<int> id,
      Value<int> stationId,
      Value<SensorElement> element,
      Value<String> storageUnitId,
      Value<String> name,
      Value<int> recordIntervalSeconds,
    });

final class $$SensorTableTableReferences
    extends BaseReferences<_$AppDatabase, $SensorTableTable, SensorTableData> {
  $$SensorTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $StationTableTable _stationIdTable(_$AppDatabase db) =>
      db.stationTable.createAlias(
        $_aliasNameGenerator(db.sensorTable.stationId, db.stationTable.id),
      );

  $$StationTableTableProcessedTableManager get stationId {
    final $_column = $_itemColumn<int>('station_id')!;

    final manager = $$StationTableTableTableManager(
      $_db,
      $_db.stationTable,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_stationIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SensorTableTableFilterComposer
    extends Composer<_$AppDatabase, $SensorTableTable> {
  $$SensorTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SensorElement, SensorElement, String>
  get element => $composableBuilder(
    column: $table.element,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get storageUnitId => $composableBuilder(
    column: $table.storageUnitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordIntervalSeconds => $composableBuilder(
    column: $table.recordIntervalSeconds,
    builder: (column) => ColumnFilters(column),
  );

  $$StationTableTableFilterComposer get stationId {
    final $$StationTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.stationTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StationTableTableFilterComposer(
            $db: $db,
            $table: $db.stationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorTableTableOrderingComposer
    extends Composer<_$AppDatabase, $SensorTableTable> {
  $$SensorTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get element => $composableBuilder(
    column: $table.element,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storageUnitId => $composableBuilder(
    column: $table.storageUnitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordIntervalSeconds => $composableBuilder(
    column: $table.recordIntervalSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  $$StationTableTableOrderingComposer get stationId {
    final $$StationTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.stationTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StationTableTableOrderingComposer(
            $db: $db,
            $table: $db.stationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $SensorTableTable> {
  $$SensorTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SensorElement, String> get element =>
      $composableBuilder(column: $table.element, builder: (column) => column);

  GeneratedColumn<String> get storageUnitId => $composableBuilder(
    column: $table.storageUnitId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get recordIntervalSeconds => $composableBuilder(
    column: $table.recordIntervalSeconds,
    builder: (column) => column,
  );

  $$StationTableTableAnnotationComposer get stationId {
    final $$StationTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.stationId,
      referencedTable: $db.stationTable,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StationTableTableAnnotationComposer(
            $db: $db,
            $table: $db.stationTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SensorTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SensorTableTable,
          SensorTableData,
          $$SensorTableTableFilterComposer,
          $$SensorTableTableOrderingComposer,
          $$SensorTableTableAnnotationComposer,
          $$SensorTableTableCreateCompanionBuilder,
          $$SensorTableTableUpdateCompanionBuilder,
          (SensorTableData, $$SensorTableTableReferences),
          SensorTableData,
          PrefetchHooks Function({bool stationId})
        > {
  $$SensorTableTableTableManager(_$AppDatabase db, $SensorTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SensorTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SensorTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SensorTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> stationId = const Value.absent(),
                Value<SensorElement> element = const Value.absent(),
                Value<String> storageUnitId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> recordIntervalSeconds = const Value.absent(),
              }) => SensorTableCompanion(
                id: id,
                stationId: stationId,
                element: element,
                storageUnitId: storageUnitId,
                name: name,
                recordIntervalSeconds: recordIntervalSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int stationId,
                required SensorElement element,
                required String storageUnitId,
                required String name,
                Value<int> recordIntervalSeconds = const Value.absent(),
              }) => SensorTableCompanion.insert(
                id: id,
                stationId: stationId,
                element: element,
                storageUnitId: storageUnitId,
                name: name,
                recordIntervalSeconds: recordIntervalSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$SensorTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({stationId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
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
                      dynamic
                    >
                  >(state) {
                    if (stationId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.stationId,
                                referencedTable: $$SensorTableTableReferences
                                    ._stationIdTable(db),
                                referencedColumn: $$SensorTableTableReferences
                                    ._stationIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SensorTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SensorTableTable,
      SensorTableData,
      $$SensorTableTableFilterComposer,
      $$SensorTableTableOrderingComposer,
      $$SensorTableTableAnnotationComposer,
      $$SensorTableTableCreateCompanionBuilder,
      $$SensorTableTableUpdateCompanionBuilder,
      (SensorTableData, $$SensorTableTableReferences),
      SensorTableData,
      PrefetchHooks Function({bool stationId})
    >;
typedef $$TokenTableTableCreateCompanionBuilder =
    TokenTableCompanion Function({
      required String token,
      required TokenRole role,
      Value<int> rowid,
    });
typedef $$TokenTableTableUpdateCompanionBuilder =
    TokenTableCompanion Function({
      Value<String> token,
      Value<TokenRole> role,
      Value<int> rowid,
    });

class $$TokenTableTableFilterComposer
    extends Composer<_$AppDatabase, $TokenTableTable> {
  $$TokenTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TokenRole, TokenRole, String> get role =>
      $composableBuilder(
        column: $table.role,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$TokenTableTableOrderingComposer
    extends Composer<_$AppDatabase, $TokenTableTable> {
  $$TokenTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TokenTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $TokenTableTable> {
  $$TokenTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TokenRole, String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);
}

class $$TokenTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TokenTableTable,
          TokenTableData,
          $$TokenTableTableFilterComposer,
          $$TokenTableTableOrderingComposer,
          $$TokenTableTableAnnotationComposer,
          $$TokenTableTableCreateCompanionBuilder,
          $$TokenTableTableUpdateCompanionBuilder,
          (
            TokenTableData,
            BaseReferences<_$AppDatabase, $TokenTableTable, TokenTableData>,
          ),
          TokenTableData,
          PrefetchHooks Function()
        > {
  $$TokenTableTableTableManager(_$AppDatabase db, $TokenTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TokenTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TokenTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TokenTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> token = const Value.absent(),
                Value<TokenRole> role = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TokenTableCompanion(token: token, role: role, rowid: rowid),
          createCompanionCallback:
              ({
                required String token,
                required TokenRole role,
                Value<int> rowid = const Value.absent(),
              }) => TokenTableCompanion.insert(
                token: token,
                role: role,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$TokenTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TokenTableTable,
      TokenTableData,
      $$TokenTableTableFilterComposer,
      $$TokenTableTableOrderingComposer,
      $$TokenTableTableAnnotationComposer,
      $$TokenTableTableCreateCompanionBuilder,
      $$TokenTableTableUpdateCompanionBuilder,
      (
        TokenTableData,
        BaseReferences<_$AppDatabase, $TokenTableTable, TokenTableData>,
      ),
      TokenTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$StationTableTableTableManager get stationTable =>
      $$StationTableTableTableManager(_db, _db.stationTable);
  $$SensorTableTableTableManager get sensorTable =>
      $$SensorTableTableTableManager(_db, _db.sensorTable);
  $$TokenTableTableTableManager get tokenTable =>
      $$TokenTableTableTableManager(_db, _db.tokenTable);
}
