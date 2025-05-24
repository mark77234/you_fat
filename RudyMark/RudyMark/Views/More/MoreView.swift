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
                HStack {
                    Text("더보기")
                        .font(.setPretendard(weight: .bold, size: 20))
                        .foregroundStyle(.black)
                    Spacer()
                }
                // 프로필 이미지와 이름
                VStack(spacing: 8) {
                    Image("previewProfile") // 캐릭터 이미지 대체
                        .resizable()
                        .frame(width: 92, height: 92)
//                    Text(viewModel.name) 나중에 수정해야함
                    Text(viewModel.name)
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, 20)

                // 사용자 정보 카드
                CardContainerView {
                    HStack {
                        Text("사용자 정보")
                            .font(.setPretendard(weight: .semiBold, size: 16))
                        Spacer()
                        Button(action: {
                            isEditing = true
                        }) {
                            Image("modifyButton")
                                .padding(3)
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
                
                // 알림 설정 버튼
                NavigationLink(destination: NotificationSetView(), label: {
                    CardContainerView {
                        HStack {
                            Text("알림 설정")
                            Spacer()
                            Image(systemName: "chevron.right")
                        }
                    }
                })
                .foregroundStyle(.black)
                
                CardContainerView {
                    Text("공지사항")
                        .font(.setPretendard(weight: .medium, size: 15))
                    
                    Divider()
                        .background(.gray)
                    
                    Text("약관 및 정책")
                        .font(.setPretendard(weight: .medium, size: 15))
                    
                    Divider()
                        .background(.gray)
                    
                    Text("앱 정보")
                        .font(.setPretendard(weight: .medium, size: 15))

                }
                
                Spacer()
            }
            .padding()
            .background(Color.skyblue.ignoresSafeArea())
        }
    }
}

struct InfoRow: View {
    let title: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .foregroundStyle(.gray)
                .font(.setPretendard(weight: .regular, size: 12))
            Text(value)
                .foregroundStyle(.black)
                .font(.setPretendard(weight: .regular, size: 14))
        }
    }
}

#Preview {
    let viewModel = UserViewModel()
    return MoreView()
        .environmentObject(viewModel)
}
