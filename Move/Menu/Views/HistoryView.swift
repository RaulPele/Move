//
//  HistoryView.swift
//  Move
//
//  Created by Raul Pele on 04.10.2022.
//

import SwiftUI

struct HistoryView: View {
    var body: some View {
        ZStack(alignment: .top) {
            Color.neutralWhite
            VStack(spacing: 44) {
                titleBarView
            }
            .padding(.top, 10)
            .padding([.horizontal, .bottom], 24)
        }
    }
}

private extension HistoryView {
    var titleBarView: some View {
        HStack(spacing: 0) {
            Image("chevron-left")
            Spacer()
            Text("History")
                .foregroundColor(.primaryDark)
                .font(.heading3())
            Spacer()
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(devices) { device in
            HistoryView()
                .previewDevice(device)
        }
    }
}
