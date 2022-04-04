//
//  studentsStruct.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 9/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

public struct  studentsStruct : Codable
{
    @DocumentID var iid: String?
    var familyName: String
    var firstName: String
    var id: String?
    var w2: Int?
    var w3: Int?
    var w4: Int?
    var w5: Int?
    var w6: Int?
    var w7: Int?
    var w8: Int?
    var w9: Int?
    var w10: Int?
    var w11: Int?
    var w12: Int?
}


