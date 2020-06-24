//
//  Plant+Convenience.swift
//  WMP34
//
//  Created by Vincent Hoang on 6/24/20.
//  Copyright © 2020 Casanova Studios. All rights reserved.
//

import Foundation
import CoreData

extension Plant {
    
    @discardableResult convenience init(nickname: String,
                                        species: String,
                                        image: String,
                                        h2ofrequency: String,
                                        context: NSManagedObjectContext =
                                            CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.nickname = nickname
        self.species = species
        self.image = image
        self.h2ofrequency = h2ofrequency
    }
}
