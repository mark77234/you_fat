//
//  MoreModel.swift
//  RudyMark
//
//  Created by 이병찬 on 4/4/25.
//

import SwiftUI

struct MoreItem: Identifiable {
    let id = UUID()
    let title: String
    let iconName: String
    let destination: AnyView
}
