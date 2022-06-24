//
//  InfoPanelView.swift
//  Pinch
//
//  Created by Giulls on 29/12/21.
//

import SwiftUI

struct InfoPanelView: View {
    var scale: CGFloat
    var offset: CGSize  // qui vengono definite esplicitamente delle var di tipo CGFloat e CGSize, ma non ne vengono dati i valori (in quanto vogliamo che siano gli stessi della pagina principale, vanno per questo inseriti dei valori - nei modificatori della preview (in basso), affichè il programma non ci dia errore
    
    @State private var isInfoPanelVisible: Bool = false  // proprietà che viene attribuita all'oggetto in modo da renderlo visibile, verrà impostata la condizione per cui, quando la var diventa true, l'oggetto verrà visualizzato
    
    var body: some View {
        HStack{
            //MARK: - HOTSPOT
            
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture (minimumDuration: 1){
                    withAnimation(.easeOut){
                    isInfoPanelVisible.toggle()
                    }
                }
            Spacer()
            
            
            
            //MARK: - INFO PANEL
            HStack (spacing: 2){
                Image (systemName: "arrow.up.left.and.arrow.down.right")
                Text ("\(scale)")
                
                Spacer ()
                
                Image(systemName: "arrow.left.and.right")
                Text ("\(offset.width)") // questi valori, sono valori che misura xCode dell'immagine che viene trascinata (in altezza, larghezza e scalatura (?))
                
                Spacer ()
                
                Image(systemName: "arrow.up.and.down")
                Text ("\(offset.height)")
                
                Spacer  ()
            }//: HSTACK -2
            
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1 : 0) // SWIFT TERNARY OPERATOR
            
            Spacer ()
            
            
        }//: HSTACK
        
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(scale: 1, offset: .zero)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
