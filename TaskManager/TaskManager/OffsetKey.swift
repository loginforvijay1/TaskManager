//
//  OffsetKey.swift
//  TaskManager
//
//  Created by Vemireddy Vijayasimha Reddy on 29/03/24.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
