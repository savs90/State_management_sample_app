import 'package:flutter/widgets.dart';
import './basestate.logic.dart';

class BaseStateWidget<T extends BaseState, DataType> extends StatelessWidget {
  final T state;
  final Widget Function(DataType) builder;
  final Widget Function(DataType)? onClose;
  final Widget Function(dynamic)? onError;

  const BaseStateWidget({
    required this.state,
    required this.builder,
    this.onClose,
    this.onError,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      initialData: state.state,
      stream: state.stream,
      builder: (context, snapshot) {
        if (snapshot.hasError == true) {
          return onError?.call(snapshot.error) ?? const SizedBox();
        } else if (snapshot.hasData) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return builder(snapshot.data as DataType);
            case ConnectionState.done:
              return onClose?.call(snapshot.data as DataType) ?? const SizedBox();
          }
        }
        return const SizedBox();
      },
    );
    //return builder(context, d);
  }
}
