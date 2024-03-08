Weather App

Data Layer:
Following challenge instructions I decided not to use Alamofire for network requests. Instead, I implemented two network calls: the first one fetches weather data using latitude and longitude coordinates or by city name search. There are multiple versions of the API available, and I chose to integrate version 2.5 for our app's requirements. The second network call is responsible for downloading weather condition images. While I typically would have utilized AsyncImage for image loading, it wasn't available for iOS 14, prompting to implement a custom solution.

Models:
In the data layer, I implemented the Codable protocol along with CodingKeys to model only the necessary data structures required for the challenge.

Architecture:
I adopted the Model-View-ViewModel (MVVM) architecture for several reasons. MVVM provides a clear separation of concerns, facilitating the organization of code into distinct layers.

Views:
My approach to designing views prioritized simplicity while meeting the functional requirements outlined for the app. I tried to spend some creativity while coding the UI, ensuring an engaging and visually appealing user experience.

Location Manager:
The Location Manager component is responsible for managing location permissions and retrieving the user's coordinates.
