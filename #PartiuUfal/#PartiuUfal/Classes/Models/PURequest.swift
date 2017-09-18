//
//  PURequest.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 05/08/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse

class PURequest: PFObject {
    @NSManaged var ride: PURide!
    @NSManaged var user: PUUser?
    @NSManaged var wasAnswered: NSNumber!
    @NSManaged var wasAccepted: NSNumber?
    @NSManaged var wasConcluded: NSNumber!
}

extension PURequest: PFSubclassing {
    static func parseClassName() -> String {
        return "Request"
    }
}
