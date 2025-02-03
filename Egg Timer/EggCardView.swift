//
//  EggCardView.swift
//  Egg Timer
//
//  Created by KirtiS on 2/2/25.
//

import SwiftUI
import UserNotifications

struct EggCardView: View {
    
    let cardData: CardDataModel
    
    @State private var timeRemaining = 0
    @State private var isTimerRunning = false
    @State private var timer: Timer? = nil
    
    init(cardData: CardDataModel) {
        self.cardData = cardData
        self._timeRemaining = State(initialValue: (Int(cardData.cookingTime.components(separatedBy: " ")[0]) ?? 0) * 60)
    }
    
    private func backGround() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color(hex: "#FCFFC1"))
            Image("eggImage")
                .resizable()
                .scaledToFill()
                .opacity(0.3)
        }
    }
    
    private func cardView() -> some View {
        VStack {
            VStack(spacing: 10) {
                Text(cardData.title)
                    .font(.title)
                    .foregroundColor(Color(hex: "#754E1A"))
                    .bold()
                
                Text(cardData.yolkTexture)
                    .font(.headline)
                    .foregroundColor(Color(hex: "#754E1A"))
                    .bold()
                
                Spacer()
                
                Text("\(timeRemaining / 60) minutes")
                    .font(.title2)
                    .foregroundColor(Color(hex: "#754E1A"))
                    .bold()
            }
            .padding(40)
            
            Spacer()
            
            Button(action: toggleTimer) {
                Text(isTimerRunning ? "Stop Timer" : "Start Timer")
                    .font(.title3)
                    .bold()
                    .frame(width: 200, height: 50)
                    .background(Color(hex: "#754E1A"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(20)
        }
        .padding(20)
    }
    
    var body: some View {
        ZStack {
            backGround()
            cardView()
        }
    }
}

extension EggCardView {
    
    private func toggleTimer() {
        isTimerRunning.toggle()
        if isTimerRunning {
            startTimer()
        } else {
            stopTimer()
        }
    }
    
    private func startTimer() {
        isTimerRunning = true
        let seconds = (Int(cardData.cookingTime.components(separatedBy: " ")[0]) ?? 0) * 60
        scheduleNotificationAfter(seconds: seconds)
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(seconds), repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
        isTimerRunning = false
    }
    
    private func scheduleNotificationAfter(seconds: Int) {
        let content = UNMutableNotificationContent()
        content.title = "Timer Completed"
        content.body = "Your egg is done!"
        content.sound = .default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: TimeInterval(seconds), repeats: false)
        let request = UNNotificationRequest(identifier: "timerNotification", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

struct EggCardView_Previews: PreviewProvider {
    static var previews: some View {
        EggCardView(cardData: CardData.cardData.first!)
    }
}
