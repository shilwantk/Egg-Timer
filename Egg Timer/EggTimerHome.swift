//
//  TimerCardView.swift
//  Egg Timer
//
//  Created by KirtiS on 2/1/25.
//

import SwiftUI
import UserNotifications

struct EggTimer: View {

    init() {
        configurePageControl()
    }

    var body: some View {
        ZStack {
            backgroundView()
            tabViewContent()
        }.onAppear {
            requestNotificationPermission()
        }
    }
}

//MARK: UI Components
extension EggTimer {

    private func configurePageControl() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor.black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.lightGray
    }

    private func backgroundView() -> some View {
        Image("Background")
            .resizable()
            .scaledToFill()
            .opacity(0.5)
            .ignoresSafeArea(edges: [.top, .bottom])
    }

    private func tabViewContent() -> some View {
        TabView {
            ForEach(CardData.cardData, id: \.self) { data in
                EggCardView(cardData: data)
                    .frame(width: 320, height: 320)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "#754E1A"), lineWidth: 4)
                    )
                    .padding(.horizontal, 20)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        .frame(height: 400)
    }
}

//MARK: Notification Permission
extension EggTimer {
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [
            .alert, .badge, .sound,
        ]) { success, error in
            if success {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
}

struct TimerCard: PreviewProvider {
    static var previews: some View {
        EggTimer()
    }
}
