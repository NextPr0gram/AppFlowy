import 'package:appflowy_backend/protobuf/flowy-database2/protobuf.dart';
import 'package:dartz/dartz.dart';
import 'package:appflowy_backend/dispatch/dispatch.dart';
import 'package:appflowy_backend/protobuf/flowy-error/errors.pb.dart';

class TypeOptionBackendService {
  final String viewId;
  final String fieldId;

  TypeOptionBackendService({
    required this.viewId,
    required this.fieldId,
  });

  Future<Either<SelectOptionPB, FlowyError>> newOption({
    required String name,
  }) {
    final payload = CreateSelectOptionPayloadPB.create()
      ..optionName = name
      ..viewId = viewId
      ..fieldId = fieldId;

    return DatabaseEventCreateSelectOption(payload).send();
  }

  static Future<Either<TypeOptionPB, FlowyError>> createFieldTypeOption({
    required String viewId,
    FieldType fieldType = FieldType.RichText,
    CreateFieldPosition position = CreateFieldPosition.End,
    String? targetFieldId,
  }) {
    final payload = CreateFieldPayloadPB.create()
      ..viewId = viewId
      ..fieldType = FieldType.RichText;

    if (position == CreateFieldPosition.Before ||
        position == CreateFieldPosition.After && targetFieldId != null) {
      payload.targetFieldId = targetFieldId!;
    }

    payload.fieldPosition = position;

    return DatabaseEventCreateField(payload).send();
  }
}
