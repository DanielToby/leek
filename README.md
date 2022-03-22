# leek
A standalone dictionary app for iOS that remembers what you've searched.


- This app is written in SwiftUI, and leverages [declarative programming](https://github.com/DanielToby/leek/blob/main/leek/model/word_database.swift#:~:text=private(set)%20var%20words%3A%20%5BWord%5D%20%3D%20%5B%5D).

- The word of the day is [refreshed](https://github.com/DanielToby/leek/blob/main/leek/controllers/words_controller.swift#:~:text=%7D-,func%20calculateWordOfTheDay()%20%7B,%7D,-//%20Sets%20the%20currentWord) every night at midnight, and will do so for ~16 years before repeating.

- Definitions and pronunciations are [fetched](https://github.com/DanielToby/leek/blob/main/leek/utility/oxford_query_utility.swift#:~:text=func%20queryOxfordDefinitions(query%3A%20String%2C%20completion%3A%20%40escaping%20(WordData)%20%2D%3E%20Void)%20%7B) using the [Oxford Dictionary API](https://developer.oxforddictionaries.com/). 

- Saved words are [made peristent](https://github.com/DanielToby/leek/blob/main/leek/model/word_database.swift#:~:text=static%20func%20load(completion%3A%20%40escaping%20(Result%3C%5BWord%5D%2C%20Error%3E)%2D%3EVoid)%20%7B) through a stored json file.

<img src="demo-light.gif" alt="demo-light" width="400"/>
<img src="demo-dark.gif" alt="demo-dark" width="400"/>
