//
//  File.swift
//  
//
//  Created by Kedar Dhere on 9/8/23.
//

import Foundation
import SwiftUI

public extension View {
    func toAnyView() -> AnyView {
        AnyView(self)
    }
}
