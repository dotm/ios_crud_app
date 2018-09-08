//
//  Model.swift
//  CRUD
//
//  Created by Yoshua Elmaryono on 07/09/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let modelChanged = Notification.Name("Model was changed")
}
var names: [String] = ["John Ravio", "Jane Luvia"] {
    didSet {
        NotificationCenter.default.post(name: .modelChanged, object: nil)
    }
}
