//
//  File.swift
//  
//
//  Created by Kedar Dhere on 9/8/23.
//
import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidServerResponse
}

private extension URLResponse {
    var isSuccessful: Bool {
        guard let httpResponse = self as? HTTPURLResponse else {
            return false
        }

        return httpResponse.statusCode == 200
    }
}

public protocol WebService {
    func loadUrlData(resource: String) async throws -> ScreenFlowModel
}

public class WebServiceImpl: WebService {
    public init(){}
    public func loadUrlData(resource: String) async throws -> ScreenFlowModel {
        guard let url = URL(string: resource) else {
            throw NetworkError.invalidUrl
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        if !response.isSuccessful {
            throw NetworkError.invalidServerResponse
        }

        let screenData = try JSONDecoder().decode(ScreenFlowModel.self, from: data)

        return screenData
    }
}

