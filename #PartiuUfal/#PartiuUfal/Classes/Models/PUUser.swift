//
//  PUUser.swift
//  #PartiuUfal
//
//  Created by Rubens Pessoa on 01/07/17.
//  Copyright © 2017 Rubens Pessoa. All rights reserved.
//

import Foundation
import Parse

class PUUser: PFUser {
    @NSManaged var picture: PUMedia!
    @NSManaged var name: String!
    @NSManaged var nickname: String!
    @NSManaged var gender: String!
    @NSManaged var maritalStatus: String!
    @NSManaged var birthdate: Date!
    @NSManaged var isOnARide: NSNumber!
    @NSManaged var ridesHistory: [PURide]?
    @NSManaged var favoritePosition: String?
    @NSManaged var favoriteTarget: String?
    @NSManaged var favoriteFriend: String?
    @NSManaged var likesCount: NSNumber?
    @NSManaged var dislikesCount: NSNumber?
    @NSManaged var actualLocation: PFGeoPoint!
    
    override class func registerSubclass() {
        super.registerSubclass()
    }
}
