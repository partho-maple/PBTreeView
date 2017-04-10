//
//  RelationshipDetails.swift
//  FamilyTree-Backend
//
//  Created by Partho Biswas on 3/5/17.
//
//

import Foundation
import ObjectMapper

class RelationshipDetails: Mappable {
    
    var social_security_number: String?
    var name: String?
    var gender: String?
    var date_of_birth: Double?
    var date_of_death: Double?
    var relation: String?
    var relation_id: Int?
    var relatives: [RelationshipDetails]?
    
    
    required init?(map: Map) {
        
    }
    
    
    init?() {
        
    }
    
    
    
    public func setRelationshipDetails(ssn: String, name: String, gender: String, date_of_birth: Double?, date_of_death: Double?, relation: String, relation_id: Int?, relatives: [RelationshipDetails]?) {
        self.social_security_number = ssn
        self.name = name
        self.gender = gender
        self.date_of_birth = date_of_birth
        self.date_of_death = date_of_death
        self.relation = relation
        self.relation_id = relation_id
        self.relatives = relatives
    }

    
    
    // Mappable
    func mapping(map: Map) {
        social_security_number <- map[JSON_Keys.SSN]
        name <- map[JSON_Keys.name]
        gender <- map[JSON_Keys.gender]
        date_of_birth <- map[JSON_Keys.date_of_birth]
        date_of_death <- map[JSON_Keys.date_of_death]
        relation <- map[JSON_Keys.relation_type]
        relation_id <- map[JSON_Keys.relation_id]
        relatives <- map[JSON_Keys.relatives]
    }
    
}
