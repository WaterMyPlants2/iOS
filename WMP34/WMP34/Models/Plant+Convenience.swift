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
    var plantRepresentation: PlantRepresentation? {
        guard let species = species, let nickname = nickname, let image = image, let h2ofrequency = h2ofrequency else {
            return nil
        }
        return PlantRepresentation(h2ofrequency: h2ofrequency,
                                   species: species,
                                   image: image,
                                   nickname: nickname)
    }
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
    @discardableResult convenience init?(plantRepresentation: PlantRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(nickname: plantRepresentation.nickname,
                  species: plantRepresentation.species,
                  image: plantRepresentation.image,
                  h2ofrequency: plantRepresentation.h2ofrequency,
                  context: context)
    }
}
