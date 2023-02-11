//
//  OnboardingPresentationViewModel.swift
//  Veterinerim
//
//  Created by Emir Alkal on 11.02.2023.
//

import Foundation

struct OnboardingPresentation {
  let lottieName: String
  let text: String
  let index: Int
}

struct OnboardingPresentationViewModel {
  var onboardingIndex = 0

  private let data = [
    OnboardingPresentation(lottieName: "onboarding-1", text: "Test 1", index: 0),
    OnboardingPresentation(lottieName: "onboarding-2", text: "Test 2", index: 1),
    OnboardingPresentation(lottieName: "onboarding-3", text: "Test 3", index: 2),
  ]

  private func get() -> OnboardingPresentation {
    return data[onboardingIndex]
  }

  func start() -> OnboardingPresentation {
    return data[0]
  }

  mutating func click() -> OnboardingPresentation? {
    onboardingIndex += 1
    if onboardingIndex == 3 {
      return nil
    }
    return get()
  }
}
