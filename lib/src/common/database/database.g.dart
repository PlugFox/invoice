// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class InvoiceTbl extends Table with TableInfo<InvoiceTbl, InvoiceTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InvoiceTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _deletedMeta = VerificationMeta('deleted');
  late final GeneratedColumn<int> deleted = GeneratedColumn<int>('deleted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>('created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _updatedAtMeta = VerificationMeta('updatedAt');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>('updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (updated_at >= created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _issuedAtMeta = VerificationMeta('issuedAt');
  late final GeneratedColumn<int> issuedAt = GeneratedColumn<int>('issued_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _dueAtMeta = VerificationMeta('dueAt');
  late final GeneratedColumn<int> dueAt = GeneratedColumn<int>('due_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _paidAtMeta = VerificationMeta('paidAt');
  late final GeneratedColumn<int> paidAt = GeneratedColumn<int>('paid_at', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _organizationIdMeta = VerificationMeta('organizationId');
  late final GeneratedColumn<int> organizationId = GeneratedColumn<int>('organization_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _counterpartyIdMeta = VerificationMeta('counterpartyId');
  late final GeneratedColumn<int> counterpartyId = GeneratedColumn<int>('counterparty_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _numberMeta = VerificationMeta('number');
  late final GeneratedColumn<String> number = GeneratedColumn<String>('number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _statusMeta = VerificationMeta('status');
  late final GeneratedColumn<int> status = GeneratedColumn<int>('status', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0 CHECK (status >= 0 AND status <= 3)',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _currencyMeta = VerificationMeta('currency');
  late final GeneratedColumn<String> currency = GeneratedColumn<String>('currency', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT \'USD\' CHECK (length(currency) = 3)',
      defaultValue: const CustomExpression('\'USD\''));
  static const VerificationMeta _totalMeta = VerificationMeta('total');
  late final GeneratedColumn<int> total = GeneratedColumn<int>('total', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0 CHECK (total >= 0)',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _descriptionMeta = VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>('description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        deleted,
        createdAt,
        updatedAt,
        issuedAt,
        dueAt,
        paidAt,
        organizationId,
        counterpartyId,
        number,
        status,
        currency,
        total,
        description
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<InvoiceTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta, deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('issued_at')) {
      context.handle(_issuedAtMeta, issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta));
    }
    if (data.containsKey('due_at')) {
      context.handle(_dueAtMeta, dueAt.isAcceptableOrUnknown(data['due_at']!, _dueAtMeta));
    }
    if (data.containsKey('paid_at')) {
      context.handle(_paidAtMeta, paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta));
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta, organizationId.isAcceptableOrUnknown(data['organization_id']!, _organizationIdMeta));
    }
    if (data.containsKey('counterparty_id')) {
      context.handle(
          _counterpartyIdMeta, counterpartyId.isAcceptableOrUnknown(data['counterparty_id']!, _counterpartyIdMeta));
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta, number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta, status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    }
    if (data.containsKey('currency')) {
      context.handle(_currencyMeta, currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta));
    }
    if (data.containsKey('total')) {
      context.handle(_totalMeta, total.isAcceptableOrUnknown(data['total']!, _totalMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      deleted: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}deleted'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      issuedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}issued_at'])!,
      dueAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}due_at']),
      paidAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}paid_at']),
      organizationId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}organization_id']),
      counterpartyId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}counterparty_id']),
      number: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}number']),
      status: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}status'])!,
      currency: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}currency'])!,
      total: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}total'])!,
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  InvoiceTbl createAlias(String alias) {
    return InvoiceTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class InvoiceTblData extends DataClass implements Insertable<InvoiceTblData> {
  /// Unique identifier of the organization
  final int id;

  /// 1 - Yes
  /// 0 - No
  /// Is the invoice deleted
  final int deleted;

  /// Created date (unixtime in seconds)
  final int createdAt;

  /// Updated date (unixtime in seconds)
  final int updatedAt;

  /// Invoice date
  final int issuedAt;

  /// Due date
  final int? dueAt;

  /// Paid date
  final int? paidAt;

  /// Organization identifier (organization_tbl)
  final int? organizationId;

  /// Counterparty identifier (organization_tbl)
  final int? counterpartyId;

  /// Invoice number, if not provided, it will be generated
  final String? number;

  /// 3 - Overdue
  /// 2 - Paid
  /// 1 - Sent
  /// 0 - Draft
  /// Status of the invoice
  final int status;

  /// Currency code
  final String currency;

  /// Invoice total amount
  final int total;

  /// Description of the invoice
  final String? description;
  const InvoiceTblData(
      {required this.id,
      required this.deleted,
      required this.createdAt,
      required this.updatedAt,
      required this.issuedAt,
      this.dueAt,
      this.paidAt,
      this.organizationId,
      this.counterpartyId,
      this.number,
      required this.status,
      required this.currency,
      required this.total,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deleted'] = Variable<int>(deleted);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['issued_at'] = Variable<int>(issuedAt);
    if (!nullToAbsent || dueAt != null) {
      map['due_at'] = Variable<int>(dueAt);
    }
    if (!nullToAbsent || paidAt != null) {
      map['paid_at'] = Variable<int>(paidAt);
    }
    if (!nullToAbsent || organizationId != null) {
      map['organization_id'] = Variable<int>(organizationId);
    }
    if (!nullToAbsent || counterpartyId != null) {
      map['counterparty_id'] = Variable<int>(counterpartyId);
    }
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['status'] = Variable<int>(status);
    map['currency'] = Variable<String>(currency);
    map['total'] = Variable<int>(total);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  InvoiceTblCompanion toCompanion(bool nullToAbsent) {
    return InvoiceTblCompanion(
      id: Value(id),
      deleted: Value(deleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      issuedAt: Value(issuedAt),
      dueAt: dueAt == null && nullToAbsent ? const Value.absent() : Value(dueAt),
      paidAt: paidAt == null && nullToAbsent ? const Value.absent() : Value(paidAt),
      organizationId: organizationId == null && nullToAbsent ? const Value.absent() : Value(organizationId),
      counterpartyId: counterpartyId == null && nullToAbsent ? const Value.absent() : Value(counterpartyId),
      number: number == null && nullToAbsent ? const Value.absent() : Value(number),
      status: Value(status),
      currency: Value(currency),
      total: Value(total),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
    );
  }

  factory InvoiceTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceTblData(
      id: serializer.fromJson<int>(json['id']),
      deleted: serializer.fromJson<int>(json['deleted']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      updatedAt: serializer.fromJson<int>(json['updated_at']),
      issuedAt: serializer.fromJson<int>(json['issued_at']),
      dueAt: serializer.fromJson<int?>(json['due_at']),
      paidAt: serializer.fromJson<int?>(json['paid_at']),
      organizationId: serializer.fromJson<int?>(json['organization_id']),
      counterpartyId: serializer.fromJson<int?>(json['counterparty_id']),
      number: serializer.fromJson<String?>(json['number']),
      status: serializer.fromJson<int>(json['status']),
      currency: serializer.fromJson<String>(json['currency']),
      total: serializer.fromJson<int>(json['total']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deleted': serializer.toJson<int>(deleted),
      'created_at': serializer.toJson<int>(createdAt),
      'updated_at': serializer.toJson<int>(updatedAt),
      'issued_at': serializer.toJson<int>(issuedAt),
      'due_at': serializer.toJson<int?>(dueAt),
      'paid_at': serializer.toJson<int?>(paidAt),
      'organization_id': serializer.toJson<int?>(organizationId),
      'counterparty_id': serializer.toJson<int?>(counterpartyId),
      'number': serializer.toJson<String?>(number),
      'status': serializer.toJson<int>(status),
      'currency': serializer.toJson<String>(currency),
      'total': serializer.toJson<int>(total),
      'description': serializer.toJson<String?>(description),
    };
  }

  InvoiceTblData copyWith(
          {int? id,
          int? deleted,
          int? createdAt,
          int? updatedAt,
          int? issuedAt,
          Value<int?> dueAt = const Value.absent(),
          Value<int?> paidAt = const Value.absent(),
          Value<int?> organizationId = const Value.absent(),
          Value<int?> counterpartyId = const Value.absent(),
          Value<String?> number = const Value.absent(),
          int? status,
          String? currency,
          int? total,
          Value<String?> description = const Value.absent()}) =>
      InvoiceTblData(
        id: id ?? this.id,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        issuedAt: issuedAt ?? this.issuedAt,
        dueAt: dueAt.present ? dueAt.value : this.dueAt,
        paidAt: paidAt.present ? paidAt.value : this.paidAt,
        organizationId: organizationId.present ? organizationId.value : this.organizationId,
        counterpartyId: counterpartyId.present ? counterpartyId.value : this.counterpartyId,
        number: number.present ? number.value : this.number,
        status: status ?? this.status,
        currency: currency ?? this.currency,
        total: total ?? this.total,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('InvoiceTblData(')
          ..write('id: $id, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('paidAt: $paidAt, ')
          ..write('organizationId: $organizationId, ')
          ..write('counterpartyId: $counterpartyId, ')
          ..write('number: $number, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('total: $total, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, deleted, createdAt, updatedAt, issuedAt, dueAt, paidAt, organizationId,
      counterpartyId, number, status, currency, total, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceTblData &&
          other.id == this.id &&
          other.deleted == this.deleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.issuedAt == this.issuedAt &&
          other.dueAt == this.dueAt &&
          other.paidAt == this.paidAt &&
          other.organizationId == this.organizationId &&
          other.counterpartyId == this.counterpartyId &&
          other.number == this.number &&
          other.status == this.status &&
          other.currency == this.currency &&
          other.total == this.total &&
          other.description == this.description);
}

class InvoiceTblCompanion extends UpdateCompanion<InvoiceTblData> {
  final Value<int> id;
  final Value<int> deleted;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> issuedAt;
  final Value<int?> dueAt;
  final Value<int?> paidAt;
  final Value<int?> organizationId;
  final Value<int?> counterpartyId;
  final Value<String?> number;
  final Value<int> status;
  final Value<String> currency;
  final Value<int> total;
  final Value<String?> description;
  const InvoiceTblCompanion({
    this.id = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.counterpartyId = const Value.absent(),
    this.number = const Value.absent(),
    this.status = const Value.absent(),
    this.currency = const Value.absent(),
    this.total = const Value.absent(),
    this.description = const Value.absent(),
  });
  InvoiceTblCompanion.insert({
    this.id = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.dueAt = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.counterpartyId = const Value.absent(),
    this.number = const Value.absent(),
    this.status = const Value.absent(),
    this.currency = const Value.absent(),
    this.total = const Value.absent(),
    this.description = const Value.absent(),
  });
  static Insertable<InvoiceTblData> custom({
    Expression<int>? id,
    Expression<int>? deleted,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? issuedAt,
    Expression<int>? dueAt,
    Expression<int>? paidAt,
    Expression<int>? organizationId,
    Expression<int>? counterpartyId,
    Expression<String>? number,
    Expression<int>? status,
    Expression<String>? currency,
    Expression<int>? total,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deleted != null) 'deleted': deleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (dueAt != null) 'due_at': dueAt,
      if (paidAt != null) 'paid_at': paidAt,
      if (organizationId != null) 'organization_id': organizationId,
      if (counterpartyId != null) 'counterparty_id': counterpartyId,
      if (number != null) 'number': number,
      if (status != null) 'status': status,
      if (currency != null) 'currency': currency,
      if (total != null) 'total': total,
      if (description != null) 'description': description,
    });
  }

  InvoiceTblCompanion copyWith(
      {Value<int>? id,
      Value<int>? deleted,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? issuedAt,
      Value<int?>? dueAt,
      Value<int?>? paidAt,
      Value<int?>? organizationId,
      Value<int?>? counterpartyId,
      Value<String?>? number,
      Value<int>? status,
      Value<String>? currency,
      Value<int>? total,
      Value<String?>? description}) {
    return InvoiceTblCompanion(
      id: id ?? this.id,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      issuedAt: issuedAt ?? this.issuedAt,
      dueAt: dueAt ?? this.dueAt,
      paidAt: paidAt ?? this.paidAt,
      organizationId: organizationId ?? this.organizationId,
      counterpartyId: counterpartyId ?? this.counterpartyId,
      number: number ?? this.number,
      status: status ?? this.status,
      currency: currency ?? this.currency,
      total: total ?? this.total,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<int>(deleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<int>(issuedAt.value);
    }
    if (dueAt.present) {
      map['due_at'] = Variable<int>(dueAt.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<int>(paidAt.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<int>(organizationId.value);
    }
    if (counterpartyId.present) {
      map['counterparty_id'] = Variable<int>(counterpartyId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (status.present) {
      map['status'] = Variable<int>(status.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceTblCompanion(')
          ..write('id: $id, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('dueAt: $dueAt, ')
          ..write('paidAt: $paidAt, ')
          ..write('organizationId: $organizationId, ')
          ..write('counterpartyId: $counterpartyId, ')
          ..write('number: $number, ')
          ..write('status: $status, ')
          ..write('currency: $currency, ')
          ..write('total: $total, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class ServiceTbl extends Table with TableInfo<ServiceTbl, ServiceTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ServiceTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _invoiceIdMeta = VerificationMeta('invoiceId');
  late final GeneratedColumn<int> invoiceId = GeneratedColumn<int>('invoice_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (invoice_id > 0)');
  static const VerificationMeta _numberMeta = VerificationMeta('number');
  late final GeneratedColumn<int> number = GeneratedColumn<int>('number', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (number > 0)');
  static const VerificationMeta _nameMeta = VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (length(name) > 0)');
  static const VerificationMeta _amountMeta = VerificationMeta('amount');
  late final GeneratedColumn<int> amount = GeneratedColumn<int>('amount', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (amount >= 0)');
  @override
  List<GeneratedColumn> get $columns => [id, invoiceId, number, name, amount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'service_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<ServiceTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('invoice_id')) {
      context.handle(_invoiceIdMeta, invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta));
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(_numberMeta, number.isAcceptableOrUnknown(data['number']!, _numberMeta));
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta, amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      invoiceId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}invoice_id'])!,
      number: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}number'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      amount: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}amount'])!,
    );
  }

  @override
  ServiceTbl createAlias(String alias) {
    return ServiceTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(invoice_id)REFERENCES invoice_tbl(id)ON UPDATE CASCADE ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class ServiceTblData extends DataClass implements Insertable<ServiceTblData> {
  /// Unique identifier of the organization
  final int id;

  /// Invoice identifier (invoice_tbl)
  final int invoiceId;

  /// Service number
  final int number;

  /// Name of the service
  final String name;

  /// Price of the service
  final int amount;
  const ServiceTblData(
      {required this.id, required this.invoiceId, required this.number, required this.name, required this.amount});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['invoice_id'] = Variable<int>(invoiceId);
    map['number'] = Variable<int>(number);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<int>(amount);
    return map;
  }

  ServiceTblCompanion toCompanion(bool nullToAbsent) {
    return ServiceTblCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      number: Value(number),
      name: Value(name),
      amount: Value(amount),
    );
  }

  factory ServiceTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceTblData(
      id: serializer.fromJson<int>(json['id']),
      invoiceId: serializer.fromJson<int>(json['invoice_id']),
      number: serializer.fromJson<int>(json['number']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<int>(json['amount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'invoice_id': serializer.toJson<int>(invoiceId),
      'number': serializer.toJson<int>(number),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<int>(amount),
    };
  }

  ServiceTblData copyWith({int? id, int? invoiceId, int? number, String? name, int? amount}) => ServiceTblData(
        id: id ?? this.id,
        invoiceId: invoiceId ?? this.invoiceId,
        number: number ?? this.number,
        name: name ?? this.name,
        amount: amount ?? this.amount,
      );
  @override
  String toString() {
    return (StringBuffer('ServiceTblData(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, invoiceId, number, name, amount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceTblData &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.number == this.number &&
          other.name == this.name &&
          other.amount == this.amount);
}

class ServiceTblCompanion extends UpdateCompanion<ServiceTblData> {
  final Value<int> id;
  final Value<int> invoiceId;
  final Value<int> number;
  final Value<String> name;
  final Value<int> amount;
  const ServiceTblCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.number = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
  });
  ServiceTblCompanion.insert({
    this.id = const Value.absent(),
    required int invoiceId,
    required int number,
    required String name,
    required int amount,
  })  : invoiceId = Value(invoiceId),
        number = Value(number),
        name = Value(name),
        amount = Value(amount);
  static Insertable<ServiceTblData> custom({
    Expression<int>? id,
    Expression<int>? invoiceId,
    Expression<int>? number,
    Expression<String>? name,
    Expression<int>? amount,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (number != null) 'number': number,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
    });
  }

  ServiceTblCompanion copyWith(
      {Value<int>? id, Value<int>? invoiceId, Value<int>? number, Value<String>? name, Value<int>? amount}) {
    return ServiceTblCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      number: number ?? this.number,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<int>(invoiceId.value);
    }
    if (number.present) {
      map['number'] = Variable<int>(number.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServiceTblCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('number: $number, ')
          ..write('name: $name, ')
          ..write('amount: $amount')
          ..write(')'))
        .toString();
  }
}

class OrganizationTbl extends Table with TableInfo<OrganizationTbl, OrganizationTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  OrganizationTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _deletedMeta = VerificationMeta('deleted');
  late final GeneratedColumn<int> deleted = GeneratedColumn<int>('deleted', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _createdAtMeta = VerificationMeta('createdAt');
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>('created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _updatedAtMeta = VerificationMeta('updatedAt');
  late final GeneratedColumn<int> updatedAt = GeneratedColumn<int>('updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (updated_at >= created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _typeMeta = VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>('type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT 0 CHECK (type = 0 OR type = 1)',
      defaultValue: const CustomExpression('0'));
  static const VerificationMeta _nameMeta = VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL UNIQUE CHECK (length(name) > 0)');
  static const VerificationMeta _addressMeta = VerificationMeta('address');
  late final GeneratedColumn<String> address = GeneratedColumn<String>('address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _taxMeta = VerificationMeta('tax');
  late final GeneratedColumn<String> tax = GeneratedColumn<String>('tax', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _descriptionMeta = VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>('description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, deleted, createdAt, updatedAt, type, name, address, tax, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'organization_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<OrganizationTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('deleted')) {
      context.handle(_deletedMeta, deleted.isAcceptableOrUnknown(data['deleted']!, _deletedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta, createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta, updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('tax')) {
      context.handle(_taxMeta, tax.isAcceptableOrUnknown(data['tax']!, _taxMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  OrganizationTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OrganizationTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      deleted: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}deleted'])!,
      createdAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}updated_at'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      tax: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}tax']),
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  OrganizationTbl createAlias(String alias) {
    return OrganizationTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class OrganizationTblData extends DataClass implements Insertable<OrganizationTblData> {
  /// Unique identifier of the organization
  final int id;

  /// 1 - Yes
  /// 0 - No
  /// Is the organization deleted?
  final int deleted;

  /// Created date (unixtime in seconds)
  final int createdAt;

  /// Updated date (unixtime in seconds)
  final int updatedAt;

  /// 1 - Counterparty
  /// 0 - Organization
  /// Organization or Counterparty?
  final int type;

  /// Name of the organization
  final String name;

  /// Address of the organization
  final String? address;

  /// Tax identification number of the organization
  final String? tax;

  /// Description of the organization
  /// NOT NULL PRIMARY CHECK (length(tax) > 0),
  final String? description;
  const OrganizationTblData(
      {required this.id,
      required this.deleted,
      required this.createdAt,
      required this.updatedAt,
      required this.type,
      required this.name,
      this.address,
      this.tax,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['deleted'] = Variable<int>(deleted);
    map['created_at'] = Variable<int>(createdAt);
    map['updated_at'] = Variable<int>(updatedAt);
    map['type'] = Variable<int>(type);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || tax != null) {
      map['tax'] = Variable<String>(tax);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  OrganizationTblCompanion toCompanion(bool nullToAbsent) {
    return OrganizationTblCompanion(
      id: Value(id),
      deleted: Value(deleted),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      type: Value(type),
      name: Value(name),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      tax: tax == null && nullToAbsent ? const Value.absent() : Value(tax),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
    );
  }

  factory OrganizationTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrganizationTblData(
      id: serializer.fromJson<int>(json['id']),
      deleted: serializer.fromJson<int>(json['deleted']),
      createdAt: serializer.fromJson<int>(json['created_at']),
      updatedAt: serializer.fromJson<int>(json['updated_at']),
      type: serializer.fromJson<int>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      tax: serializer.fromJson<String?>(json['tax']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'deleted': serializer.toJson<int>(deleted),
      'created_at': serializer.toJson<int>(createdAt),
      'updated_at': serializer.toJson<int>(updatedAt),
      'type': serializer.toJson<int>(type),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'tax': serializer.toJson<String?>(tax),
      'description': serializer.toJson<String?>(description),
    };
  }

  OrganizationTblData copyWith(
          {int? id,
          int? deleted,
          int? createdAt,
          int? updatedAt,
          int? type,
          String? name,
          Value<String?> address = const Value.absent(),
          Value<String?> tax = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      OrganizationTblData(
        id: id ?? this.id,
        deleted: deleted ?? this.deleted,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        type: type ?? this.type,
        name: name ?? this.name,
        address: address.present ? address.value : this.address,
        tax: tax.present ? tax.value : this.tax,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('OrganizationTblData(')
          ..write('id: $id, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('tax: $tax, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, deleted, createdAt, updatedAt, type, name, address, tax, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrganizationTblData &&
          other.id == this.id &&
          other.deleted == this.deleted &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.type == this.type &&
          other.name == this.name &&
          other.address == this.address &&
          other.tax == this.tax &&
          other.description == this.description);
}

class OrganizationTblCompanion extends UpdateCompanion<OrganizationTblData> {
  final Value<int> id;
  final Value<int> deleted;
  final Value<int> createdAt;
  final Value<int> updatedAt;
  final Value<int> type;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> tax;
  final Value<String?> description;
  const OrganizationTblCompanion({
    this.id = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.tax = const Value.absent(),
    this.description = const Value.absent(),
  });
  OrganizationTblCompanion.insert({
    this.id = const Value.absent(),
    this.deleted = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.type = const Value.absent(),
    required String name,
    this.address = const Value.absent(),
    this.tax = const Value.absent(),
    this.description = const Value.absent(),
  }) : name = Value(name);
  static Insertable<OrganizationTblData> custom({
    Expression<int>? id,
    Expression<int>? deleted,
    Expression<int>? createdAt,
    Expression<int>? updatedAt,
    Expression<int>? type,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? tax,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (deleted != null) 'deleted': deleted,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (tax != null) 'tax': tax,
      if (description != null) 'description': description,
    });
  }

  OrganizationTblCompanion copyWith(
      {Value<int>? id,
      Value<int>? deleted,
      Value<int>? createdAt,
      Value<int>? updatedAt,
      Value<int>? type,
      Value<String>? name,
      Value<String?>? address,
      Value<String?>? tax,
      Value<String?>? description}) {
    return OrganizationTblCompanion(
      id: id ?? this.id,
      deleted: deleted ?? this.deleted,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      type: type ?? this.type,
      name: name ?? this.name,
      address: address ?? this.address,
      tax: tax ?? this.tax,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (deleted.present) {
      map['deleted'] = Variable<int>(deleted.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<int>(updatedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (tax.present) {
      map['tax'] = Variable<String>(tax.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrganizationTblCompanion(')
          ..write('id: $id, ')
          ..write('deleted: $deleted, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('tax: $tax, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class ContactTbl extends Table with TableInfo<ContactTbl, ContactTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  ContactTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _organizationIdMeta = VerificationMeta('organizationId');
  late final GeneratedColumn<int> organizationId = GeneratedColumn<int>('organization_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (organization_id > 0)');
  static const VerificationMeta _typeMeta = VerificationMeta('type');
  late final GeneratedColumn<int> type = GeneratedColumn<int>('type', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (type >= 0 AND type <= 3)');
  static const VerificationMeta _valueMeta = VerificationMeta('value');
  late final GeneratedColumn<String> value = GeneratedColumn<String>('value', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (length(value) > 0)');
  static const VerificationMeta _descriptionMeta = VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>('description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, organizationId, type, value, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contact_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<ContactTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta, organizationId.isAcceptableOrUnknown(data['organization_id']!, _organizationIdMeta));
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('value')) {
      context.handle(_valueMeta, value.isAcceptableOrUnknown(data['value']!, _valueMeta));
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ContactTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      organizationId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}organization_id'])!,
      type: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}type'])!,
      value: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}value'])!,
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  ContactTbl createAlias(String alias) {
    return ContactTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(organization_id)REFERENCES organization_tbl(id)ON UPDATE CASCADE ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class ContactTblData extends DataClass implements Insertable<ContactTblData> {
  /// Unique identifier
  final int id;

  /// Organization identifier
  final int organizationId;

  /// 3 - Other
  /// 2 - Website
  /// 1 - Email
  /// 0 - Phone
  /// Contact type
  final int type;

  /// Contact value
  final String value;

  /// Description of the contact
  final String? description;
  const ContactTblData(
      {required this.id, required this.organizationId, required this.type, required this.value, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['organization_id'] = Variable<int>(organizationId);
    map['type'] = Variable<int>(type);
    map['value'] = Variable<String>(value);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  ContactTblCompanion toCompanion(bool nullToAbsent) {
    return ContactTblCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      type: Value(type),
      value: Value(value),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
    );
  }

  factory ContactTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactTblData(
      id: serializer.fromJson<int>(json['id']),
      organizationId: serializer.fromJson<int>(json['organization_id']),
      type: serializer.fromJson<int>(json['type']),
      value: serializer.fromJson<String>(json['value']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'organization_id': serializer.toJson<int>(organizationId),
      'type': serializer.toJson<int>(type),
      'value': serializer.toJson<String>(value),
      'description': serializer.toJson<String?>(description),
    };
  }

  ContactTblData copyWith(
          {int? id,
          int? organizationId,
          int? type,
          String? value,
          Value<String?> description = const Value.absent()}) =>
      ContactTblData(
        id: id ?? this.id,
        organizationId: organizationId ?? this.organizationId,
        type: type ?? this.type,
        value: value ?? this.value,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('ContactTblData(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, organizationId, type, value, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ContactTblData &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.type == this.type &&
          other.value == this.value &&
          other.description == this.description);
}

class ContactTblCompanion extends UpdateCompanion<ContactTblData> {
  final Value<int> id;
  final Value<int> organizationId;
  final Value<int> type;
  final Value<String> value;
  final Value<String?> description;
  const ContactTblCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.type = const Value.absent(),
    this.value = const Value.absent(),
    this.description = const Value.absent(),
  });
  ContactTblCompanion.insert({
    this.id = const Value.absent(),
    required int organizationId,
    required int type,
    required String value,
    this.description = const Value.absent(),
  })  : organizationId = Value(organizationId),
        type = Value(type),
        value = Value(value);
  static Insertable<ContactTblData> custom({
    Expression<int>? id,
    Expression<int>? organizationId,
    Expression<int>? type,
    Expression<String>? value,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (type != null) 'type': type,
      if (value != null) 'value': value,
      if (description != null) 'description': description,
    });
  }

  ContactTblCompanion copyWith(
      {Value<int>? id,
      Value<int>? organizationId,
      Value<int>? type,
      Value<String>? value,
      Value<String?>? description}) {
    return ContactTblCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      type: type ?? this.type,
      value: value ?? this.value,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<int>(organizationId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactTblCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('type: $type, ')
          ..write('value: $value, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class AccountTbl extends Table with TableInfo<AccountTbl, AccountTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  AccountTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _organizationIdMeta = VerificationMeta('organizationId');
  late final GeneratedColumn<int> organizationId = GeneratedColumn<int>('organization_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (organization_id > 0)');
  static const VerificationMeta _nameMeta = VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (length(name) > 0)');
  static const VerificationMeta _addressMeta = VerificationMeta('address');
  late final GeneratedColumn<String> address = GeneratedColumn<String>('address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _swiftMeta = VerificationMeta('swift');
  late final GeneratedColumn<String> swift = GeneratedColumn<String>('swift', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _ibanMeta = VerificationMeta('iban');
  late final GeneratedColumn<String> iban = GeneratedColumn<String>('iban', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _beneficiaryMeta = VerificationMeta('beneficiary');
  late final GeneratedColumn<String> beneficiary = GeneratedColumn<String>('beneficiary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _descriptionMeta = VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>('description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, organizationId, name, address, swift, iban, beneficiary, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'account_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<AccountTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('organization_id')) {
      context.handle(
          _organizationIdMeta, organizationId.isAcceptableOrUnknown(data['organization_id']!, _organizationIdMeta));
    } else if (isInserting) {
      context.missing(_organizationIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('swift')) {
      context.handle(_swiftMeta, swift.isAcceptableOrUnknown(data['swift']!, _swiftMeta));
    }
    if (data.containsKey('iban')) {
      context.handle(_ibanMeta, iban.isAcceptableOrUnknown(data['iban']!, _ibanMeta));
    }
    if (data.containsKey('beneficiary')) {
      context.handle(_beneficiaryMeta, beneficiary.isAcceptableOrUnknown(data['beneficiary']!, _beneficiaryMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AccountTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AccountTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      organizationId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}organization_id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      swift: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}swift']),
      iban: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}iban']),
      beneficiary: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}beneficiary']),
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  AccountTbl createAlias(String alias) {
    return AccountTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(organization_id)REFERENCES organization_tbl(id)ON UPDATE CASCADE ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class AccountTblData extends DataClass implements Insertable<AccountTblData> {
  /// Unique identifier
  final int id;

  /// Organization identifier
  final int organizationId;

  /// Name of the bank account
  final String name;

  /// Address of the bank
  final String? address;

  /// Society for Worldwide Interbank Financial Telecommunication
  /// SWIFT/BIC code of the bank account
  final String? swift;

  /// IBAN code of the bank account
  final String? iban;

  /// Name of beneficiary
  final String? beneficiary;

  /// Description of the bank account
  final String? description;
  const AccountTblData(
      {required this.id,
      required this.organizationId,
      required this.name,
      this.address,
      this.swift,
      this.iban,
      this.beneficiary,
      this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['organization_id'] = Variable<int>(organizationId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || swift != null) {
      map['swift'] = Variable<String>(swift);
    }
    if (!nullToAbsent || iban != null) {
      map['iban'] = Variable<String>(iban);
    }
    if (!nullToAbsent || beneficiary != null) {
      map['beneficiary'] = Variable<String>(beneficiary);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  AccountTblCompanion toCompanion(bool nullToAbsent) {
    return AccountTblCompanion(
      id: Value(id),
      organizationId: Value(organizationId),
      name: Value(name),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      swift: swift == null && nullToAbsent ? const Value.absent() : Value(swift),
      iban: iban == null && nullToAbsent ? const Value.absent() : Value(iban),
      beneficiary: beneficiary == null && nullToAbsent ? const Value.absent() : Value(beneficiary),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
    );
  }

  factory AccountTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AccountTblData(
      id: serializer.fromJson<int>(json['id']),
      organizationId: serializer.fromJson<int>(json['organization_id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      swift: serializer.fromJson<String?>(json['swift']),
      iban: serializer.fromJson<String?>(json['iban']),
      beneficiary: serializer.fromJson<String?>(json['beneficiary']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'organization_id': serializer.toJson<int>(organizationId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'swift': serializer.toJson<String?>(swift),
      'iban': serializer.toJson<String?>(iban),
      'beneficiary': serializer.toJson<String?>(beneficiary),
      'description': serializer.toJson<String?>(description),
    };
  }

  AccountTblData copyWith(
          {int? id,
          int? organizationId,
          String? name,
          Value<String?> address = const Value.absent(),
          Value<String?> swift = const Value.absent(),
          Value<String?> iban = const Value.absent(),
          Value<String?> beneficiary = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      AccountTblData(
        id: id ?? this.id,
        organizationId: organizationId ?? this.organizationId,
        name: name ?? this.name,
        address: address.present ? address.value : this.address,
        swift: swift.present ? swift.value : this.swift,
        iban: iban.present ? iban.value : this.iban,
        beneficiary: beneficiary.present ? beneficiary.value : this.beneficiary,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('AccountTblData(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('swift: $swift, ')
          ..write('iban: $iban, ')
          ..write('beneficiary: $beneficiary, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, organizationId, name, address, swift, iban, beneficiary, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AccountTblData &&
          other.id == this.id &&
          other.organizationId == this.organizationId &&
          other.name == this.name &&
          other.address == this.address &&
          other.swift == this.swift &&
          other.iban == this.iban &&
          other.beneficiary == this.beneficiary &&
          other.description == this.description);
}

class AccountTblCompanion extends UpdateCompanion<AccountTblData> {
  final Value<int> id;
  final Value<int> organizationId;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> swift;
  final Value<String?> iban;
  final Value<String?> beneficiary;
  final Value<String?> description;
  const AccountTblCompanion({
    this.id = const Value.absent(),
    this.organizationId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.swift = const Value.absent(),
    this.iban = const Value.absent(),
    this.beneficiary = const Value.absent(),
    this.description = const Value.absent(),
  });
  AccountTblCompanion.insert({
    this.id = const Value.absent(),
    required int organizationId,
    required String name,
    this.address = const Value.absent(),
    this.swift = const Value.absent(),
    this.iban = const Value.absent(),
    this.beneficiary = const Value.absent(),
    this.description = const Value.absent(),
  })  : organizationId = Value(organizationId),
        name = Value(name);
  static Insertable<AccountTblData> custom({
    Expression<int>? id,
    Expression<int>? organizationId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? swift,
    Expression<String>? iban,
    Expression<String>? beneficiary,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (organizationId != null) 'organization_id': organizationId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (swift != null) 'swift': swift,
      if (iban != null) 'iban': iban,
      if (beneficiary != null) 'beneficiary': beneficiary,
      if (description != null) 'description': description,
    });
  }

  AccountTblCompanion copyWith(
      {Value<int>? id,
      Value<int>? organizationId,
      Value<String>? name,
      Value<String?>? address,
      Value<String?>? swift,
      Value<String?>? iban,
      Value<String?>? beneficiary,
      Value<String?>? description}) {
    return AccountTblCompanion(
      id: id ?? this.id,
      organizationId: organizationId ?? this.organizationId,
      name: name ?? this.name,
      address: address ?? this.address,
      swift: swift ?? this.swift,
      iban: iban ?? this.iban,
      beneficiary: beneficiary ?? this.beneficiary,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (organizationId.present) {
      map['organization_id'] = Variable<int>(organizationId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (swift.present) {
      map['swift'] = Variable<String>(swift.value);
    }
    if (iban.present) {
      map['iban'] = Variable<String>(iban.value);
    }
    if (beneficiary.present) {
      map['beneficiary'] = Variable<String>(beneficiary.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AccountTblCompanion(')
          ..write('id: $id, ')
          ..write('organizationId: $organizationId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('swift: $swift, ')
          ..write('iban: $iban, ')
          ..write('beneficiary: $beneficiary, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class IntermediaryTbl extends Table with TableInfo<IntermediaryTbl, IntermediaryTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  IntermediaryTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _accountIdMeta = VerificationMeta('accountId');
  late final GeneratedColumn<int> accountId = GeneratedColumn<int>('account_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (account_id > 0)');
  static const VerificationMeta _nameMeta = VerificationMeta('name');
  late final GeneratedColumn<String> name = GeneratedColumn<String>('name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL CHECK (length(name) > 0)');
  static const VerificationMeta _addressMeta = VerificationMeta('address');
  late final GeneratedColumn<String> address = GeneratedColumn<String>('address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _swiftMeta = VerificationMeta('swift');
  late final GeneratedColumn<String> swift = GeneratedColumn<String>('swift', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _descriptionMeta = VerificationMeta('description');
  late final GeneratedColumn<String> description = GeneratedColumn<String>('description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, accountId, name, address, swift, description];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'intermediary_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<IntermediaryTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_id')) {
      context.handle(_accountIdMeta, accountId.isAcceptableOrUnknown(data['account_id']!, _accountIdMeta));
    } else if (isInserting) {
      context.missing(_accountIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta, address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('swift')) {
      context.handle(_swiftMeta, swift.isAcceptableOrUnknown(data['swift']!, _swiftMeta));
    }
    if (data.containsKey('description')) {
      context.handle(_descriptionMeta, description.isAcceptableOrUnknown(data['description']!, _descriptionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IntermediaryTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IntermediaryTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      accountId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}account_id'])!,
      name: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      address: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}address']),
      swift: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}swift']),
      description: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}description']),
    );
  }

  @override
  IntermediaryTbl createAlias(String alias) {
    return IntermediaryTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints =>
      const ['FOREIGN KEY(account_id)REFERENCES account_tbl(id)ON UPDATE CASCADE ON DELETE CASCADE'];
  @override
  bool get dontWriteConstraints => true;
}

class IntermediaryTblData extends DataClass implements Insertable<IntermediaryTblData> {
  /// Unique identifier
  final int id;

  /// Bank account identifier
  final int accountId;

  /// Name of the intermediary
  final String name;

  /// Address of the intermediary
  final String? address;

  /// Society for Worldwide Interbank Financial Telecommunication
  /// SWIFT/BIC code of the bank account
  final String? swift;

  /// Description of the intermediary
  final String? description;
  const IntermediaryTblData(
      {required this.id, required this.accountId, required this.name, this.address, this.swift, this.description});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_id'] = Variable<int>(accountId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || swift != null) {
      map['swift'] = Variable<String>(swift);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    return map;
  }

  IntermediaryTblCompanion toCompanion(bool nullToAbsent) {
    return IntermediaryTblCompanion(
      id: Value(id),
      accountId: Value(accountId),
      name: Value(name),
      address: address == null && nullToAbsent ? const Value.absent() : Value(address),
      swift: swift == null && nullToAbsent ? const Value.absent() : Value(swift),
      description: description == null && nullToAbsent ? const Value.absent() : Value(description),
    );
  }

  factory IntermediaryTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IntermediaryTblData(
      id: serializer.fromJson<int>(json['id']),
      accountId: serializer.fromJson<int>(json['account_id']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String?>(json['address']),
      swift: serializer.fromJson<String?>(json['swift']),
      description: serializer.fromJson<String?>(json['description']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'account_id': serializer.toJson<int>(accountId),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String?>(address),
      'swift': serializer.toJson<String?>(swift),
      'description': serializer.toJson<String?>(description),
    };
  }

  IntermediaryTblData copyWith(
          {int? id,
          int? accountId,
          String? name,
          Value<String?> address = const Value.absent(),
          Value<String?> swift = const Value.absent(),
          Value<String?> description = const Value.absent()}) =>
      IntermediaryTblData(
        id: id ?? this.id,
        accountId: accountId ?? this.accountId,
        name: name ?? this.name,
        address: address.present ? address.value : this.address,
        swift: swift.present ? swift.value : this.swift,
        description: description.present ? description.value : this.description,
      );
  @override
  String toString() {
    return (StringBuffer('IntermediaryTblData(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('swift: $swift, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, accountId, name, address, swift, description);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IntermediaryTblData &&
          other.id == this.id &&
          other.accountId == this.accountId &&
          other.name == this.name &&
          other.address == this.address &&
          other.swift == this.swift &&
          other.description == this.description);
}

class IntermediaryTblCompanion extends UpdateCompanion<IntermediaryTblData> {
  final Value<int> id;
  final Value<int> accountId;
  final Value<String> name;
  final Value<String?> address;
  final Value<String?> swift;
  final Value<String?> description;
  const IntermediaryTblCompanion({
    this.id = const Value.absent(),
    this.accountId = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.swift = const Value.absent(),
    this.description = const Value.absent(),
  });
  IntermediaryTblCompanion.insert({
    this.id = const Value.absent(),
    required int accountId,
    required String name,
    this.address = const Value.absent(),
    this.swift = const Value.absent(),
    this.description = const Value.absent(),
  })  : accountId = Value(accountId),
        name = Value(name);
  static Insertable<IntermediaryTblData> custom({
    Expression<int>? id,
    Expression<int>? accountId,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? swift,
    Expression<String>? description,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountId != null) 'account_id': accountId,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (swift != null) 'swift': swift,
      if (description != null) 'description': description,
    });
  }

  IntermediaryTblCompanion copyWith(
      {Value<int>? id,
      Value<int>? accountId,
      Value<String>? name,
      Value<String?>? address,
      Value<String?>? swift,
      Value<String?>? description}) {
    return IntermediaryTblCompanion(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      name: name ?? this.name,
      address: address ?? this.address,
      swift: swift ?? this.swift,
      description: description ?? this.description,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountId.present) {
      map['account_id'] = Variable<int>(accountId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (swift.present) {
      map['swift'] = Variable<String>(swift.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IntermediaryTblCompanion(')
          ..write('id: $id, ')
          ..write('accountId: $accountId, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('swift: $swift, ')
          ..write('description: $description')
          ..write(')'))
        .toString();
  }
}

class SettingsTbl extends Table with TableInfo<SettingsTbl, SettingsTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  SettingsTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = VerificationMeta('userId');
  late final GeneratedColumn<String> userId = GeneratedColumn<String>('user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _jsonDataMeta = VerificationMeta('jsonData');
  late final GeneratedColumn<String> jsonData = GeneratedColumn<String>('json_data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (length(json_data) > 2 AND json_valid(json_data))');
  static const VerificationMeta _memoMeta = VerificationMeta('memo');
  late final GeneratedColumn<String> memo = GeneratedColumn<String>('memo', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _metaCreatedAtMeta = VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>('meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta = VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>('meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns => [userId, jsonData, memo, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<SettingsTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta, userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('json_data')) {
      context.handle(_jsonDataMeta, jsonData.isAcceptableOrUnknown(data['json_data']!, _jsonDataMeta));
    } else if (isInserting) {
      context.missing(_jsonDataMeta);
    }
    if (data.containsKey('memo')) {
      context.handle(_memoMeta, memo.isAcceptableOrUnknown(data['memo']!, _memoMeta));
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta, metaCreatedAt.isAcceptableOrUnknown(data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta, metaUpdatedAt.isAcceptableOrUnknown(data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  SettingsTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SettingsTblData(
      userId: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      jsonData: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}json_data'])!,
      memo: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}memo']),
      metaCreatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  SettingsTbl createAlias(String alias) {
    return SettingsTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class SettingsTblData extends DataClass implements Insertable<SettingsTblData> {
  /// User ID
  final String userId;

  /// JSON data
  final String jsonData;

  /// Description
  final String? memo;

  /// Created date (unixtime in seconds)
  final int metaCreatedAt;

  /// Updated date (unixtime in seconds)
  final int metaUpdatedAt;
  const SettingsTblData(
      {required this.userId,
      required this.jsonData,
      this.memo,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['json_data'] = Variable<String>(jsonData);
    if (!nullToAbsent || memo != null) {
      map['memo'] = Variable<String>(memo);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  SettingsTblCompanion toCompanion(bool nullToAbsent) {
    return SettingsTblCompanion(
      userId: Value(userId),
      jsonData: Value(jsonData),
      memo: memo == null && nullToAbsent ? const Value.absent() : Value(memo),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory SettingsTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SettingsTblData(
      userId: serializer.fromJson<String>(json['user_id']),
      jsonData: serializer.fromJson<String>(json['json_data']),
      memo: serializer.fromJson<String?>(json['memo']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'user_id': serializer.toJson<String>(userId),
      'json_data': serializer.toJson<String>(jsonData),
      'memo': serializer.toJson<String?>(memo),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  SettingsTblData copyWith(
          {String? userId,
          String? jsonData,
          Value<String?> memo = const Value.absent(),
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      SettingsTblData(
        userId: userId ?? this.userId,
        jsonData: jsonData ?? this.jsonData,
        memo: memo.present ? memo.value : this.memo,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('SettingsTblData(')
          ..write('userId: $userId, ')
          ..write('jsonData: $jsonData, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(userId, jsonData, memo, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SettingsTblData &&
          other.userId == this.userId &&
          other.jsonData == this.jsonData &&
          other.memo == this.memo &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class SettingsTblCompanion extends UpdateCompanion<SettingsTblData> {
  final Value<String> userId;
  final Value<String> jsonData;
  final Value<String?> memo;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  final Value<int> rowid;
  const SettingsTblCompanion({
    this.userId = const Value.absent(),
    this.jsonData = const Value.absent(),
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsTblCompanion.insert({
    required String userId,
    required String jsonData,
    this.memo = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : userId = Value(userId),
        jsonData = Value(jsonData);
  static Insertable<SettingsTblData> custom({
    Expression<String>? userId,
    Expression<String>? jsonData,
    Expression<String>? memo,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (jsonData != null) 'json_data': jsonData,
      if (memo != null) 'memo': memo,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsTblCompanion copyWith(
      {Value<String>? userId,
      Value<String>? jsonData,
      Value<String?>? memo,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt,
      Value<int>? rowid}) {
    return SettingsTblCompanion(
      userId: userId ?? this.userId,
      jsonData: jsonData ?? this.jsonData,
      memo: memo ?? this.memo,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (jsonData.present) {
      map['json_data'] = Variable<String>(jsonData.value);
    }
    if (memo.present) {
      map['memo'] = Variable<String>(memo.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsTblCompanion(')
          ..write('userId: $userId, ')
          ..write('jsonData: $jsonData, ')
          ..write('memo: $memo, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class LogTbl extends Table with TableInfo<LogTbl, LogTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LogTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _timeMeta = VerificationMeta('time');
  late final GeneratedColumn<int> time = GeneratedColumn<int>('time', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _levelMeta = VerificationMeta('level');
  late final GeneratedColumn<int> level = GeneratedColumn<int>('level', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _messageMeta = VerificationMeta('message');
  late final GeneratedColumn<String> message = GeneratedColumn<String>('message', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _stackMeta = VerificationMeta('stack');
  late final GeneratedColumn<String> stack = GeneratedColumn<String>('stack', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, time, level, message, stack];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<LogTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('time')) {
      context.handle(_timeMeta, time.isAcceptableOrUnknown(data['time']!, _timeMeta));
    }
    if (data.containsKey('level')) {
      context.handle(_levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    } else if (isInserting) {
      context.missing(_levelMeta);
    }
    if (data.containsKey('message')) {
      context.handle(_messageMeta, message.isAcceptableOrUnknown(data['message']!, _messageMeta));
    } else if (isInserting) {
      context.missing(_messageMeta);
    }
    if (data.containsKey('stack')) {
      context.handle(_stackMeta, stack.isAcceptableOrUnknown(data['stack']!, _stackMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LogTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogTblData(
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      time: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}time'])!,
      level: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      message: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}message'])!,
      stack: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}stack']),
    );
  }

  @override
  LogTbl createAlias(String alias) {
    return LogTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class LogTblData extends DataClass implements Insertable<LogTblData> {
  /// req Unique identifier of the log
  final int id;

  /// Time is the timestamp (in seconds) of the log message
  final int time;

  /// Level is the severity level (a value between 0 and 6)
  final int level;

  /// req Message is the log message or error associated with this log event
  final String message;

  /// StackTrace a stack trace associated with this log event
  final String? stack;
  const LogTblData({required this.id, required this.time, required this.level, required this.message, this.stack});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['time'] = Variable<int>(time);
    map['level'] = Variable<int>(level);
    map['message'] = Variable<String>(message);
    if (!nullToAbsent || stack != null) {
      map['stack'] = Variable<String>(stack);
    }
    return map;
  }

  LogTblCompanion toCompanion(bool nullToAbsent) {
    return LogTblCompanion(
      id: Value(id),
      time: Value(time),
      level: Value(level),
      message: Value(message),
      stack: stack == null && nullToAbsent ? const Value.absent() : Value(stack),
    );
  }

  factory LogTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogTblData(
      id: serializer.fromJson<int>(json['id']),
      time: serializer.fromJson<int>(json['time']),
      level: serializer.fromJson<int>(json['level']),
      message: serializer.fromJson<String>(json['message']),
      stack: serializer.fromJson<String?>(json['stack']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'time': serializer.toJson<int>(time),
      'level': serializer.toJson<int>(level),
      'message': serializer.toJson<String>(message),
      'stack': serializer.toJson<String?>(stack),
    };
  }

  LogTblData copyWith({int? id, int? time, int? level, String? message, Value<String?> stack = const Value.absent()}) =>
      LogTblData(
        id: id ?? this.id,
        time: time ?? this.time,
        level: level ?? this.level,
        message: message ?? this.message,
        stack: stack.present ? stack.value : this.stack,
      );
  @override
  String toString() {
    return (StringBuffer('LogTblData(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, time, level, message, stack);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogTblData &&
          other.id == this.id &&
          other.time == this.time &&
          other.level == this.level &&
          other.message == this.message &&
          other.stack == this.stack);
}

class LogTblCompanion extends UpdateCompanion<LogTblData> {
  final Value<int> id;
  final Value<int> time;
  final Value<int> level;
  final Value<String> message;
  final Value<String?> stack;
  const LogTblCompanion({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    this.level = const Value.absent(),
    this.message = const Value.absent(),
    this.stack = const Value.absent(),
  });
  LogTblCompanion.insert({
    this.id = const Value.absent(),
    this.time = const Value.absent(),
    required int level,
    required String message,
    this.stack = const Value.absent(),
  })  : level = Value(level),
        message = Value(message);
  static Insertable<LogTblData> custom({
    Expression<int>? id,
    Expression<int>? time,
    Expression<int>? level,
    Expression<String>? message,
    Expression<String>? stack,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (time != null) 'time': time,
      if (level != null) 'level': level,
      if (message != null) 'message': message,
      if (stack != null) 'stack': stack,
    });
  }

  LogTblCompanion copyWith(
      {Value<int>? id, Value<int>? time, Value<int>? level, Value<String>? message, Value<String?>? stack}) {
    return LogTblCompanion(
      id: id ?? this.id,
      time: time ?? this.time,
      level: level ?? this.level,
      message: message ?? this.message,
      stack: stack ?? this.stack,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (stack.present) {
      map['stack'] = Variable<String>(stack.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogTblCompanion(')
          ..write('id: $id, ')
          ..write('time: $time, ')
          ..write('level: $level, ')
          ..write('message: $message, ')
          ..write('stack: $stack')
          ..write(')'))
        .toString();
  }
}

class LogPrefixTbl extends Table with TableInfo<LogPrefixTbl, LogPrefixTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LogPrefixTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _prefixMeta = VerificationMeta('prefix');
  late final GeneratedColumn<String> prefix = GeneratedColumn<String>('prefix', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _logIdMeta = VerificationMeta('logId');
  late final GeneratedColumn<int> logId = GeneratedColumn<int>('log_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _wordMeta = VerificationMeta('word');
  late final GeneratedColumn<String> word = GeneratedColumn<String>('word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _lenMeta = VerificationMeta('len');
  late final GeneratedColumn<int> len = GeneratedColumn<int>('len', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [prefix, logId, word, len];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'log_prefix_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<LogPrefixTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('prefix')) {
      context.handle(_prefixMeta, prefix.isAcceptableOrUnknown(data['prefix']!, _prefixMeta));
    } else if (isInserting) {
      context.missing(_prefixMeta);
    }
    if (data.containsKey('log_id')) {
      context.handle(_logIdMeta, logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta));
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('word')) {
      context.handle(_wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('len')) {
      context.handle(_lenMeta, len.isAcceptableOrUnknown(data['len']!, _lenMeta));
    } else if (isInserting) {
      context.missing(_lenMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {prefix, logId, word};
  @override
  LogPrefixTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LogPrefixTblData(
      prefix: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}prefix'])!,
      logId: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}log_id'])!,
      word: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      len: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}len'])!,
    );
  }

  @override
  LogPrefixTbl createAlias(String alias) {
    return LogPrefixTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const [
        'PRIMARY KEY(prefix, log_id, word)',
        'FOREIGN KEY(log_id)REFERENCES log_tbl(id)ON UPDATE CASCADE ON DELETE CASCADE'
      ];
  @override
  bool get dontWriteConstraints => true;
}

class LogPrefixTblData extends DataClass implements Insertable<LogPrefixTblData> {
  /// req Prefix (first 3 chars of word, lowercased)
  final String prefix;

  /// req Unique identifier
  /// CHECK(length(prefix) = 3)
  final int logId;

  /// req Word (3 or more chars, lowercased)
  final String word;

  /// req Word's length
  final int len;
  const LogPrefixTblData({required this.prefix, required this.logId, required this.word, required this.len});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['prefix'] = Variable<String>(prefix);
    map['log_id'] = Variable<int>(logId);
    map['word'] = Variable<String>(word);
    map['len'] = Variable<int>(len);
    return map;
  }

  LogPrefixTblCompanion toCompanion(bool nullToAbsent) {
    return LogPrefixTblCompanion(
      prefix: Value(prefix),
      logId: Value(logId),
      word: Value(word),
      len: Value(len),
    );
  }

  factory LogPrefixTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LogPrefixTblData(
      prefix: serializer.fromJson<String>(json['prefix']),
      logId: serializer.fromJson<int>(json['log_id']),
      word: serializer.fromJson<String>(json['word']),
      len: serializer.fromJson<int>(json['len']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'prefix': serializer.toJson<String>(prefix),
      'log_id': serializer.toJson<int>(logId),
      'word': serializer.toJson<String>(word),
      'len': serializer.toJson<int>(len),
    };
  }

  LogPrefixTblData copyWith({String? prefix, int? logId, String? word, int? len}) => LogPrefixTblData(
        prefix: prefix ?? this.prefix,
        logId: logId ?? this.logId,
        word: word ?? this.word,
        len: len ?? this.len,
      );
  @override
  String toString() {
    return (StringBuffer('LogPrefixTblData(')
          ..write('prefix: $prefix, ')
          ..write('logId: $logId, ')
          ..write('word: $word, ')
          ..write('len: $len')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(prefix, logId, word, len);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LogPrefixTblData &&
          other.prefix == this.prefix &&
          other.logId == this.logId &&
          other.word == this.word &&
          other.len == this.len);
}

class LogPrefixTblCompanion extends UpdateCompanion<LogPrefixTblData> {
  final Value<String> prefix;
  final Value<int> logId;
  final Value<String> word;
  final Value<int> len;
  final Value<int> rowid;
  const LogPrefixTblCompanion({
    this.prefix = const Value.absent(),
    this.logId = const Value.absent(),
    this.word = const Value.absent(),
    this.len = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LogPrefixTblCompanion.insert({
    required String prefix,
    required int logId,
    required String word,
    required int len,
    this.rowid = const Value.absent(),
  })  : prefix = Value(prefix),
        logId = Value(logId),
        word = Value(word),
        len = Value(len);
  static Insertable<LogPrefixTblData> custom({
    Expression<String>? prefix,
    Expression<int>? logId,
    Expression<String>? word,
    Expression<int>? len,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (prefix != null) 'prefix': prefix,
      if (logId != null) 'log_id': logId,
      if (word != null) 'word': word,
      if (len != null) 'len': len,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LogPrefixTblCompanion copyWith(
      {Value<String>? prefix, Value<int>? logId, Value<String>? word, Value<int>? len, Value<int>? rowid}) {
    return LogPrefixTblCompanion(
      prefix: prefix ?? this.prefix,
      logId: logId ?? this.logId,
      word: word ?? this.word,
      len: len ?? this.len,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (prefix.present) {
      map['prefix'] = Variable<String>(prefix.value);
    }
    if (logId.present) {
      map['log_id'] = Variable<int>(logId.value);
    }
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (len.present) {
      map['len'] = Variable<int>(len.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LogPrefixTblCompanion(')
          ..write('prefix: $prefix, ')
          ..write('logId: $logId, ')
          ..write('word: $word, ')
          ..write('len: $len, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class CharacteristicTbl extends Table with TableInfo<CharacteristicTbl, CharacteristicTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CharacteristicTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _typeMeta = VerificationMeta('type');
  late final GeneratedColumn<String> type = GeneratedColumn<String>('type', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (length(type) > 0 AND length(type) <= 255)');
  static const VerificationMeta _idMeta = VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>('id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  static const VerificationMeta _dataMeta = VerificationMeta('data');
  late final GeneratedColumn<String> data = GeneratedColumn<String>('data', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL CHECK (length(data) > 2 AND json_valid(data))');
  static const VerificationMeta _metaCreatedAtMeta = VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>('meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta = VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>('meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns => [type, id, data, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'characteristic_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<CharacteristicTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('type')) {
      context.handle(_typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('data')) {
      context.handle(_dataMeta, this.data.isAcceptableOrUnknown(data['data']!, _dataMeta));
    } else if (isInserting) {
      context.missing(_dataMeta);
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta, metaCreatedAt.isAcceptableOrUnknown(data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta, metaUpdatedAt.isAcceptableOrUnknown(data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {type, id};
  @override
  CharacteristicTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CharacteristicTblData(
      type: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      id: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      data: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}data'])!,
      metaCreatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  CharacteristicTbl createAlias(String alias) {
    return CharacteristicTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  List<String> get customConstraints => const ['PRIMARY KEY(type, id)'];
  @override
  bool get dontWriteConstraints => true;
}

class CharacteristicTblData extends DataClass implements Insertable<CharacteristicTblData> {
  /// req Type
  final String type;

  /// req ID
  final int id;

  /// JSON data
  final String data;

  /// Created date (unixtime in seconds)
  final int metaCreatedAt;

  /// Updated date (unixtime in seconds)
  final int metaUpdatedAt;
  const CharacteristicTblData(
      {required this.type,
      required this.id,
      required this.data,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['type'] = Variable<String>(type);
    map['id'] = Variable<int>(id);
    map['data'] = Variable<String>(data);
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  CharacteristicTblCompanion toCompanion(bool nullToAbsent) {
    return CharacteristicTblCompanion(
      type: Value(type),
      id: Value(id),
      data: Value(data),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory CharacteristicTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CharacteristicTblData(
      type: serializer.fromJson<String>(json['type']),
      id: serializer.fromJson<int>(json['id']),
      data: serializer.fromJson<String>(json['data']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'type': serializer.toJson<String>(type),
      'id': serializer.toJson<int>(id),
      'data': serializer.toJson<String>(data),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  CharacteristicTblData copyWith({String? type, int? id, String? data, int? metaCreatedAt, int? metaUpdatedAt}) =>
      CharacteristicTblData(
        type: type ?? this.type,
        id: id ?? this.id,
        data: data ?? this.data,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('CharacteristicTblData(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(type, id, data, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CharacteristicTblData &&
          other.type == this.type &&
          other.id == this.id &&
          other.data == this.data &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class CharacteristicTblCompanion extends UpdateCompanion<CharacteristicTblData> {
  final Value<String> type;
  final Value<int> id;
  final Value<String> data;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  final Value<int> rowid;
  const CharacteristicTblCompanion({
    this.type = const Value.absent(),
    this.id = const Value.absent(),
    this.data = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CharacteristicTblCompanion.insert({
    required String type,
    required int id,
    required String data,
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : type = Value(type),
        id = Value(id),
        data = Value(data);
  static Insertable<CharacteristicTblData> custom({
    Expression<String>? type,
    Expression<int>? id,
    Expression<String>? data,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (type != null) 'type': type,
      if (id != null) 'id': id,
      if (data != null) 'data': data,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CharacteristicTblCompanion copyWith(
      {Value<String>? type,
      Value<int>? id,
      Value<String>? data,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt,
      Value<int>? rowid}) {
    return CharacteristicTblCompanion(
      type: type ?? this.type,
      id: id ?? this.id,
      data: data ?? this.data,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (data.present) {
      map['data'] = Variable<String>(data.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CharacteristicTblCompanion(')
          ..write('type: $type, ')
          ..write('id: $id, ')
          ..write('data: $data, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class KvTbl extends Table with TableInfo<KvTbl, KvTblData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  KvTbl(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _kMeta = VerificationMeta('k');
  late final GeneratedColumn<String> k = GeneratedColumn<String>('k', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true, $customConstraints: 'NOT NULL PRIMARY KEY');
  static const VerificationMeta _vstringMeta = VerificationMeta('vstring');
  late final GeneratedColumn<String> vstring = GeneratedColumn<String>('vstring', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _vintMeta = VerificationMeta('vint');
  late final GeneratedColumn<int> vint = GeneratedColumn<int>('vint', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _vdoubleMeta = VerificationMeta('vdouble');
  late final GeneratedColumn<double> vdouble = GeneratedColumn<double>('vdouble', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _vboolMeta = VerificationMeta('vbool');
  late final GeneratedColumn<int> vbool = GeneratedColumn<int>('vbool', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false, $customConstraints: '');
  static const VerificationMeta _metaCreatedAtMeta = VerificationMeta('metaCreatedAt');
  late final GeneratedColumn<int> metaCreatedAt = GeneratedColumn<int>('meta_created_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\'))',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  static const VerificationMeta _metaUpdatedAtMeta = VerificationMeta('metaUpdatedAt');
  late final GeneratedColumn<int> metaUpdatedAt = GeneratedColumn<int>('meta_updated_at', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL DEFAULT (strftime(\'%s\', \'now\')) CHECK (meta_updated_at >= meta_created_at)',
      defaultValue: const CustomExpression('strftime(\'%s\', \'now\')'));
  @override
  List<GeneratedColumn> get $columns => [k, vstring, vint, vdouble, vbool, metaCreatedAt, metaUpdatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'kv_tbl';
  @override
  VerificationContext validateIntegrity(Insertable<KvTblData> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('k')) {
      context.handle(_kMeta, k.isAcceptableOrUnknown(data['k']!, _kMeta));
    } else if (isInserting) {
      context.missing(_kMeta);
    }
    if (data.containsKey('vstring')) {
      context.handle(_vstringMeta, vstring.isAcceptableOrUnknown(data['vstring']!, _vstringMeta));
    }
    if (data.containsKey('vint')) {
      context.handle(_vintMeta, vint.isAcceptableOrUnknown(data['vint']!, _vintMeta));
    }
    if (data.containsKey('vdouble')) {
      context.handle(_vdoubleMeta, vdouble.isAcceptableOrUnknown(data['vdouble']!, _vdoubleMeta));
    }
    if (data.containsKey('vbool')) {
      context.handle(_vboolMeta, vbool.isAcceptableOrUnknown(data['vbool']!, _vboolMeta));
    }
    if (data.containsKey('meta_created_at')) {
      context.handle(
          _metaCreatedAtMeta, metaCreatedAt.isAcceptableOrUnknown(data['meta_created_at']!, _metaCreatedAtMeta));
    }
    if (data.containsKey('meta_updated_at')) {
      context.handle(
          _metaUpdatedAtMeta, metaUpdatedAt.isAcceptableOrUnknown(data['meta_updated_at']!, _metaUpdatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {k};
  @override
  KvTblData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return KvTblData(
      k: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}k'])!,
      vstring: attachedDatabase.typeMapping.read(DriftSqlType.string, data['${effectivePrefix}vstring']),
      vint: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}vint']),
      vdouble: attachedDatabase.typeMapping.read(DriftSqlType.double, data['${effectivePrefix}vdouble']),
      vbool: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}vbool']),
      metaCreatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_created_at'])!,
      metaUpdatedAt: attachedDatabase.typeMapping.read(DriftSqlType.int, data['${effectivePrefix}meta_updated_at'])!,
    );
  }

  @override
  KvTbl createAlias(String alias) {
    return KvTbl(attachedDatabase, alias);
  }

  @override
  bool get isStrict => true;
  @override
  bool get dontWriteConstraints => true;
}

class KvTblData extends DataClass implements Insertable<KvTblData> {
  /// req Key
  final String k;

  /// string
  final String? vstring;

  /// Integer
  final int? vint;

  /// Float
  final double? vdouble;

  /// Boolean
  final int? vbool;

  /// req Created date (unixtime in seconds)
  ///vblob BLOB,
  /// Binary
  final int metaCreatedAt;

  /// req Updated date (unixtime in seconds)
  final int metaUpdatedAt;
  const KvTblData(
      {required this.k,
      this.vstring,
      this.vint,
      this.vdouble,
      this.vbool,
      required this.metaCreatedAt,
      required this.metaUpdatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['k'] = Variable<String>(k);
    if (!nullToAbsent || vstring != null) {
      map['vstring'] = Variable<String>(vstring);
    }
    if (!nullToAbsent || vint != null) {
      map['vint'] = Variable<int>(vint);
    }
    if (!nullToAbsent || vdouble != null) {
      map['vdouble'] = Variable<double>(vdouble);
    }
    if (!nullToAbsent || vbool != null) {
      map['vbool'] = Variable<int>(vbool);
    }
    map['meta_created_at'] = Variable<int>(metaCreatedAt);
    map['meta_updated_at'] = Variable<int>(metaUpdatedAt);
    return map;
  }

  KvTblCompanion toCompanion(bool nullToAbsent) {
    return KvTblCompanion(
      k: Value(k),
      vstring: vstring == null && nullToAbsent ? const Value.absent() : Value(vstring),
      vint: vint == null && nullToAbsent ? const Value.absent() : Value(vint),
      vdouble: vdouble == null && nullToAbsent ? const Value.absent() : Value(vdouble),
      vbool: vbool == null && nullToAbsent ? const Value.absent() : Value(vbool),
      metaCreatedAt: Value(metaCreatedAt),
      metaUpdatedAt: Value(metaUpdatedAt),
    );
  }

  factory KvTblData.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return KvTblData(
      k: serializer.fromJson<String>(json['k']),
      vstring: serializer.fromJson<String?>(json['vstring']),
      vint: serializer.fromJson<int?>(json['vint']),
      vdouble: serializer.fromJson<double?>(json['vdouble']),
      vbool: serializer.fromJson<int?>(json['vbool']),
      metaCreatedAt: serializer.fromJson<int>(json['meta_created_at']),
      metaUpdatedAt: serializer.fromJson<int>(json['meta_updated_at']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'k': serializer.toJson<String>(k),
      'vstring': serializer.toJson<String?>(vstring),
      'vint': serializer.toJson<int?>(vint),
      'vdouble': serializer.toJson<double?>(vdouble),
      'vbool': serializer.toJson<int?>(vbool),
      'meta_created_at': serializer.toJson<int>(metaCreatedAt),
      'meta_updated_at': serializer.toJson<int>(metaUpdatedAt),
    };
  }

  KvTblData copyWith(
          {String? k,
          Value<String?> vstring = const Value.absent(),
          Value<int?> vint = const Value.absent(),
          Value<double?> vdouble = const Value.absent(),
          Value<int?> vbool = const Value.absent(),
          int? metaCreatedAt,
          int? metaUpdatedAt}) =>
      KvTblData(
        k: k ?? this.k,
        vstring: vstring.present ? vstring.value : this.vstring,
        vint: vint.present ? vint.value : this.vint,
        vdouble: vdouble.present ? vdouble.value : this.vdouble,
        vbool: vbool.present ? vbool.value : this.vbool,
        metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
        metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('KvTblData(')
          ..write('k: $k, ')
          ..write('vstring: $vstring, ')
          ..write('vint: $vint, ')
          ..write('vdouble: $vdouble, ')
          ..write('vbool: $vbool, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(k, vstring, vint, vdouble, vbool, metaCreatedAt, metaUpdatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is KvTblData &&
          other.k == this.k &&
          other.vstring == this.vstring &&
          other.vint == this.vint &&
          other.vdouble == this.vdouble &&
          other.vbool == this.vbool &&
          other.metaCreatedAt == this.metaCreatedAt &&
          other.metaUpdatedAt == this.metaUpdatedAt);
}

class KvTblCompanion extends UpdateCompanion<KvTblData> {
  final Value<String> k;
  final Value<String?> vstring;
  final Value<int?> vint;
  final Value<double?> vdouble;
  final Value<int?> vbool;
  final Value<int> metaCreatedAt;
  final Value<int> metaUpdatedAt;
  final Value<int> rowid;
  const KvTblCompanion({
    this.k = const Value.absent(),
    this.vstring = const Value.absent(),
    this.vint = const Value.absent(),
    this.vdouble = const Value.absent(),
    this.vbool = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  KvTblCompanion.insert({
    required String k,
    this.vstring = const Value.absent(),
    this.vint = const Value.absent(),
    this.vdouble = const Value.absent(),
    this.vbool = const Value.absent(),
    this.metaCreatedAt = const Value.absent(),
    this.metaUpdatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : k = Value(k);
  static Insertable<KvTblData> custom({
    Expression<String>? k,
    Expression<String>? vstring,
    Expression<int>? vint,
    Expression<double>? vdouble,
    Expression<int>? vbool,
    Expression<int>? metaCreatedAt,
    Expression<int>? metaUpdatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (k != null) 'k': k,
      if (vstring != null) 'vstring': vstring,
      if (vint != null) 'vint': vint,
      if (vdouble != null) 'vdouble': vdouble,
      if (vbool != null) 'vbool': vbool,
      if (metaCreatedAt != null) 'meta_created_at': metaCreatedAt,
      if (metaUpdatedAt != null) 'meta_updated_at': metaUpdatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  KvTblCompanion copyWith(
      {Value<String>? k,
      Value<String?>? vstring,
      Value<int?>? vint,
      Value<double?>? vdouble,
      Value<int?>? vbool,
      Value<int>? metaCreatedAt,
      Value<int>? metaUpdatedAt,
      Value<int>? rowid}) {
    return KvTblCompanion(
      k: k ?? this.k,
      vstring: vstring ?? this.vstring,
      vint: vint ?? this.vint,
      vdouble: vdouble ?? this.vdouble,
      vbool: vbool ?? this.vbool,
      metaCreatedAt: metaCreatedAt ?? this.metaCreatedAt,
      metaUpdatedAt: metaUpdatedAt ?? this.metaUpdatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (k.present) {
      map['k'] = Variable<String>(k.value);
    }
    if (vstring.present) {
      map['vstring'] = Variable<String>(vstring.value);
    }
    if (vint.present) {
      map['vint'] = Variable<int>(vint.value);
    }
    if (vdouble.present) {
      map['vdouble'] = Variable<double>(vdouble.value);
    }
    if (vbool.present) {
      map['vbool'] = Variable<int>(vbool.value);
    }
    if (metaCreatedAt.present) {
      map['meta_created_at'] = Variable<int>(metaCreatedAt.value);
    }
    if (metaUpdatedAt.present) {
      map['meta_updated_at'] = Variable<int>(metaUpdatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('KvTblCompanion(')
          ..write('k: $k, ')
          ..write('vstring: $vstring, ')
          ..write('vint: $vint, ')
          ..write('vdouble: $vdouble, ')
          ..write('vbool: $vbool, ')
          ..write('metaCreatedAt: $metaCreatedAt, ')
          ..write('metaUpdatedAt: $metaUpdatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$Database extends GeneratedDatabase {
  _$Database(QueryExecutor e) : super(e);
  late final InvoiceTbl invoiceTbl = InvoiceTbl(this);
  late final Index invoiceCreatedAtIdx =
      Index('invoice_created_at_idx', 'CREATE INDEX IF NOT EXISTS invoice_created_at_idx ON invoice_tbl (created_at)');
  late final Index invoiceUpdatedAtIdx =
      Index('invoice_updated_at_idx', 'CREATE INDEX IF NOT EXISTS invoice_updated_at_idx ON invoice_tbl (updated_at)');
  late final Index invoiceIssuedAtIdx =
      Index('invoice_issued_at_idx', 'CREATE INDEX IF NOT EXISTS invoice_issued_at_idx ON invoice_tbl (issued_at)');
  late final Index invoiceDueAtIdx =
      Index('invoice_due_at_idx', 'CREATE INDEX IF NOT EXISTS invoice_due_at_idx ON invoice_tbl (due_at)');
  late final Index invoicePaidAtIdx =
      Index('invoice_paid_at_idx', 'CREATE INDEX IF NOT EXISTS invoice_paid_at_idx ON invoice_tbl (paid_at)');
  late final Index invoiceOrganizationIdIdx = Index('invoice_organization_id_idx',
      'CREATE INDEX IF NOT EXISTS invoice_organization_id_idx ON invoice_tbl (organization_id)');
  late final Index invoiceCounterpartyIdIdx = Index('invoice_counterparty_id_idx',
      'CREATE INDEX IF NOT EXISTS invoice_counterparty_id_idx ON invoice_tbl (counterparty_id)');
  late final Index invoiceStatusIdx =
      Index('invoice_status_idx', 'CREATE INDEX IF NOT EXISTS invoice_status_idx ON invoice_tbl (status)');
  late final Trigger invoiceUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS invoice_updated_at_trig AFTER UPDATE ON invoice_tbl BEGIN UPDATE invoice_tbl SET updated_at = strftime(\'%s\', \'now\') WHERE id = NEW.id;END',
      'invoice_updated_at_trig');
  late final ServiceTbl serviceTbl = ServiceTbl(this);
  late final Index serviceInvoiceIdIdx =
      Index('service_invoice_id_idx', 'CREATE INDEX IF NOT EXISTS service_invoice_id_idx ON service_tbl (invoice_id)');
  late final OrganizationTbl organizationTbl = OrganizationTbl(this);
  late final Index organizationCreatedAtIdx = Index('organization_created_at_idx',
      'CREATE INDEX IF NOT EXISTS organization_created_at_idx ON organization_tbl (created_at)');
  late final Index organizationUpdatedAtIdx = Index('organization_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS organization_updated_at_idx ON organization_tbl (updated_at)');
  late final Trigger organizationUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS organization_updated_at_trig AFTER UPDATE ON organization_tbl BEGIN UPDATE organization_tbl SET updated_at = strftime(\'%s\', \'now\') WHERE id = NEW.id;END',
      'organization_updated_at_trig');
  late final ContactTbl contactTbl = ContactTbl(this);
  late final Index contactOrganizationIdIdx = Index('contact_organization_id_idx',
      'CREATE INDEX IF NOT EXISTS contact_organization_id_idx ON contact_tbl (organization_id)');
  late final AccountTbl accountTbl = AccountTbl(this);
  late final Index accountOrganizationIdIdx = Index('account_organization_id_idx',
      'CREATE INDEX IF NOT EXISTS account_organization_id_idx ON account_tbl (organization_id)');
  late final IntermediaryTbl intermediaryTbl = IntermediaryTbl(this);
  late final Index intermediaryAccountIdIdx = Index('intermediary_account_id_idx',
      'CREATE INDEX IF NOT EXISTS intermediary_account_id_idx ON intermediary_tbl (account_id)');
  late final SettingsTbl settingsTbl = SettingsTbl(this);
  late final Trigger settingsMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS settings_meta_updated_at_trig AFTER UPDATE ON settings_tbl BEGIN UPDATE settings_tbl SET meta_updated_at = strftime(\'%s\', \'now\') WHERE user_id = NEW.user_id;END',
      'settings_meta_updated_at_trig');
  late final LogTbl logTbl = LogTbl(this);
  late final Index logTimeIdx = Index('log_time_idx', 'CREATE INDEX IF NOT EXISTS log_time_idx ON log_tbl (time)');
  late final Index logLevelIdx = Index('log_level_idx', 'CREATE INDEX IF NOT EXISTS log_level_idx ON log_tbl (level)');
  late final LogPrefixTbl logPrefixTbl = LogPrefixTbl(this);
  late final Index logPrefixPrefixIdx =
      Index('log_prefix_prefix_idx', 'CREATE INDEX IF NOT EXISTS log_prefix_prefix_idx ON log_prefix_tbl (prefix)');
  late final Index logPrefixLogIdIdx =
      Index('log_prefix_log_id_idx', 'CREATE INDEX IF NOT EXISTS log_prefix_log_id_idx ON log_prefix_tbl (log_id)');
  late final Index logPrefixLenIdx =
      Index('log_prefix_len_idx', 'CREATE INDEX IF NOT EXISTS log_prefix_len_idx ON log_prefix_tbl (len)');
  late final CharacteristicTbl characteristicTbl = CharacteristicTbl(this);
  late final Index characteristicMetaCreatedAtIdx = Index('characteristic_meta_created_at_idx',
      'CREATE INDEX IF NOT EXISTS characteristic_meta_created_at_idx ON characteristic_tbl (meta_created_at)');
  late final Index characteristicMetaUpdatedAtIdx = Index('characteristic_meta_updated_at_idx',
      'CREATE INDEX IF NOT EXISTS characteristic_meta_updated_at_idx ON characteristic_tbl (meta_updated_at)');
  late final Trigger characteristicMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS characteristic_meta_updated_at_trig AFTER UPDATE ON characteristic_tbl BEGIN UPDATE characteristic_tbl SET meta_updated_at = strftime(\'%s\', \'now\') WHERE type = NEW.type AND id = NEW.id;END',
      'characteristic_meta_updated_at_trig');
  late final KvTbl kvTbl = KvTbl(this);
  late final Index kvMetaCreatedAtIdx =
      Index('kv_meta_created_at_idx', 'CREATE INDEX IF NOT EXISTS kv_meta_created_at_idx ON kv_tbl (meta_created_at)');
  late final Index kvMetaUpdatedAtIdx =
      Index('kv_meta_updated_at_idx', 'CREATE INDEX IF NOT EXISTS kv_meta_updated_at_idx ON kv_tbl (meta_updated_at)');
  late final Trigger kvMetaUpdatedAtTrig = Trigger(
      'CREATE TRIGGER IF NOT EXISTS kv_meta_updated_at_trig AFTER UPDATE ON kv_tbl BEGIN UPDATE kv_tbl SET meta_updated_at = strftime(\'%s\', \'now\') WHERE k = NEW.k;END',
      'kv_meta_updated_at_trig');
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        invoiceTbl,
        invoiceCreatedAtIdx,
        invoiceUpdatedAtIdx,
        invoiceIssuedAtIdx,
        invoiceDueAtIdx,
        invoicePaidAtIdx,
        invoiceOrganizationIdIdx,
        invoiceCounterpartyIdIdx,
        invoiceStatusIdx,
        invoiceUpdatedAtTrig,
        serviceTbl,
        serviceInvoiceIdIdx,
        organizationTbl,
        organizationCreatedAtIdx,
        organizationUpdatedAtIdx,
        organizationUpdatedAtTrig,
        contactTbl,
        contactOrganizationIdIdx,
        accountTbl,
        accountOrganizationIdIdx,
        intermediaryTbl,
        intermediaryAccountIdIdx,
        settingsTbl,
        settingsMetaUpdatedAtTrig,
        logTbl,
        logTimeIdx,
        logLevelIdx,
        logPrefixTbl,
        logPrefixPrefixIdx,
        logPrefixLogIdIdx,
        logPrefixLenIdx,
        characteristicTbl,
        characteristicMetaCreatedAtIdx,
        characteristicMetaUpdatedAtIdx,
        characteristicMetaUpdatedAtTrig,
        kvTbl,
        kvMetaCreatedAtIdx,
        kvMetaUpdatedAtIdx,
        kvMetaUpdatedAtTrig
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('invoice_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('invoice_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('invoice_tbl', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('service_tbl', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('invoice_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('service_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('organization_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('organization_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('organization_tbl', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('contact_tbl', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('organization_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('contact_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('organization_tbl', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('account_tbl', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('organization_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('account_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('account_tbl', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('intermediary_tbl', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('account_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('intermediary_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('settings_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('settings_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log_tbl', limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('log_prefix_tbl', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('log_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('log_prefix_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('characteristic_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('characteristic_tbl', kind: UpdateKind.update),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('kv_tbl', limitUpdateKind: UpdateKind.update),
            result: [
              TableUpdate('kv_tbl', kind: UpdateKind.update),
            ],
          ),
        ],
      );
}
