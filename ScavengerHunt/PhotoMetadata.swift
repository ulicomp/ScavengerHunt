//
//  PhotoMetadata.swift
//  ScavengerHunt
//
//  Created by Kiara Gonzlez Reyes on 9/13/26.
//

import CoreLocation
import Foundation
import ImageIO

struct PhotoMetadata {
    static func coordinate(from data: Data) -> CLLocationCoordinate2D? {
        guard
            let imageSource = CGImageSourceCreateWithData(data as CFData, nil),
            let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as NSDictionary?,
            let gpsMetadata = properties[kCGImagePropertyGPSDictionary] as? NSDictionary,
            let latitude = doubleValue(for: kCGImagePropertyGPSLatitude, in: gpsMetadata),
            let longitude = doubleValue(for: kCGImagePropertyGPSLongitude, in: gpsMetadata)
        else {
            return nil
        }

        let adjustedLatitude = signedCoordinate(
            latitude,
            reference: stringValue(for: kCGImagePropertyGPSLatitudeRef, in: gpsMetadata),
            negativeReference: "S"
        )
        let adjustedLongitude = signedCoordinate(
            longitude,
            reference: stringValue(for: kCGImagePropertyGPSLongitudeRef, in: gpsMetadata),
            negativeReference: "W"
        )

        let coordinate = CLLocationCoordinate2D(
            latitude: adjustedLatitude,
            longitude: adjustedLongitude
        )

        guard
            abs(coordinate.latitude) <= 90,
            abs(coordinate.longitude) <= 180,
            CLLocationCoordinate2DIsValid(coordinate)
        else {
            return nil
        }

        return coordinate
    }

    private static func doubleValue(for key: CFString, in metadata: NSDictionary) -> Double? {
        let value = metadata[key]

        if let number = value as? NSNumber {
            return number.doubleValue
        }

        if let double = value as? Double {
            return double
        }

        if let string = value as? String {
            return Double(string)
        }

        return nil
    }

    private static func stringValue(for key: CFString, in metadata: NSDictionary) -> String? {
        metadata[key] as? String
    }

    private static func signedCoordinate(
        _ value: Double,
        reference: String?,
        negativeReference: String
    ) -> Double {
        if reference?.uppercased() == negativeReference {
            return -abs(value)
        }

        return abs(value)
    }
}
