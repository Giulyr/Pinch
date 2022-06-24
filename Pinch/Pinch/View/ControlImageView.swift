//
//  ControlImageView.swift
//  Pinch
//
//  Created by Giulls on 29/12/21.
//

import SwiftUI

struct ControlImageView: View {
    
    let icon : String // questo fa si che quando viene richiamata la pagina, ma che viene cambiata icona ogni volta 
    
    var body: some View {
        Image (systemName: icon)
            .font (.system (size: 36))
    }
}

struct ControlImageView_Previews: PreviewProvider {
    static var previews: some View {
        ControlImageView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
