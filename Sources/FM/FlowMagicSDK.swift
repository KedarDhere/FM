//
//  File.swift
//  
//
//  Created by Kedar Dhere on 9/8/23.
//

import Foundation
import SwiftUI

protocol ErrorHandlerProtocol {
    func handleFatalError(_ message: String)
}

public class ProductionHandleFatalError: ErrorHandlerProtocol {
    func handleFatalError(_ message: String) {
        fatalError(message)
    }
}

protocol ScreenFlowProviding {
    func registerScreen(screenName: String, portNames: [String], view: any View)
    func addConnection(fromPort: String, toScreen: String)
    func getDestinationScreen(portName: String) -> any View
    func getScreens() -> [String: (view: AnyView, portNames: [String])]
    func getDestinationViewsFromPorts() -> [String: any View]
    func updateDestinationViewsFromPorts(portName: String, destinationView: AnyView)
}

public class ScreenFlowProvider: ScreenFlowProviding {

    static var shared = ScreenFlowProvider()
    let errorHandle: ErrorHandlerProtocol = ProductionHandleFatalError()

    // MARK: - Properties

    var screens: [String: (view: AnyView, portNames: [String])]
    var destinationViewsFromPorts: [String: any View]

    // MARK: - Initialization

    public init() {
        screens = [:]
        destinationViewsFromPorts = [:]
    }

    // MARK: - Methods

    func registerScreen(screenName: String, portNames: [String], view: any View) {
        guard screens[screenName] == nil else {
            return
        }

        screens[screenName] = (AnyView(view), portNames)
    }

    func addConnection(fromPort: String, toScreen: String) {
        guard let view = screens[toScreen]?.view else {
            errorHandle.handleFatalError("Value of screen is nil")
            return
        }

        let portName = fromPort + "." + toScreen
        destinationViewsFromPorts[portName] = view
    }

    func getDestinationScreen(portName: String) -> any View {
        print(portName)
        return destinationViewsFromPorts[portName]!
    }

    func getScreens() -> [String: (view: AnyView, portNames: [String])] {
        return screens
    }

    func getDestinationViewsFromPorts() -> [String: any View] {
        return destinationViewsFromPorts
    }

    func updateDestinationViewsFromPorts(portName: String, destinationView: AnyView) {
        destinationViewsFromPorts[portName] = destinationView
    }
}