import 'package:base_core/common/config.dart';
import 'package:event_bus/event_bus.dart';

DelayEventBus eventBus = DelayEventBus();

class DelayEventBus extends EventBus {
  void fireInDelay(dynamic event, {Duration? delayTime}) {
    logger.d('AC4: EventBus.fireInDelay called - event: $event, delayTime: $delayTime');
    if (delayTime == null) {
      logger.d('AC4: Firing event immediately');
      super.fire(event);
    } else {
      logger.d('AC4: Scheduling event to fire after ${delayTime.inMilliseconds}ms');
      Future.delayed(delayTime, () {
        logger.d('AC4: Delayed event firing now - event: $event');
        super.fire(event);
        logger.d('AC4: Event fired successfully');
      });
    }
  }
}

enum RefreshType { dashboard, appointment, medical }

class RefreshPageEvent {
  final RefreshType type;

  RefreshPageEvent(this.type);
}

class ChangeTabEvent {
  final int index;

  ChangeTabEvent(this.index);
}
