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
        
        ZStack {
            VStack(alignment: .leading,spacing: 20){
                MainTitle(card: card)
                ProgressViewSection(card: card)
                BloodProgressViewSection(card: card)
                MiniCardsSection(card: card)
                MealButtonsSection(card: card)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity,minHeight: card.height)
        .background(card.backgroundColor)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}


struct ProgressViewSection: View {
    let card: CardData
    
    var body: some View {
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
    }
}



struct MiniCardsSection: View {
    let card: CardData
    
    var body: some View {
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
    }
}

struct MealButtonsSection: View {
    let card: CardData
    
    var body: some View {
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
                        .disabled(true) // destination이 없으면 버튼 비활성화
                    }
                }
            }
        }
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
