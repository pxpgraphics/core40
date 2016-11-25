//
//  Router.swift
//  Core40
//
//  Created by Paris Pinkney on 11/25/16.
//  Copyright © 2016 Core40. All rights reserved.
//

import Foundation
import Alamofire

enum Router {

	case createUser(parameters: Parameters)
	case readUser(username: String)
	case updateUser(username: String, parameters: Parameters)
	case destroyUser(username: String)

	static let baseURLString = "https://core40.com"

	var method: HTTPMethod {
		switch self {
		case .createUser: return .post
		case .readUser: return .get
		case .updateUser: return .put
		case .destroyUser: return .delete
		}
	}

	var path: String {
		switch self {
		case .createUser: return "/users"
		case .readUser(let username): return "/users/\(username)"
		case .updateUser(let username, _): return "/users/\(username)"
		case .destroyUser(let username): return "/users/\(username)"
		}
	}
}

// MARK: - URLRequestConvertible

extension Router: URLRequestConvertible {

	func asURLRequest() throws -> URLRequest {
		let url = try Router.baseURLString.asURL()

		var urlRequest = URLRequest(url: url.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue

		switch self {
		case .createUser(let parameters):
			urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
		case .updateUser(_, let parameters):
			urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
		default:
			break
		}

		return urlRequest
	}
}
