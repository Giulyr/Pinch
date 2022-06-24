//
//  ContentView.swift
//  Pinch
//
//  Created by Giulls on 28/12/21.
//https://credo.udemy

import SwiftUI

struct ContentView: View {
    //MARK: - PROPERTY
    
    @State private var isAnimating : Bool = false
    @State private var imageScale : CGFloat = 1 // la proprità dell'immagine (ovvero quando deve scalare) viene settata con punto di partenza 1
    @State private var imageOffset : CGSize = .zero // è uguale a dare width: 0 e height: 0
    
    //MARK: - FUNCTION
    
    func resetImageState () {
        return withAnimation(.spring()){
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    
    //MARK: - CONTENT
    
    
    
    var body: some View {
        NavigationView{
            ZStack {
                Color.clear
                
                //MARK: - PAGE IMAGE
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1 : 0) // questo viene utilizzato per impostare l'animazione riferendosi allo @State propriety che viene determinata nelle proprietà, ciò significa che quando inizierà l'animazione (quando il Bool diventa TRUE), ci sarà un opacity, il programma riconosce dove applicarla perchè l'abbiamo inserita come modificatore dell'immagine (solo sull'opacità)
                    .offset(x:imageOffset.width, y:imageOffset.height)
                    .scaleEffect(imageScale)
                
                //MARK: - 1. TAP GESTURE
                    .onTapGesture(count: 2, perform: {
                        if imageScale == 1 {
                            withAnimation(.spring()){
                                imageScale = 5
                            }
                        } else {
                            withAnimation(.spring()){
                                resetImageState()
                                // viene dato un n. di tocchi (2) all'animazione OnTAP, vengono determinati i parametri iniziali (1) e di quanto deve essere scalata l'immagine (5), per poi mettere la condizione, al contrario di riportarla sul valore di Default (1)
                            }
                        }
                    })
                
                // MARK: - 2. DRAG GESTURE
                    .gesture (
                        DragGesture ()
                            .onChanged{ value in
                                withAnimation(.linear(duration: 1)){
                                    imageOffset = value.translation    /* - INIZIO DELLA DRAG GESTURE
                                                                        E'importante che ci sia @State imageOffset affinchè funzioni, sia all'inizio della View, sia all'immagine su cui viene applicata deve esserci .offset(x/y) con valori imageOffset.width e .height
                                                                        tutto ciò significa che, quando viene messo l'offset all'immagine, vengono date le coordinate della var definite nello @State, in questo caso partono entrambe da 0, per cui, all'interno dell'animazione viene detto che quando viene fatto il drag, la var imageOffset avrà il valore della translazione stessa e non più 0 */
                                    
                                }
                            }
                            .onEnded{ _ in // tratt. basso inidica al programma che non ci interessa del valore della transazione e lo ignora
                                if imageScale <= 1 {
                                    resetImageState() //quando finisce il drag, non importa quale sia il valore in cui si trova l'immagine, SE l'immagine è scalata min. o uguale a zero, riporta l'immagine (con un animazione .spring) ai valori di: scala 1 e offset (quindi altezza e larghezz) .zero
                                    
                                }
                            }
                    )
                
            }//: ZSTACK
            .navigationTitle("Pinch & Zoom")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear(perform:{
                withAnimation(.linear(duration: 1)) { //ANIMAZIONE
                    isAnimating = true // cambio dello @State da false a true per determinare l'animazione
                }
            })
            
            // MARK: - INFO PANEL
            .overlay(
                InfoPanelView (scale: imageScale, offset: imageOffset)
                    .padding(.horizontal)
                    .padding(.top, 30)
                , alignment: .top
            )
            
            // MARK: - CONTROLS
            .overlay (
                Group {
                    HStack {
                       // SCALE DOWN
                        Button {
                            withAnimation(.spring()){
                                if imageScale > 1 {
                                    imageScale -= 1 //l'immagine viene scalata di -1 quando l'immagine presenta una scalatura magg. di 1
                                    
                                    if imageScale <= 1 {
                                        resetImageState() //questa viene messa per evitare errori, quando l'imm. è min. e uguale a 1 tornerà alla posizione di default (func. creata prima)
                                    }
                                }
                            }
                            
                        }
                    label: {
                        ControlImageView(icon: "minus.magnifyingglass")
                    }
                        
                        
                        // RESET
                        Button {
                                resetImageState()
                        }
                    label: {
                        ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                    }
                        
                        
                        // SCALE UP
                        Button {
                            withAnimation(.spring ()){
                                if imageScale < 5{
                                    imageScale += 1
                                    
                                    if imageScale > 5{
                                        imageScale = 5 //questo fa si che l'immagine non superi mai 5 
                                    }
                                    
                                }
                            }
                        }
                    label: {
                        ControlImageView(icon: "plus.magnifyingglass")
                    }
                        
                        
                    }//: CONTROLS
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1 : 0) //questo determina il fatto che il  background appare con questo tipo di opacità
                }
                    .padding(.bottom, 30),
                alignment: .bottom
            )
        }//: NAVIGATION
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
