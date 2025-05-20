import SwiftUI

struct MainTitleView: View {
    let card: CardData
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading){
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
                
                if let popoMessage = card.popoMessage{
                    HStack(alignment: .center) {
                        Text(popoMessage)
                            .font(.subheadline)
                            .bold()
                            .foregroundColor(Color.black)
                            .frame(alignment: .leading)
                    }
                    .padding(10)
                    .background(Color(red: 0.94, green: 0.92, blue: 0.99))
                    .cornerRadius(20)
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
    }
}
