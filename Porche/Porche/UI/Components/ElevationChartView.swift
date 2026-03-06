import SwiftUI


// MARK: - ElevationChartView

struct ElevationChartView: View {
    var elevationData: [Double] = []
    var body: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let pts = elevationData
            if pts.isEmpty {
                Text("Visinska profil")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                let minE = pts.min() ?? 0
                let maxE = (pts.max() ?? 0) - minE
                let range = maxE > 0 ? maxE : 1
                let stepX = pts.count > 1 ? w / CGFloat(pts.count - 1) : 0
                ZStack(alignment: .bottomLeading) {
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.primary.opacity(0.08))
                        .frame(width: w, height: h)
                    Path { path in
                        guard pts.count >= 2 else { return }
                        path.move(to: CGPoint(x: 0, y: h - CGFloat((pts[0] - minE) / range) * (h - 4) - 2))
                        for i in 1..<pts.count {
                            let x = CGFloat(i) * stepX
                            let y = h - CGFloat((pts[i] - minE) / range) * (h - 4) - 2
                            path.addLine(to: CGPoint(x: x, y: y))
                        }
                    }
                    .stroke(Color.accentColor, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
                    .frame(width: w, height: h)
                }
                .frame(width: w, height: h)
            }
        }
    }
}
