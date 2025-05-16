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
        
        ZStack(alignment: .topTrailing) {
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
                        HStack {
                            Text(card.title ?? "카드 타이틀")
                                .font(.headline)
                                .bold()
                                .foregroundColor(card.mainTextColor)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                                    
                }
                if let description = card.description{
                    HStack(alignment: .center) {
                        Text(description)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                            .frame(alignment: .leading)
                    }
                    .padding(10)
                    .background(Color(red: 0.94, green: 0.92, blue: 0.99))
                    .cornerRadius(20)
                    
                }

                if let progress = card.progress {
                    VStack(alignment: .center) {
                        HStack(alignment: .center, spacing: 10) {
                            (
                                Text("\(Int(progress))").bold().foregroundColor(.black).font(.title)
                                + Text(" / \(Int(card.max ?? 2000)) kcal").foregroundColor(.gray).font(.title3)
                            )
                        }
                        .frame(height: 80)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)
                        .background(Color(red: 0.94, green: 0.92, blue: 0.99))
                        .cornerRadius(20)
                    }
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
                    
                    VStack{
                        ForEach(miniCards, id: \.title){ nutrient in
                            HStack{
                                MiniCardView(miniCard: nutrient,cardHeight: card.height)
                            }
                            .frame(maxWidth: .infinity,minHeight: card.miniCardsSize)
                            .background(card.miniCardsColor)
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
                                            icon
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:40,height:40)
                                        }
                                        Spacer()
                                        VStack{
                                            if let buttonName = button.name{
                                                Text(buttonName)
                                                    .font(.title3)
                                                    .bold()
                                            }
                                            if let lastBlood = button.lastBlood{
                                                Text(lastBlood)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                            if let lastDayKcal = button.lastDayKcal{
                                                Text(lastDayKcal)
                                                    .font(.subheadline)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                        Image(systemName: "plus.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.deepPurple)
                                        
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(button.buttonColor)
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                                    
                                }
                            } else {
                                Button(action: {
                                    print("버튼이 눌렸습니다!")
                                }) {
                                    HStack {
                                        if let icon = button.icon {
                                            icon
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:20,height:20)
                                        }
                                        VStack{
                                            if let buttonName = button.name{
                                                Text(buttonName)
                                                    .font(.title3)
                                                    .bold()
                                            }
                                            if let lastDayKcal = button.lastDayKcal{
                                                Text(lastDayKcal)
                                                    .font(.subheadline)
                                            }
                                        }
                                        
                                        Image(systemName: "plus.circle.fill")
                                            .foregroundColor(.deepPurple)
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.5)) // 비활성화 버튼 스타일
                                    .foregroundColor(.black)
                                    .cornerRadius(12)
                                }
                                .disabled(true) // destination이 없으면 버튼 비활성화
                            }
                        }
                    }
                }
                
                
            }
            if let cardIcon = card.cardIcon {
                ZStack {
                    cardIcon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 80, height: 80)
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
        VStack(alignment: .center){
            if let progress = miniCard.progress, let max = miniCard.max, let barColor = miniCard.barColor {
                HStack(alignment: .center,spacing:10) {
                    Text(miniCard.title)
                        .font(.subheadline)
                        .foregroundColor(.deepGray)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 140, height: 16)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(barColor)
                        .frame(width: min(CGFloat(progress / max) * 140, 140), height: 16)
                }
                    
                    (
                        Text("\(Int(progress))").bold().foregroundColor(.black)
                        + Text(" / \(Int(max)) g").foregroundColor(.black)
                    )
                }
                .frame(maxWidth: .infinity, alignment: .center)
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
