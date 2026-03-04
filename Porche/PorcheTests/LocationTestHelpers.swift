import Foundation
import CoreLocation

/// Test-only helper: simulira GPS lokacije duž rute (npr. Trg bana Jelačića → Jarun).
enum SimulatedRoute {

    /// Trg bana Jelačića, Zagreb
    static let trgBanaJelacica = CLLocationCoordinate2D(latitude: 45.8129, longitude: 15.9775)

    /// Jarun (jezero), Zagreb
    static let jarun = CLLocationCoordinate2D(latitude: 45.7808, longitude: 15.9432)

    /// Generira niz lokacija koje simuliraju vožnju od start do end.
    /// - Parameters:
    ///   - start: početna točka
    ///   - end: završna točka
    ///   - numberOfPoints: broj točaka (veći = gušća ruta)
    ///   - startDate: početni timestamp (svaka sljedeća točka +interval)
    ///   - intervalSeconds: vremenski razmak između točaka u sekundama
    ///   - speedKmh: simulirana brzina (km/h) za izračun course/speed u lokacijama
    /// - Returns: niz `CLLocation` s koordinatama, timestampom i opcionalno speed/course
    static func locations(
        from start: CLLocationCoordinate2D = trgBanaJelacica,
        to end: CLLocationCoordinate2D = jarun,
        numberOfPoints: Int = 50,
        startDate: Date = Date(),
        intervalSeconds: TimeInterval = 1.0,
        speedKmh: Double = 25.0
    ) -> [CLLocation] {
        guard numberOfPoints >= 2 else {
            return [CLLocation(coordinate: start, altitude: 0, horizontalAccuracy: 5, verticalAccuracy: 5, timestamp: startDate)]
        }
        let speedMps = speedKmh * 1000.0 / 3600.0
        var result: [CLLocation] = []
        for i in 0..<numberOfPoints {
            let t = Double(i) / Double(numberOfPoints - 1)
            let lat = start.latitude + t * (end.latitude - start.latitude)
            let lon = start.longitude + t * (end.longitude - start.longitude)
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
            let timestamp = startDate.addingTimeInterval(TimeInterval(i) * intervalSeconds)
            let course: CLLocationDirection = {
                if i + 1 >= numberOfPoints { return 0 }
                let nextT = Double(i + 1) / Double(numberOfPoints - 1)
                let nextLat = start.latitude + nextT * (end.latitude - start.latitude)
                let nextLon = start.longitude + nextT * (end.longitude - start.longitude)
                let dLon = (nextLon - lon) * .pi / 180.0
                let y = sin(dLon) * cos(nextLat * .pi / 180.0)
                let x = cos(lat * .pi / 180.0) * sin(nextLat * .pi / 180.0) - sin(lat * .pi / 180.0) * cos(nextLat * .pi / 180.0) * cos(dLon)
                var angle = atan2(y, x) * 180.0 / .pi
                if angle < 0 { angle += 360 }
                return angle
            }()
            let location = CLLocation(
                coordinate: coordinate,
                altitude: 120,
                horizontalAccuracy: 5,
                verticalAccuracy: 5,
                course: course,
                courseAccuracy: 10,
                speed: speedMps,
                speedAccuracy: 1,
                timestamp: timestamp
            )
            result.append(location)
        }
        return result
    }

    /// Ruta "Trg bana Jelačića → Jarun" kao gotov niz lokacija za testove.
    static func trgBanaJelacicaToJarun(
        points: Int = 50,
        startDate: Date = Date(),
        intervalSeconds: TimeInterval = 1.0,
        speedKmh: Double = 25.0
    ) -> [CLLocation] {
        locations(
            from: trgBanaJelacica,
            to: jarun,
            numberOfPoints: points,
            startDate: startDate,
            intervalSeconds: intervalSeconds,
            speedKmh: speedKmh
        )
    }
}
