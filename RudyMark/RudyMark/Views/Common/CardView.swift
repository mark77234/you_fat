////
////  Card.swift
////  RudyMark
////
////  Created by 이병찬 on 3/31/25.
////
import SwiftUI

struct CardView: View{
    let card: CardData
    
    var body: some View{
        VStack(alignment: .leading,spacing: 20){
            HStack{
                if card.main_title != nil {
                    Text(card.main_title ?? "메인 타이틀")
                        .font(.title2)
                        .bold()
                        .foregroundColor(card.mainTextColor)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                if card.title != nil {
                    Text(card.title ?? "카드 타이틀")
                        .font(.headline)
                        .bold()
                        .foregroundColor(card.mainTextColor)
                        .frame(maxWidth: .infinity,alignment: .leading)
                }
                
                if let progress = card.progress{
                    Text("\(Int(progress)) / \(Int(card.max ?? 2000)) kcal")
                        .foregroundColor(Color.gray)
                }
            }
            if let description = card.description{
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(card.subTextColor)
                    .frame(maxWidth: .infinity,alignment: .leading)
            }
            
            if let progress = card.progress{
                ProgressView(value: progress, total: card.max ?? 2000) // 일일 권장 칼로리
                    .progressViewStyle(LinearProgressViewStyle(tint: Color.yellowBar))
                    .scaleEffect(x: 1.0, y: 3.0)
            }
            if let blood_progress = card.blood_progress {
                GeometryReader { geometry in
                    ZStack {
                        ArcProgressView(progress: Double(blood_progress) / Double(card.max ?? 200), tint: card.blood_progress_color ?? .deepPurple)
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
            
            if let miniCards = card.miniCards {
                
                HStack{
                    ForEach(miniCards, id: \.title){ nutrient in
                        HStack{
                            MiniCardView(miniCard: nutrient,cardHeight: card.height)
                        }
                        .frame(maxWidth: .infinity,minHeight: card.miniCardsSize)
                        .background(card.miniCardsColor)
                        .cornerRadius(12)
                    }
                }
                
            }
            
            if let mealButtons = card.MealButtons {
                VStack {
                    ForEach(mealButtons, id: \.name) { button in
                        if let destination = button.destination {
                            NavigationLink(destination: destination) {
                                HStack {
                                    if let icon = button.icon {
                                        Image(systemName: icon)
                                    }
                                    
                                    Text(button.name)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(button.buttonColor)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                                
                            }
                        } else {
                            Button(action: {
                                print("\(button.name) 버튼이 눌렸습니다!")
                            }) {
                                HStack {
                                    if let icon = button.icon {
                                        Image(systemName: icon)
                                    }
                                    Text(button.name)
                                }
                                .padding()
                                .background(Color.gray.opacity(0.5)) // 비활성화 버튼 스타일
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            .disabled(true) // destination이 없으면 버튼 비활성화
                        }
                    }
                }
            }
            
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}

struct MiniCardView : View{
    let miniCard: MiniCard
    let cardHeight: CGFloat
    
    var body: some View{
        VStack(alignment: .leading){
            Text(miniCard.title)
                .font(.subheadline)
                .foregroundColor(.deepGray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)
                
            
            if let value = miniCard.value {
                Text("\(value)")
                    .padding(.leading, 10)
                    .foregroundColor(Color.black)
            }
            
            if let progress = miniCard.progress, let max = miniCard.max,let barColor = miniCard.barColor {
                Text("\(Int(progress)) / \(Int(max)) g")
                    .foregroundColor(Color.black)
                    .padding(.leading, 10)
                
                ProgressView(value: progress, total: max)
                    .progressViewStyle(LinearProgressViewStyle(tint: barColor))
                    .padding(.horizontal)
                    .scaleEffect(x: 1.0, y: 2.0)
            }
        }
        
    }
}

struct ArcProgressView: View {
    var progress: Double
    var tint: Color

    var body: some View {
        ZStack {
            ArcShape(progress: 1.0)
                .stroke(Color.gray.opacity(0.3), lineWidth: 10)
            ArcShape(progress: progress)
                .stroke(tint, style: StrokeStyle(lineWidth: 10, lineCap: .round))
        }
        .rotationEffect(.degrees(180)) // 거꾸로 U형
    }
}

struct ArcShape: Shape {
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
