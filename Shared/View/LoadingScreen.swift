//
//  LoadingScreen.swift
//  MacEmailAuth
//
//  Created by Michele Manniello on 06/04/21.
//

import SwiftUI

struct LoadingScreen: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.23)
            ProgressView()
                .frame(width: 70, height: 70)
                .background(Color.white)
                .cornerRadius(10)
//            color scheme to light for indicator visibility
                .colorScheme(.light)
        }
        .ignoresSafeArea()
    }
}

struct LoadingScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoadingScreen()
    }
}
