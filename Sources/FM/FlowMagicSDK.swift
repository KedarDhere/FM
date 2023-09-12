//
//  File.swift
//  
//
//  Created by Kedar Dhere on 9/8/23.
//

import Foundation
import SwiftUI

public protocol ErrorHandlerProtocol {
    func handleFatalError(_ message: String)
}

public class ProductionHandleFatalError: ErrorHandlerProtocol {
    public func handleFatalError(_ message: String) {
        fatalError(message)
    }
}

public protocol ScreenFlowProviding {
    func registerScreen(screenName: String, portNames: [String], view: any View)
    func addConnection(fromPort: String, toScreen: String)
    func getDestinationScreen(portName: String) -> any View
    func getScreens() -> [String: (view: AnyView, portNames: [String])]
    func getDestinationViewsFromPorts() -> [String: any View]
    func updateDestinationViewsFromPorts(portName: String, destinationView: AnyView)
}

public class ScreenFlowProvider: ScreenFlowProviding {

    public static var shared = ScreenFlowProvider()
    let errorHandle: ErrorHandlerProtocol = ProductionHandleFatalError()

    // MARK: - Properties

    public var screens: [String: (view: AnyView, portNames: [String])]
    public var destinationViewsFromPorts: [String: AnyView]

    // MARK: - Initialization

    public init() {
        screens = [:]
        destinationViewsFromPorts = [:]
    }

    // MARK: - Methods

    public func registerScreen(screenName: String, portNames: [String], view: any View) {
        guard screens[screenName] == nil else {
            return
        }

        screens[screenName] = (AnyView(view), portNames)
    }

    public func addConnection(fromPort: String, toScreen: String) {
        guard let view = screens[toScreen]?.view else {
            errorHandle.handleFatalError("Value of screen is nil")
            return
        }

        let portName = fromPort + "." + toScreen
        destinationViewsFromPorts[portName] = view
    }

    public func getDestinationScreen(portName: String) -> any View {
        print(portName)
        return destinationViewsFromPorts[portName]!
    }

    public func getScreens() -> [String: (view: AnyView, portNames: [String])] {
        return screens
    }

    public func getDestinationViewsFromPorts() -> [String: any View] {
        return destinationViewsFromPorts
    }

    public func updateDestinationViewsFromPorts(portName: String, destinationView: AnyView) {
        destinationViewsFromPorts[portName] = destinationView
    }
}
