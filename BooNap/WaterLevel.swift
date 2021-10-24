//
//  WaterLevel.swift
//  BooNap
//
//  Created by jamil raai on 24.10.21.
//

import SwiftUI

class WaterLevel: ObservableObject {
    
    init(displaySize : CGRect) {
        OffSetMidWaterLevelView = displaySize.height
        OffSetDeepWaterLevelView = displaySize.height * 2
    }
    
    @Published var OffSetSunLevelView : CGFloat = 0
    @Published var OffSetMidWaterLevelView : CGFloat = 0
    @Published var OffSetDeepWaterLevelView : CGFloat = 0
}


enum enumWaterLevel : Int {
    case SunLevel = 0
    case MidWaterLevel = 2
    case DeepWaterLevel = 3
}
