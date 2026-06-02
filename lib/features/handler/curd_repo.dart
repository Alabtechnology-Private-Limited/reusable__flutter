part of 'failer_and_success_handler.dart';

abstract class CurdRep {
  Future<String?> read();
  Future<void> write({required String value});
  Future<void> deletAll();
}
