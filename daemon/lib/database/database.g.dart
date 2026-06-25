// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $StationTableTable extends StationTable
    with TableInfo<$StationTableTable, StationTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StationTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uuidMeta = const VerificationMeta('uuid');
  @override
  late final GeneratedColumn<String> uuid = GeneratedColumn<String>(
    'uuid',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 36,
      maxTextLength: 36,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(minTextLength: 1),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _interfaceNameMeta = const VerificationMeta(
    'interfaceName',
  );
  @override
  late final GeneratedColumn<String> interfaceName = GeneratedColumn<String>(
    'interface_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _configuredMeta = const VerificationMeta(
    'configured',
  );
  @override
  late final GeneratedColumn<bool> configured = GeneratedColumn<bool>(
    'configured',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("configured" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uuid,
    name,
    createdAt,
    longitude,
    latitude,
    interfaceName,
    configured,
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
    if (data.containsKey('uuid')) {
      context.handle(
        _uuidMeta,
        uuid.isAcceptableOrUnknown(data['uuid']!, _uuidMeta),
      );
    } else if (isInserting) {
      context.missing(_uuidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
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
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('interface_name')) {
      context.handle(
        _interfaceNameMeta,
        interfaceName.isAcceptableOrUnknown(
          data['interface_name']!,
          _interfaceNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_interfaceNameMeta);
    }
    if (data.containsKey('configured')) {
      context.handle(
        _configuredMeta,
        configured.isAcceptableOrUnknown(data['configured']!, _configuredMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  StationTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StationTableData(
      uuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}uuid'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      interfaceName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interface_name'],
      )!,
      configured: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}configured'],
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
  final String uuid;
  final String? name;
  final DateTime createdAt;
  final double? longitude;
  final double? latitude;
  final String interfaceName;
  final bool configured;
  const StationTableData({
    required this.uuid,
    this.name,
    required this.createdAt,
    this.longitude,
    this.latitude,
    required this.interfaceName,
    required this.configured,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uuid'] = Variable<String>(uuid);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    map['interface_name'] = Variable<String>(interfaceName);
    map['configured'] = Variable<bool>(configured);
    return map;
  }

  StationTableCompanion toCompanion(bool nullToAbsent) {
    return StationTableCompanion(
      uuid: Value(uuid),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      createdAt: Value(createdAt),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      interfaceName: Value(interfaceName),
      configured: Value(configured),
    );
  }

  factory StationTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StationTableData(
      uuid: serializer.fromJson<String>(json['uuid']),
      name: serializer.fromJson<String?>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      interfaceName: serializer.fromJson<String>(json['interfaceName']),
      configured: serializer.fromJson<bool>(json['configured']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uuid': serializer.toJson<String>(uuid),
      'name': serializer.toJson<String?>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'longitude': serializer.toJson<double?>(longitude),
      'latitude': serializer.toJson<double?>(latitude),
      'interfaceName': serializer.toJson<String>(interfaceName),
      'configured': serializer.toJson<bool>(configured),
    };
  }

  StationTableData copyWith({
    String? uuid,
    Value<String?> name = const Value.absent(),
    DateTime? createdAt,
    Value<double?> longitude = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    String? interfaceName,
    bool? configured,
  }) => StationTableData(
    uuid: uuid ?? this.uuid,
    name: name.present ? name.value : this.name,
    createdAt: createdAt ?? this.createdAt,
    longitude: longitude.present ? longitude.value : this.longitude,
    latitude: latitude.present ? latitude.value : this.latitude,
    interfaceName: interfaceName ?? this.interfaceName,
    configured: configured ?? this.configured,
  );
  StationTableData copyWithCompanion(StationTableCompanion data) {
    return StationTableData(
      uuid: data.uuid.present ? data.uuid.value : this.uuid,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      interfaceName: data.interfaceName.present
          ? data.interfaceName.value
          : this.interfaceName,
      configured: data.configured.present
          ? data.configured.value
          : this.configured,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StationTableData(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('interfaceName: $interfaceName, ')
          ..write('configured: $configured')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uuid,
    name,
    createdAt,
    longitude,
    latitude,
    interfaceName,
    configured,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StationTableData &&
          other.uuid == this.uuid &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.interfaceName == this.interfaceName &&
          other.configured == this.configured);
}

class StationTableCompanion extends UpdateCompanion<StationTableData> {
  final Value<String> uuid;
  final Value<String?> name;
  final Value<DateTime> createdAt;
  final Value<double?> longitude;
  final Value<double?> latitude;
  final Value<String> interfaceName;
  final Value<bool> configured;
  final Value<int> rowid;
  const StationTableCompanion({
    this.uuid = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.interfaceName = const Value.absent(),
    this.configured = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StationTableCompanion.insert({
    required String uuid,
    this.name = const Value.absent(),
    required DateTime createdAt,
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    required String interfaceName,
    this.configured = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uuid = Value(uuid),
       createdAt = Value(createdAt),
       interfaceName = Value(interfaceName);
  static Insertable<StationTableData> custom({
    Expression<String>? uuid,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<double>? longitude,
    Expression<double>? latitude,
    Expression<String>? interfaceName,
    Expression<bool>? configured,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uuid != null) 'uuid': uuid,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (interfaceName != null) 'interface_name': interfaceName,
      if (configured != null) 'configured': configured,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StationTableCompanion copyWith({
    Value<String>? uuid,
    Value<String?>? name,
    Value<DateTime>? createdAt,
    Value<double?>? longitude,
    Value<double?>? latitude,
    Value<String>? interfaceName,
    Value<bool>? configured,
    Value<int>? rowid,
  }) {
    return StationTableCompanion(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      interfaceName: interfaceName ?? this.interfaceName,
      configured: configured ?? this.configured,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uuid.present) {
      map['uuid'] = Variable<String>(uuid.value);
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
    if (interfaceName.present) {
      map['interface_name'] = Variable<String>(interfaceName.value);
    }
    if (configured.present) {
      map['configured'] = Variable<bool>(configured.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StationTableCompanion(')
          ..write('uuid: $uuid, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('interfaceName: $interfaceName, ')
          ..write('configured: $configured, ')
          ..write('rowid: $rowid')
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
  static const VerificationMeta _stationUuidMeta = const VerificationMeta(
    'stationUuid',
  );
  @override
  late final GeneratedColumn<String> stationUuid = GeneratedColumn<String>(
    'station_uuid',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
    defaultValue: const Constant(defaultRecordIntervalSeconds),
  );
  static const VerificationMeta _historyIntervalSecondsMeta =
      const VerificationMeta('historyIntervalSeconds');
  @override
  late final GeneratedColumn<int> historyIntervalSeconds = GeneratedColumn<int>(
    'history_interval_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(defaultHistoryIntervalSeconds),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    stationUuid,
    element,
    storageUnitId,
    name,
    recordIntervalSeconds,
    historyIntervalSeconds,
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
    if (data.containsKey('station_uuid')) {
      context.handle(
        _stationUuidMeta,
        stationUuid.isAcceptableOrUnknown(
          data['station_uuid']!,
          _stationUuidMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_stationUuidMeta);
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
    if (data.containsKey('history_interval_seconds')) {
      context.handle(
        _historyIntervalSecondsMeta,
        historyIntervalSeconds.isAcceptableOrUnknown(
          data['history_interval_seconds']!,
          _historyIntervalSecondsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {stationUuid, name},
  ];
  @override
  SensorTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SensorTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      stationUuid: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station_uuid'],
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
      historyIntervalSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}history_interval_seconds'],
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
  final String stationUuid;
  final SensorElement element;
  final String storageUnitId;
  final String name;
  final int recordIntervalSeconds;
  final int historyIntervalSeconds;
  const SensorTableData({
    required this.id,
    required this.stationUuid,
    required this.element,
    required this.storageUnitId,
    required this.name,
    required this.recordIntervalSeconds,
    required this.historyIntervalSeconds,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['station_uuid'] = Variable<String>(stationUuid);
    {
      map['element'] = Variable<String>(
        $SensorTableTable.$converterelement.toSql(element),
      );
    }
    map['storage_unit_id'] = Variable<String>(storageUnitId);
    map['name'] = Variable<String>(name);
    map['record_interval_seconds'] = Variable<int>(recordIntervalSeconds);
    map['history_interval_seconds'] = Variable<int>(historyIntervalSeconds);
    return map;
  }

  SensorTableCompanion toCompanion(bool nullToAbsent) {
    return SensorTableCompanion(
      id: Value(id),
      stationUuid: Value(stationUuid),
      element: Value(element),
      storageUnitId: Value(storageUnitId),
      name: Value(name),
      recordIntervalSeconds: Value(recordIntervalSeconds),
      historyIntervalSeconds: Value(historyIntervalSeconds),
    );
  }

  factory SensorTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SensorTableData(
      id: serializer.fromJson<int>(json['id']),
      stationUuid: serializer.fromJson<String>(json['stationUuid']),
      element: $SensorTableTable.$converterelement.fromJson(
        serializer.fromJson<String>(json['element']),
      ),
      storageUnitId: serializer.fromJson<String>(json['storageUnitId']),
      name: serializer.fromJson<String>(json['name']),
      recordIntervalSeconds: serializer.fromJson<int>(
        json['recordIntervalSeconds'],
      ),
      historyIntervalSeconds: serializer.fromJson<int>(
        json['historyIntervalSeconds'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'stationUuid': serializer.toJson<String>(stationUuid),
      'element': serializer.toJson<String>(
        $SensorTableTable.$converterelement.toJson(element),
      ),
      'storageUnitId': serializer.toJson<String>(storageUnitId),
      'name': serializer.toJson<String>(name),
      'recordIntervalSeconds': serializer.toJson<int>(recordIntervalSeconds),
      'historyIntervalSeconds': serializer.toJson<int>(historyIntervalSeconds),
    };
  }

  SensorTableData copyWith({
    int? id,
    String? stationUuid,
    SensorElement? element,
    String? storageUnitId,
    String? name,
    int? recordIntervalSeconds,
    int? historyIntervalSeconds,
  }) => SensorTableData(
    id: id ?? this.id,
    stationUuid: stationUuid ?? this.stationUuid,
    element: element ?? this.element,
    storageUnitId: storageUnitId ?? this.storageUnitId,
    name: name ?? this.name,
    recordIntervalSeconds: recordIntervalSeconds ?? this.recordIntervalSeconds,
    historyIntervalSeconds:
        historyIntervalSeconds ?? this.historyIntervalSeconds,
  );
  SensorTableData copyWithCompanion(SensorTableCompanion data) {
    return SensorTableData(
      id: data.id.present ? data.id.value : this.id,
      stationUuid: data.stationUuid.present
          ? data.stationUuid.value
          : this.stationUuid,
      element: data.element.present ? data.element.value : this.element,
      storageUnitId: data.storageUnitId.present
          ? data.storageUnitId.value
          : this.storageUnitId,
      name: data.name.present ? data.name.value : this.name,
      recordIntervalSeconds: data.recordIntervalSeconds.present
          ? data.recordIntervalSeconds.value
          : this.recordIntervalSeconds,
      historyIntervalSeconds: data.historyIntervalSeconds.present
          ? data.historyIntervalSeconds.value
          : this.historyIntervalSeconds,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SensorTableData(')
          ..write('id: $id, ')
          ..write('stationUuid: $stationUuid, ')
          ..write('element: $element, ')
          ..write('storageUnitId: $storageUnitId, ')
          ..write('name: $name, ')
          ..write('recordIntervalSeconds: $recordIntervalSeconds, ')
          ..write('historyIntervalSeconds: $historyIntervalSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    stationUuid,
    element,
    storageUnitId,
    name,
    recordIntervalSeconds,
    historyIntervalSeconds,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SensorTableData &&
          other.id == this.id &&
          other.stationUuid == this.stationUuid &&
          other.element == this.element &&
          other.storageUnitId == this.storageUnitId &&
          other.name == this.name &&
          other.recordIntervalSeconds == this.recordIntervalSeconds &&
          other.historyIntervalSeconds == this.historyIntervalSeconds);
}

class SensorTableCompanion extends UpdateCompanion<SensorTableData> {
  final Value<int> id;
  final Value<String> stationUuid;
  final Value<SensorElement> element;
  final Value<String> storageUnitId;
  final Value<String> name;
  final Value<int> recordIntervalSeconds;
  final Value<int> historyIntervalSeconds;
  const SensorTableCompanion({
    this.id = const Value.absent(),
    this.stationUuid = const Value.absent(),
    this.element = const Value.absent(),
    this.storageUnitId = const Value.absent(),
    this.name = const Value.absent(),
    this.recordIntervalSeconds = const Value.absent(),
    this.historyIntervalSeconds = const Value.absent(),
  });
  SensorTableCompanion.insert({
    this.id = const Value.absent(),
    required String stationUuid,
    required SensorElement element,
    required String storageUnitId,
    required String name,
    this.recordIntervalSeconds = const Value.absent(),
    this.historyIntervalSeconds = const Value.absent(),
  }) : stationUuid = Value(stationUuid),
       element = Value(element),
       storageUnitId = Value(storageUnitId),
       name = Value(name);
  static Insertable<SensorTableData> custom({
    Expression<int>? id,
    Expression<String>? stationUuid,
    Expression<String>? element,
    Expression<String>? storageUnitId,
    Expression<String>? name,
    Expression<int>? recordIntervalSeconds,
    Expression<int>? historyIntervalSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (stationUuid != null) 'station_uuid': stationUuid,
      if (element != null) 'element': element,
      if (storageUnitId != null) 'storage_unit_id': storageUnitId,
      if (name != null) 'name': name,
      if (recordIntervalSeconds != null)
        'record_interval_seconds': recordIntervalSeconds,
      if (historyIntervalSeconds != null)
        'history_interval_seconds': historyIntervalSeconds,
    });
  }

  SensorTableCompanion copyWith({
    Value<int>? id,
    Value<String>? stationUuid,
    Value<SensorElement>? element,
    Value<String>? storageUnitId,
    Value<String>? name,
    Value<int>? recordIntervalSeconds,
    Value<int>? historyIntervalSeconds,
  }) {
    return SensorTableCompanion(
      id: id ?? this.id,
      stationUuid: stationUuid ?? this.stationUuid,
      element: element ?? this.element,
      storageUnitId: storageUnitId ?? this.storageUnitId,
      name: name ?? this.name,
      recordIntervalSeconds:
          recordIntervalSeconds ?? this.recordIntervalSeconds,
      historyIntervalSeconds:
          historyIntervalSeconds ?? this.historyIntervalSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (stationUuid.present) {
      map['station_uuid'] = Variable<String>(stationUuid.value);
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
    if (historyIntervalSeconds.present) {
      map['history_interval_seconds'] = Variable<int>(
        historyIntervalSeconds.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SensorTableCompanion(')
          ..write('id: $id, ')
          ..write('stationUuid: $stationUuid, ')
          ..write('element: $element, ')
          ..write('storageUnitId: $storageUnitId, ')
          ..write('name: $name, ')
          ..write('recordIntervalSeconds: $recordIntervalSeconds, ')
          ..write('historyIntervalSeconds: $historyIntervalSeconds')
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

class $HistoryTableTable extends HistoryTable
    with TableInfo<$HistoryTableTable, HistoryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HistoryTableTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _sensorIdMeta = const VerificationMeta(
    'sensorId',
  );
  @override
  late final GeneratedColumn<int> sensorId = GeneratedColumn<int>(
    'sensor_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<double> value = GeneratedColumn<double>(
    'value',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [id, sensorId, value, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'history_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<HistoryTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('sensor_id')) {
      context.handle(
        _sensorIdMeta,
        sensorId.isAcceptableOrUnknown(data['sensor_id']!, _sensorIdMeta),
      );
    } else if (isInserting) {
      context.missing(_sensorIdMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HistoryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HistoryTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      sensorId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sensor_id'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}value'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HistoryTableTable createAlias(String alias) {
    return $HistoryTableTable(attachedDatabase, alias);
  }
}

class HistoryTableData extends DataClass
    implements Insertable<HistoryTableData> {
  final int id;
  final int sensorId;
  final double? value;
  final DateTime createdAt;
  const HistoryTableData({
    required this.id,
    required this.sensorId,
    this.value,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['sensor_id'] = Variable<int>(sensorId);
    if (!nullToAbsent || value != null) {
      map['value'] = Variable<double>(value);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HistoryTableCompanion toCompanion(bool nullToAbsent) {
    return HistoryTableCompanion(
      id: Value(id),
      sensorId: Value(sensorId),
      value: value == null && nullToAbsent
          ? const Value.absent()
          : Value(value),
      createdAt: Value(createdAt),
    );
  }

  factory HistoryTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HistoryTableData(
      id: serializer.fromJson<int>(json['id']),
      sensorId: serializer.fromJson<int>(json['sensorId']),
      value: serializer.fromJson<double?>(json['value']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'sensorId': serializer.toJson<int>(sensorId),
      'value': serializer.toJson<double?>(value),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HistoryTableData copyWith({
    int? id,
    int? sensorId,
    Value<double?> value = const Value.absent(),
    DateTime? createdAt,
  }) => HistoryTableData(
    id: id ?? this.id,
    sensorId: sensorId ?? this.sensorId,
    value: value.present ? value.value : this.value,
    createdAt: createdAt ?? this.createdAt,
  );
  HistoryTableData copyWithCompanion(HistoryTableCompanion data) {
    return HistoryTableData(
      id: data.id.present ? data.id.value : this.id,
      sensorId: data.sensorId.present ? data.sensorId.value : this.sensorId,
      value: data.value.present ? data.value.value : this.value,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HistoryTableData(')
          ..write('id: $id, ')
          ..write('sensorId: $sensorId, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, sensorId, value, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HistoryTableData &&
          other.id == this.id &&
          other.sensorId == this.sensorId &&
          other.value == this.value &&
          other.createdAt == this.createdAt);
}

class HistoryTableCompanion extends UpdateCompanion<HistoryTableData> {
  final Value<int> id;
  final Value<int> sensorId;
  final Value<double?> value;
  final Value<DateTime> createdAt;
  const HistoryTableCompanion({
    this.id = const Value.absent(),
    this.sensorId = const Value.absent(),
    this.value = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  HistoryTableCompanion.insert({
    this.id = const Value.absent(),
    required int sensorId,
    this.value = const Value.absent(),
    required DateTime createdAt,
  }) : sensorId = Value(sensorId),
       createdAt = Value(createdAt);
  static Insertable<HistoryTableData> custom({
    Expression<int>? id,
    Expression<int>? sensorId,
    Expression<double>? value,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (sensorId != null) 'sensor_id': sensorId,
      if (value != null) 'value': value,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  HistoryTableCompanion copyWith({
    Value<int>? id,
    Value<int>? sensorId,
    Value<double?>? value,
    Value<DateTime>? createdAt,
  }) {
    return HistoryTableCompanion(
      id: id ?? this.id,
      sensorId: sensorId ?? this.sensorId,
      value: value ?? this.value,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (sensorId.present) {
      map['sensor_id'] = Variable<int>(sensorId.value);
    }
    if (value.present) {
      map['value'] = Variable<double>(value.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HistoryTableCompanion(')
          ..write('id: $id, ')
          ..write('sensorId: $sensorId, ')
          ..write('value: $value, ')
          ..write('createdAt: $createdAt')
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
  late final $HistoryTableTable historyTable = $HistoryTableTable(this);
  late final Index historySensorCreatedIdx = Index(
    'history_sensor_created_idx',
    'CREATE INDEX history_sensor_created_idx ON history_table (sensor_id, created_at)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    stationTable,
    sensorTable,
    tokenTable,
    historyTable,
    historySensorCreatedIdx,
  ];
}

typedef $$StationTableTableCreateCompanionBuilder =
    StationTableCompanion Function({
      required String uuid,
      Value<String?> name,
      required DateTime createdAt,
      Value<double?> longitude,
      Value<double?> latitude,
      required String interfaceName,
      Value<bool> configured,
      Value<int> rowid,
    });
typedef $$StationTableTableUpdateCompanionBuilder =
    StationTableCompanion Function({
      Value<String> uuid,
      Value<String?> name,
      Value<DateTime> createdAt,
      Value<double?> longitude,
      Value<double?> latitude,
      Value<String> interfaceName,
      Value<bool> configured,
      Value<int> rowid,
    });

class $$StationTableTableFilterComposer
    extends Composer<_$AppDatabase, $StationTableTable> {
  $$StationTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uuid => $composableBuilder(
    column: $table.uuid,
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

  ColumnFilters<String> get interfaceName => $composableBuilder(
    column: $table.interfaceName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get configured => $composableBuilder(
    column: $table.configured,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get uuid => $composableBuilder(
    column: $table.uuid,
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

  ColumnOrderings<String> get interfaceName => $composableBuilder(
    column: $table.interfaceName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get configured => $composableBuilder(
    column: $table.configured,
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
  GeneratedColumn<String> get uuid =>
      $composableBuilder(column: $table.uuid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<String> get interfaceName => $composableBuilder(
    column: $table.interfaceName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get configured => $composableBuilder(
    column: $table.configured,
    builder: (column) => column,
  );
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
          (
            StationTableData,
            BaseReferences<_$AppDatabase, $StationTableTable, StationTableData>,
          ),
          StationTableData,
          PrefetchHooks Function()
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
                Value<String> uuid = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<String> interfaceName = const Value.absent(),
                Value<bool> configured = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StationTableCompanion(
                uuid: uuid,
                name: name,
                createdAt: createdAt,
                longitude: longitude,
                latitude: latitude,
                interfaceName: interfaceName,
                configured: configured,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uuid,
                Value<String?> name = const Value.absent(),
                required DateTime createdAt,
                Value<double?> longitude = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                required String interfaceName,
                Value<bool> configured = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StationTableCompanion.insert(
                uuid: uuid,
                name: name,
                createdAt: createdAt,
                longitude: longitude,
                latitude: latitude,
                interfaceName: interfaceName,
                configured: configured,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        StationTableData,
        BaseReferences<_$AppDatabase, $StationTableTable, StationTableData>,
      ),
      StationTableData,
      PrefetchHooks Function()
    >;
typedef $$SensorTableTableCreateCompanionBuilder =
    SensorTableCompanion Function({
      Value<int> id,
      required String stationUuid,
      required SensorElement element,
      required String storageUnitId,
      required String name,
      Value<int> recordIntervalSeconds,
      Value<int> historyIntervalSeconds,
    });
typedef $$SensorTableTableUpdateCompanionBuilder =
    SensorTableCompanion Function({
      Value<int> id,
      Value<String> stationUuid,
      Value<SensorElement> element,
      Value<String> storageUnitId,
      Value<String> name,
      Value<int> recordIntervalSeconds,
      Value<int> historyIntervalSeconds,
    });

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

  ColumnFilters<String> get stationUuid => $composableBuilder(
    column: $table.stationUuid,
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

  ColumnFilters<int> get historyIntervalSeconds => $composableBuilder(
    column: $table.historyIntervalSeconds,
    builder: (column) => ColumnFilters(column),
  );
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

  ColumnOrderings<String> get stationUuid => $composableBuilder(
    column: $table.stationUuid,
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

  ColumnOrderings<int> get historyIntervalSeconds => $composableBuilder(
    column: $table.historyIntervalSeconds,
    builder: (column) => ColumnOrderings(column),
  );
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

  GeneratedColumn<String> get stationUuid => $composableBuilder(
    column: $table.stationUuid,
    builder: (column) => column,
  );

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

  GeneratedColumn<int> get historyIntervalSeconds => $composableBuilder(
    column: $table.historyIntervalSeconds,
    builder: (column) => column,
  );
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
          (
            SensorTableData,
            BaseReferences<_$AppDatabase, $SensorTableTable, SensorTableData>,
          ),
          SensorTableData,
          PrefetchHooks Function()
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
                Value<String> stationUuid = const Value.absent(),
                Value<SensorElement> element = const Value.absent(),
                Value<String> storageUnitId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> recordIntervalSeconds = const Value.absent(),
                Value<int> historyIntervalSeconds = const Value.absent(),
              }) => SensorTableCompanion(
                id: id,
                stationUuid: stationUuid,
                element: element,
                storageUnitId: storageUnitId,
                name: name,
                recordIntervalSeconds: recordIntervalSeconds,
                historyIntervalSeconds: historyIntervalSeconds,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String stationUuid,
                required SensorElement element,
                required String storageUnitId,
                required String name,
                Value<int> recordIntervalSeconds = const Value.absent(),
                Value<int> historyIntervalSeconds = const Value.absent(),
              }) => SensorTableCompanion.insert(
                id: id,
                stationUuid: stationUuid,
                element: element,
                storageUnitId: storageUnitId,
                name: name,
                recordIntervalSeconds: recordIntervalSeconds,
                historyIntervalSeconds: historyIntervalSeconds,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        SensorTableData,
        BaseReferences<_$AppDatabase, $SensorTableTable, SensorTableData>,
      ),
      SensorTableData,
      PrefetchHooks Function()
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
typedef $$HistoryTableTableCreateCompanionBuilder =
    HistoryTableCompanion Function({
      Value<int> id,
      required int sensorId,
      Value<double?> value,
      required DateTime createdAt,
    });
typedef $$HistoryTableTableUpdateCompanionBuilder =
    HistoryTableCompanion Function({
      Value<int> id,
      Value<int> sensorId,
      Value<double?> value,
      Value<DateTime> createdAt,
    });

class $$HistoryTableTableFilterComposer
    extends Composer<_$AppDatabase, $HistoryTableTable> {
  $$HistoryTableTableFilterComposer({
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

  ColumnFilters<int> get sensorId => $composableBuilder(
    column: $table.sensorId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HistoryTableTableOrderingComposer
    extends Composer<_$AppDatabase, $HistoryTableTable> {
  $$HistoryTableTableOrderingComposer({
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

  ColumnOrderings<int> get sensorId => $composableBuilder(
    column: $table.sensorId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HistoryTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $HistoryTableTable> {
  $$HistoryTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get sensorId =>
      $composableBuilder(column: $table.sensorId, builder: (column) => column);

  GeneratedColumn<double> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$HistoryTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HistoryTableTable,
          HistoryTableData,
          $$HistoryTableTableFilterComposer,
          $$HistoryTableTableOrderingComposer,
          $$HistoryTableTableAnnotationComposer,
          $$HistoryTableTableCreateCompanionBuilder,
          $$HistoryTableTableUpdateCompanionBuilder,
          (
            HistoryTableData,
            BaseReferences<_$AppDatabase, $HistoryTableTable, HistoryTableData>,
          ),
          HistoryTableData,
          PrefetchHooks Function()
        > {
  $$HistoryTableTableTableManager(_$AppDatabase db, $HistoryTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HistoryTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HistoryTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HistoryTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> sensorId = const Value.absent(),
                Value<double?> value = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => HistoryTableCompanion(
                id: id,
                sensorId: sensorId,
                value: value,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int sensorId,
                Value<double?> value = const Value.absent(),
                required DateTime createdAt,
              }) => HistoryTableCompanion.insert(
                id: id,
                sensorId: sensorId,
                value: value,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HistoryTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HistoryTableTable,
      HistoryTableData,
      $$HistoryTableTableFilterComposer,
      $$HistoryTableTableOrderingComposer,
      $$HistoryTableTableAnnotationComposer,
      $$HistoryTableTableCreateCompanionBuilder,
      $$HistoryTableTableUpdateCompanionBuilder,
      (
        HistoryTableData,
        BaseReferences<_$AppDatabase, $HistoryTableTable, HistoryTableData>,
      ),
      HistoryTableData,
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
  $$HistoryTableTableTableManager get historyTable =>
      $$HistoryTableTableTableManager(_db, _db.historyTable);
}
