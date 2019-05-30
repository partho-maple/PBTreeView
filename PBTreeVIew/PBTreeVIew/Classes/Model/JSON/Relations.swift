//
//  Relations.swift
//  PBTreeVIew
//
//  Created by Partho Biswas on 3/12/17.
//
//

import Foundation
import ObjectMapper

class Relations: Mappable {
    
    var relations: [RelationshipDetails]?
    
    required init?(map: Map) {
        
    }
    
    
    init?() throws {
        
    }
    
    
    public func setRelations(_ relations: [RelationshipDetails]?) {
        self.relations = relations
    }
    
    
    // Mappable
    func mapping(map: Map) {
        relations    <- map[JSON_Keys.relations]
    }

}
