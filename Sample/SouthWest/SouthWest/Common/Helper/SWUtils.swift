//
//  SWUtils.swift
//  SouthWest
//
//  Created by Shahebaz Shaikh on 05/04/24.
//

import Foundation

final class SWUtilMethods {
    internal static func isValidJSON(_ jsonString: String) -> Bool {
        guard let data = jsonString.data(using: .utf8) else {
            return false
        }
        
        do {
            _ = try JSONSerialization.jsonObject(with: data, options: [])
            return true
        } catch {
            return false
        }
    }
    
    static func convertToDictionary(from jsonString: String) -> [String: String] {
        jsonString
            .replacingOccurrences(of: Constants.Characters.backslashWithDoubleQuote, with: Constants.Characters.emptyString)
            .components(separatedBy: Constants.Characters.commaSpace)
            .reduce(into: [String: String]()) { result, keyValue in
                let components = keyValue.components(separatedBy: Constants.Characters.colonSpace)
                if components.count == 2 {
                    let key = components[0]
                    let value = components[1]
                    result[key] = value
                }
            }
    }
}
