//
//  Extensions.swift
//  netflixclone
//
//  Created by João Victor on 01/08/22.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
