//
//  SplashScreenView.swift
//  apiRequest
//
//  Created by Ömür Şenocak on 30.03.2023.
//

import SwiftUI
import AppOpenTracker


struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 0.70
    @State private var opacity = 0.5
    @State private var buttonOpacity = 0.2
    @State private var buttonSize = 0.70
    @State var countdownTimer = 5
    @State var timerRunning = true
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @AppStorage("firstLaunch") var  firstLaunch: Bool = false
    
    @ObservedObject private var appOpenTracker = AppOpenTracker.shared
    
    var body: some View {
        
        if isActive{
            ContentView()
        }else{
            VStack{
                VStack{
                    
                    Image("logo2")
                        .resizable()
                        .scaledToFit()
                    
                        .cornerRadius(100)
                    Image("logo1")
                        .resizable()
                        .scaledToFit()
                        .offset(y: -70)
                    
                    
                    Text(appOpenTracker.appIsFirstOpened ? "WELCOME!" : "HELLO!")
                        .font(.custom("radiospace", size: 46))
                    
                    
                }.offset(y: -10)
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.0)){
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                
                Button(action: {
                    isActive.toggle()
                    print(isActive)
                    firstLaunch = true
                    
                }, label: {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(red: 212 / 255, green: 218 / 255, blue: 100 / 255))
                    
                        .font(.system(size: 40))
                        .padding(30)
                        .background(Color(red: 79 / 255, green: 169 / 255, blue: 197 / 255))
                        .clipShape(Circle())
                        .overlay(
                            Circle()
                                .stroke(Color(red: 212 / 255, green: 218 / 255, blue: 100 / 255), lineWidth: 10)
                        )
                    
                    
                })     .scaleEffect(buttonSize)
                    .opacity(buttonOpacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 3.0)){
                            self.buttonSize = 0.9
                            self.buttonOpacity = 1.0
                        }
                    }
                Text("\(countdownTimer)")
                    .onReceive(timer){ _ in
                        
                        if countdownTimer > 0 && timerRunning {
                            countdownTimer -= 1
                        }else{
                            timerRunning = false
                        }
                        firstLaunch = true
                        
                    }     .scaleEffect(buttonSize)
                    .opacity(buttonOpacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 3.0)){
                            self.buttonSize = 0.9
                            self.buttonOpacity = 1.0
                        }
                    }
                
            }.onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                    self.isActive = true
                }
            }
        }
        
        
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
