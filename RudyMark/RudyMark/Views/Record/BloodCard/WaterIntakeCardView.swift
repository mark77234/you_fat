//
//  WaterIntakeCardView.swift
//  RudyMark
//
//  Created by 이병찬 on 5/24/25.
//

import SwiftUI


struct WaterIntakeCardView: View {
    @Binding var cups: Int
    let maxCups: Int = 10

    var body: some View {
        VStack(spacing: 16) {
            Text("물 섭취량\n(1컵 - 200ml)")
                .font(.headline)
                .multilineTextAlignment(.center)

            HStack(spacing: 16) {
                Button(action: {
                    if cups > 0 {
                        cups = max(0, cups - 1)
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title)
                        .foregroundColor(.purple)
                }

                Text("\(cups)컵")
                    .font(.title2)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 24)
                    .background(Color(.systemGray6))
                    .cornerRadius(20)

                Button(action: {
                    if cups < maxCups {
                        cups = min(maxCups, cups + 1)
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.purple)
                }
            }

            Text("총 \(cups * 200)ml")
                .font(.subheadline)
                .foregroundColor(.gray)

            let rows = [0..<5, 5..<10]
            ForEach(rows, id: \.self) { range in
                HStack(spacing: 16) {
                    ForEach(range, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color.black, lineWidth: 1.5)
                                .frame(width: 35, height: 55)

                            if index < cups {
                                VStack {
                                    Spacer()
                                    Rectangle()
                                        .fill(Color.blue.opacity(0.6))
                                        .frame(height: 25)
                                        .cornerRadius(3)
                                }
                                .frame(width: 35, height: 55)
                            }

                            if index == cups && index < maxCups {
                                Text("+")
                                    .font(.title3)
                                    .foregroundColor(.gray)
                            }
                        }
                        .onTapGesture {
                            cups = index + 1
                        }
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
