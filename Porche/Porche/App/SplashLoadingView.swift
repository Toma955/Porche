import SwiftUI

private enum SplashExitPhase {
    case running
    case hidingProgressBar
    case hidingLogo
}

struct SplashLoadingView: View {
    var progress: Double
    var onExitComplete: () -> Void

    @State private var logoAppeared = false
    @State private var barAppeared = false
    @State private var exitPhase: SplashExitPhase = .running

    private let entranceDuration: Double = 0.7
    private let barEntranceDelay: Double = 0.25
    private let exitBarDuration: Double = 0.45
    private let exitLogoDuration: Double = 0.55
    private let holdAtFullDuration: Double = 0.35

    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                Image("Porche")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200, maxHeight: 200)
                    .opacity(logoOpacity)
                    .scaleEffect(logoScale)
                    .animation(.easeOut(duration: entranceDuration), value: logoAppeared)
                    .animation(.easeOut(duration: exitLogoDuration), value: exitPhase)
                Spacer(minLength: 0)
                progressBar
            }
        }
        .onAppear {
            withAnimation(.easeOut(duration: entranceDuration)) {
                logoAppeared = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + barEntranceDelay) {
                withAnimation(.easeOut(duration: entranceDuration * 0.8)) {
                    barAppeared = true
                }
            }
        }
        .onChange(of: progress) { _, p in
            if p >= 1.0, exitPhase == .running {
                DispatchQueue.main.asyncAfter(deadline: .now() + holdAtFullDuration) {
                    withAnimation(.easeOut(duration: exitBarDuration)) {
                        exitPhase = .hidingProgressBar
                    }
                }
            }
        }
        .onChange(of: exitPhase) { _, phase in
            if phase == .hidingProgressBar {
                DispatchQueue.main.asyncAfter(deadline: .now() + exitBarDuration + 0.05) {
                    withAnimation(.easeOut(duration: exitLogoDuration)) {
                        exitPhase = .hidingLogo
                    }
                }
            } else if phase == .hidingLogo {
                DispatchQueue.main.asyncAfter(deadline: .now() + exitLogoDuration + 0.05) {
                    onExitComplete()
                }
            }
        }
    }

    private var logoOpacity: Double {
        if !logoAppeared { return 0 }
        if exitPhase == .hidingLogo { return 0 }
        return 1
    }

    private var logoScale: CGFloat {
        if !logoAppeared { return 0.88 }
        if exitPhase == .hidingLogo { return 0.96 }
        return 1
    }

    private var progressBar: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.black.opacity(0.2))
                    .frame(height: 4)
                Rectangle()
                    .fill(Color.black)
                    .frame(width: max(0, geo.size.width * progress), height: 4)
                    .animation(.easeInOut(duration: 0.25), value: progress)
            }
        }
        .frame(height: 4)
        .padding(.horizontal, 40)
        .padding(.bottom, 60)
        .opacity(progressBarOpacity)
        .animation(.easeOut(duration: exitBarDuration), value: exitPhase)
        .animation(.easeOut(duration: entranceDuration * 0.8), value: barAppeared)
    }

    private var progressBarOpacity: Double {
        if !barAppeared { return 0 }
        if exitPhase == .hidingProgressBar || exitPhase == .hidingLogo { return 0 }
        return 1
    }
}

#Preview {
    SplashLoadingView(progress: 0.65) {}
}
