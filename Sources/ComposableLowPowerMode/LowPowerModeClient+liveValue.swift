import Combine
import CombineExtras
import Foundation

extension LowPowerModeClient {
    
    public static var liveValue: LowPowerModeClient{
        let isEnabled: () -> Bool = {
            return ProcessInfo.processInfo.isLowPowerModeEnabled
        }
        
        let publisher = AnyPublisher<Void, Never> { subscriber in
            let observer = NotificationCenterObserver(subscriber: subscriber)
            return AnyCancellable { [observer] in
                _ = observer
            }
        }
        .map { _ in isEnabled() }
        .share()
        
        return LowPowerModeClient(
            isEnabled: isEnabled,
            isEnabledStream: publisher.asyncStream
        )
    }
}

private final class NotificationCenterObserver: NSObject {
    
    private let subscriber: Publishers.Custom<Void, Never>.Subscriber
    
    init(subscriber: Publishers.Custom<Void, Never>.Subscriber) {
        self.subscriber = subscriber
        super.init()
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(notificationHandler),
            name: .NSProcessInfoPowerStateDidChange,
            object: nil
        )
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc
    private func notificationHandler() {
        subscriber.send(value: ())
    }
}
