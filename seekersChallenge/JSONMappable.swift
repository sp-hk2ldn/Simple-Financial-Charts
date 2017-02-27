//
//  JSONMappable.swift
//  seekersChallenge
//
//  Created by Stephen Parker on 27/02/2017.
//  Copyright © 2017 Stephen Parker. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol JSONMappable {
    init(jsonData: JSON)
}
