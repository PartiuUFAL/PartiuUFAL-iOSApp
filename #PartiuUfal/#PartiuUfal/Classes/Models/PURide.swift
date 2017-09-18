//
//  PURide.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 18/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse

class PURide: PFObject {
    @NSManaged var driver: PUUser!
    @NSManaged var passengers: [PUUser]?
    @NSManaged var targetName: String!
    @NSManaged var targetLocation: PFGeoPoint!
    @NSManaged var isActive: NSNumber!
}

extension PURide: PFSubclassing {
    static func parseClassName() -> String {
        return "Ride"
    }
}
