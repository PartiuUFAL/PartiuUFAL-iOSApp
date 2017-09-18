//
//  PUMedia.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 01/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse

class PUMedia: PFObject {
    @NSManaged var thumbnail: PFFile!
    @NSManaged var image: PFFile!
    
    
    static func findMediaById(id: String, completion: @escaping (_ media: PUMedia?, _ error: Error?) -> Void) {
        let query = PUMedia.query()!
        query.includeKey("thumbnail")
        query.getObjectInBackground(withId: id) { (object, error) in
            if let media = object as? PUMedia {
                completion(media, nil)
            }else {
                completion(nil, error)
            }
        }
    }
}

extension PUMedia: PFSubclassing {
    static func parseClassName() -> String {
        return "Media"
    }
}
