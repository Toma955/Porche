import Foundation
protocol MetricsProvider {
    var currentMetrics: BikeMetrics? { get }
    func startProviding() async
    func stopProviding()
}
