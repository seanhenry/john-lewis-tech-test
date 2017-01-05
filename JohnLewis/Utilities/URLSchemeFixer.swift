import Foundation

class URLSchemeFixer {

    // The API call: https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20
    // was returning an image component like: "image": "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"
    // The scheme was missing and I couldn't figure out why so I added this method to fix it.

    static func fixMissingScheme(in url: String) -> String {
        var result = url
        if url.hasPrefix("//") {
            result = "https:" + url
        }
        return result
    }
}
