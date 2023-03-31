import 'package:freezed_annotation/freezed_annotation.dart';

part 'test_spec.freezed.dart';
part 'test_spec.g.dart';

@freezed
class TestSpec with _$TestSpec {
  const factory TestSpec(
    String section,
    List variants,
  ) = _TestSpec;

  factory TestSpec.fromJson(Map<String, dynamic> json) => _$TestSpecFromJson(json);
}
