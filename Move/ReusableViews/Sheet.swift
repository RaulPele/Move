//
//  Sheet.swift
//  Move
//
//  Created by Raul Pele on 22.09.2022.
//

import SwiftUI

enum SheetState {
    case hidden
    case visible
}

struct Sheet<Content: View>: View {
    let content: () -> Content
    @State private var sheetState: SheetState = .hidden
    @Binding var showSheet: Bool
    
    init(showSheet: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._showSheet = showSheet
        self.content = content
    }


    var body: some View {
        content()
//            .clipShape(RoundedRectangle(cornerRadius: 32))
            .offset(x: 0, y: sheetState == .visible ? 0 : 300)
            .opacity(sheetState == .visible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: sheetState)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .background(Color.black.opacity(0.2)
                .onTapGesture {
                    sheetState = .hidden
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showSheet = false
                    }
                }
                .ignoresSafeArea()
            )
            .onAppear {
                sheetState = .visible
            }
    }
}

struct SheetTest: View {
    @State var showSheet = false
    
    var body: some View {
        ZStack {
            Color.red
            
            Button {
                showSheet.toggle()
            } label :  {
                Text("Show sheet")
                    .foregroundColor(.white)
            }
            
//            .ignoresSafeArea()
        }
        .overlay {
            if showSheet {
                Sheet(showSheet: $showSheet) {
                    UnlockScooterBottomSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 82, location: .init()), onSerialNumberUnlockClicked: { _ in })
//                    Color.blue
//                        .frame(height: 200)
                }
            }
        }
    }
}

struct Sheet_Previews: PreviewProvider {
    
    
    static var previews: some View {
        SheetTest()
    }
}

