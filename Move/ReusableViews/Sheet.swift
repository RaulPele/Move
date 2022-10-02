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
    let onDismiss: () -> Void
    @State private var sheetState: SheetState = .hidden
    @Binding var showSheet: Bool
    
    init(showSheet: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self._showSheet = showSheet
        self.content = content
        self.onDismiss = { }
    }
    
    init(showSheet: Binding<Bool>, @ViewBuilder content: @escaping () -> Content, onDismiss: @escaping () -> Void) {
        self._showSheet = showSheet
        self.content = content
        self.onDismiss = onDismiss
    }


    var body: some View {
        content()
            .offset(x: 0, y: sheetState == .visible ? 0 : 300)
            .opacity(sheetState == .visible ? 1 : 0)
            .animation(.easeInOut(duration: 0.3), value: sheetState)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .background(Color.black.opacity(0.2)
                .onTapGesture {
                    sheetState = .hidden
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        showSheet = false
                        onDismiss()
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
        }
        .overlay {
            if showSheet {
                Sheet(showSheet: $showSheet) {
                    UnlockScooterBottomSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .available, lockedStatus: .unlocked, batteryPercentage: 82, location: .init()), onSerialNumberUnlockClicked: { _ in })
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

