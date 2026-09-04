//
//  ServerError.swift
//
//
//  Created by Alexander Sharko on 29.11.2022.
//

import Foundation

struct ServerError: LocalizedError {
    private var errorsDescription: String

    init?(data: Data, response: HTTPURLResponse) {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            #if DEBUG
                errorsDescription = "DEBUG\n" + "Status code: \(response.statusCode)\n" + "URL: \(response.url?.absoluteString ?? "NONE")\n" + (ErrorInfo(rawValue: response.statusCode)?.description ?? "Error")

                return
            #endif
            return nil
        }

        errorsDescription = Self.mapJsonToErrorString(json)

        #if DEBUG
            errorsDescription = "DEBUG\n" + "Status code: \(response.statusCode)\n" + "URL: \(response.url?.absoluteString ?? "NONE")" + "\nError body:\n" + Self.mapJsonToErrorString(json) + "\n" + (ErrorInfo(rawValue: response.statusCode)?.description ?? "Error")

        #endif
    }

    var errorDescription: String? {
        return errorsDescription
    }

    private enum ErrorInfo: Int {
        case unauthorized = 401
        case forbidden = 403
        case notFound = 404
        case validationErrors = 422
        case internalServer = 500

        var description: String {
            switch self {
            case .unauthorized:
                return "Unauthorized\nMaybe you forgot to add token to request or it isn't valid.\n Check your token"
            case .forbidden:
                return "Forbidden\nYour user with this token haven't permissions to make this action."
            case .notFound:
                return "Not found\nThere isn't info at this endpoint. Please check the correctness of the entered request or requested object"
            case .validationErrors:
                return "Validation Error\n Please check correctness of data which you send to server. If your validator is not synchronized with the server one or server don't tell us whats wrong."
            case .internalServer:
                return "Internal Server\nOoh you broke the server or it doesn't work now."
            }
        }
    }

    private static func mapJsonToErrorString(_ json: [String: Any]) -> String {
        json.compactMap { tuple in
            if let jsonValue = tuple.value as? [String: Any] {
                return mapJsonToErrorString(jsonValue)

            } else if let string = tuple.value as? String {
                return tuple.key + " - " + string

            } else if let array = tuple.value as? [String] {
                return tuple.key + " - " + array.joined(separator: ",")
            }

            return nil
        }
        .joined(separator: "\n")
    }
}
