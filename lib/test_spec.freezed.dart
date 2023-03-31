// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'test_spec.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TestSpec _$TestSpecFromJson(Map<String, dynamic> json) {
  return _TestSpec.fromJson(json);
}

/// @nodoc
mixin _$TestSpec {
  String get section => throw _privateConstructorUsedError;
  List<dynamic> get variants => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestSpecCopyWith<TestSpec> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestSpecCopyWith<$Res> {
  factory $TestSpecCopyWith(TestSpec value, $Res Function(TestSpec) then) =
      _$TestSpecCopyWithImpl<$Res, TestSpec>;
  @useResult
  $Res call({String section, List<dynamic> variants});
}

/// @nodoc
class _$TestSpecCopyWithImpl<$Res, $Val extends TestSpec>
    implements $TestSpecCopyWith<$Res> {
  _$TestSpecCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? variants = null,
  }) {
    return _then(_value.copyWith(
      section: null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      variants: null == variants
          ? _value.variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TestSpecCopyWith<$Res> implements $TestSpecCopyWith<$Res> {
  factory _$$_TestSpecCopyWith(
          _$_TestSpec value, $Res Function(_$_TestSpec) then) =
      __$$_TestSpecCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String section, List<dynamic> variants});
}

/// @nodoc
class __$$_TestSpecCopyWithImpl<$Res>
    extends _$TestSpecCopyWithImpl<$Res, _$_TestSpec>
    implements _$$_TestSpecCopyWith<$Res> {
  __$$_TestSpecCopyWithImpl(
      _$_TestSpec _value, $Res Function(_$_TestSpec) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? section = null,
    Object? variants = null,
  }) {
    return _then(_$_TestSpec(
      null == section
          ? _value.section
          : section // ignore: cast_nullable_to_non_nullable
              as String,
      null == variants
          ? _value._variants
          : variants // ignore: cast_nullable_to_non_nullable
              as List<dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TestSpec implements _TestSpec {
  const _$_TestSpec(this.section, final List<dynamic> variants)
      : _variants = variants;

  factory _$_TestSpec.fromJson(Map<String, dynamic> json) =>
      _$$_TestSpecFromJson(json);

  @override
  final String section;
  final List<dynamic> _variants;
  @override
  List<dynamic> get variants {
    if (_variants is EqualUnmodifiableListView) return _variants;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_variants);
  }

  @override
  String toString() {
    return 'TestSpec(section: $section, variants: $variants)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TestSpec &&
            (identical(other.section, section) || other.section == section) &&
            const DeepCollectionEquality().equals(other._variants, _variants));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, section, const DeepCollectionEquality().hash(_variants));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TestSpecCopyWith<_$_TestSpec> get copyWith =>
      __$$_TestSpecCopyWithImpl<_$_TestSpec>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestSpecToJson(
      this,
    );
  }
}

abstract class _TestSpec implements TestSpec {
  const factory _TestSpec(final String section, final List<dynamic> variants) =
      _$_TestSpec;

  factory _TestSpec.fromJson(Map<String, dynamic> json) = _$_TestSpec.fromJson;

  @override
  String get section;
  @override
  List<dynamic> get variants;
  @override
  @JsonKey(ignore: true)
  _$$_TestSpecCopyWith<_$_TestSpec> get copyWith =>
      throw _privateConstructorUsedError;
}
