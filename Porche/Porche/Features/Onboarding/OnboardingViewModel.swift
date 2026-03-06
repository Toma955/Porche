import Foundation
@MainActor

// MARK: - OnboardingViewModel

final class OnboardingViewModel: ObservableObject {
    @Published var currentStep = 0
    @Published var isComplete = false
}
