# John Lewis Technical Test

## Assumptions

- Products are always in stock
- Products always have 1 guarantee and 1 image

## Issues

The API call: `https://api.johnlewis.com/v1/products/search?q=dishwasher&key=Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb&pageSize=20` was returning an image component with a missing scheme: `"image": "//johnlewis.scene7.com/is/image/JohnLewis/234326372?"`. I couldn't figure out why so I added `URLSchemeFixer` to fix it.  
  
The images from the API were quite large so the memory footprint is high. Although I noticed that the JL app was using `?wid=xxx` to request different sizes.  

## Third party API

I used SwiftyJSON as a third party library to help parse the JSON easily.
