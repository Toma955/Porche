import Foundation
@MainActor
final class OnboardingViewModel: ObservableObject {
    @Published var currentStep = 0
    @Published var isComplete = false
}
