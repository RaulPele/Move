//
//  Sheet.swift
//  Move
//
//  Created by Raul Pele on 22.09.2022.
//

import SwiftUI

enum SheetMode {
    case none
    case quarter
    case half
    case full
}

struct Sheet<Content: View>: View {
    let content: () -> Content
    var sheetMode: SheetMode
    var showSheet: Binding<Bool>
    
    init(showSheet: Binding<Bool>, sheetMode: SheetMode, @ViewBuilder content: @escaping () -> Content) {
        self.showSheet = showSheet
        self.content = content
        self.sheetMode = sheetMode
    }
    
    private func calculateOffset(_ geo: GeometryProxy) -> CGFloat {
       if !showSheet.wrappedValue {
           return UIScreen.main.bounds.height
       }
        
        
       
       switch sheetMode {
       case .none:
           return UIScreen.main.bounds.height
           
       case .quarter:
           return UIScreen.main.bounds.height * 3/4
           
       case .half:
           return (UIScreen.main.bounds.height/2 - geo.safeAreaInsets.top - geo.safeAreaInsets.bottom) 
//           return geo.size.height / 2
           
       case .full:
           return 0
       }
    }

    var body: some View {
        GeometryReader { geo in
            content()
//                .edgesIgnoringSafeArea(.bottom)
                .offset(y: calculateOffset(geo))
                    .animation(.spring(), value: sheetMode)
              
        }

    }
}

struct Sheet_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.red
            Sheet(showSheet: .constant(true), sheetMode: .half) {
                UnlockScooterBottomSheetView(scooter: .init(id: "12313", scooterNumber: 1893, bookedStatus: .free, lockedStatus: .available, batteryPercentage: 82, location: .init()), onSerialNumberUnlockClicked: { _ in })}
            
        }
       
//        .edgesIgnoringSafeArea(.all)
    }
}

