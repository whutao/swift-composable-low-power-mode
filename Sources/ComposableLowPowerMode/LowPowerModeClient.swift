import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct LowPowerModeClient: DependencyKey, Sendable {
    
    /// Returns the current state of the low-power mode.
    public var isEnabled: () -> Bool = { false }
    
    /// Returns a stream the low-power mode states .
    public var isEnabledStream: () -> AsyncStream<Bool> = { .finished }
}

extension DependencyValues {
    
    /// A dependency for observing the power state of the device.
    public var lowPowerModeClient: LowPowerModeClient {
        get { self[LowPowerModeClient.self] }
        set { self[LowPowerModeClient.self] = newValue }
    }
}
