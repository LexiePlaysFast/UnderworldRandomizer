import Foundation

func format(_ interval: TimeInterval) -> String {
  let fullSeconds = Int(interval)
  let hundreds = String(format: "%02d", Int((interval - TimeInterval(fullSeconds)) * 100))

  let seconds = String(format: "%02d", fullSeconds % 60)
  let fullMinutes = fullSeconds / 60

  let minutes = String(format: "%02d", fullMinutes % 60)
  let hours = fullMinutes / 60

  return "\(hours):\(minutes):\(seconds).\(hundreds)"
}
