//
//  File.swift
//  
//
//  Created by Kedar Dhere on 9/8/23.
//

import Foundation
import SwiftUI

public struct ScreenInfoModel: Decodable {
    let screenName: String
    let portName: String
    let destinationView: String
}

public struct ApplicationScreenFlowModel: Decodable {
    let screenName: String
    let portName: String
    let destinationView: String
}

public struct ScreenFlowModel: Decodable {
    let applicationId: String
    let applicationScreenFlow: [ApplicationScreenFlowModel]
}

