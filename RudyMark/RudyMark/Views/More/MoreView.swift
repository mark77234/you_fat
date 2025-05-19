//
//  MoreView.swift
//  RudyMark
//
//  Created by Trudy on 5/19/25.
//

import SwiftUI

// MARK: - MoreView
import SwiftUI

struct MoreView: View {
    @EnvironmentObject private var viewModel: UserViewModel
    @State private var isEditing = false

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 0) {
                // 프로필 이미지와 이름
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.fill") // 캐릭터 이미지 대체
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.purple)
//                    Text(viewModel.name) 나중에 수정해야함
                    Text("포포")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.vertical, 20)

                // 사용자 정보 카드
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("사용자 정보")
                            .font(.setPretendard(weight: .semiBold, size: 19))
                        Spacer()
                        Button(action: {
                            isEditing = true
                        }) {
                            Text("수정") // 버튼 이미지로 바꿔 넣어야함
                                .font(.caption)
                                .padding(6)
                                .background(Color.purple.opacity(0.1))
                                .foregroundColor(.purple)
                                .cornerRadius(8)
                        }
                        .navigationDestination(isPresented: $isEditing){
                            ProfileSettingView()
                        }
                    }

                    Divider()
                        .background(.gray)

                    InfoRow(title: "키", value: "\(viewModel.height) cm")
                    
                    Divider()
                        .background(.gray)
                    
                    InfoRow(title: "몸무게", value: "\(viewModel.weight) kg")
                    
                    Divider()
                        .background(.gray)
                    
                    InfoRow(title: "성별", value: "\(viewModel.isMale ? "남자" : "여자")")
                    
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(radius: 2)

                Spacer()
            }
            .padding()
            .background(Color.skyblue.ignoresSafeArea())
            .navigationTitle("더보기")
            .navigationBarHidden(true)
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.gray)
                .font(.setPretendard(weight: .regular, size: 15))
            Text(value)
                .foregroundStyle(.black)
                .font(.setPretendard(weight: .regular, size: 18))
        }
    }
}



// MARK: - Preview
//struct MoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        MoreView()
//    }
//}
#Preview {
    let viewModel = UserViewModel()
    return MoreView()
        .environmentObject(viewModel)
}
