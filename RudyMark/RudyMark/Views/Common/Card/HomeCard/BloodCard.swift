//
//  BloodCard.swift
//  RudyMark
//
//  Created by 이병찬 on 5/20/25.
//
import SwiftUI

struct BloodCard: View {
    let card: CardData
    
    var body: some View {
        if let blood_progress = card.blood_progress {
            GeometryReader { geometry in
                ZStack {
                    ReverseUProgressView(progress: Double(blood_progress) / Double(card.max ?? 200), tint: card.blood_progress_color ?? .deepPurple)
                        .frame(height: geometry.size.width * 0.5)
                    VStack(spacing: 4) {
                        if let blood_count = card.blood_count {
                            Text("\(blood_count)회")
                                .font(.subheadline)
                                .foregroundColor(Color.gray)
                        }
                        Text(card.stat ?? "미측정")
                            .font(.title3)
                            .bold()
                        Text("\(Int(blood_progress))mg/dL")
                            .foregroundColor(Color.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 60)
                    
                }
                .padding(20)
            }
            .frame(height: 100)
            .padding(.bottom, 20)
        }
    }
}


struct ReverseUProgressView: View {
    var progress: Double
    var tint: Color
    
    var body: some View {
        ZStack {
            ReverseUShape(progress: 1.0)
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            ReverseUShape(progress: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        }
        .rotationEffect(.degrees(180)) // 거꾸로 U형
    }
}

struct ReverseUShape: Shape {
    var progress: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = min(rect.width, rect.height) / 1.5
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let startAngle = Angle.degrees(0)
        let endAngle = Angle.degrees(180 * progress)
        
        path.addArc(center: center,
                    radius: radius,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        path = path.strokedPath(StrokeStyle(lineWidth: 10, lineCap: .round))
        return path
    }
    
    var animatableData: Double {
        get { progress }
        set { progress = newValue }
    }
}
