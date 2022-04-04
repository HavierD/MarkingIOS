//
//  schemeStruct.swift
//  A3HuaizhiDai530562
//
//  Created by mobiledev on 16/5/21.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

public struct schemeStruct : Codable
{
    @DocumentID var schemeWk: String?
    
    
    var type: String?
    var number : Int?
}

