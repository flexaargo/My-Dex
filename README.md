# My Dex
> Yes, another Pokédex

Simple one page Pokédex that fetches the data from an API. You can search for Pokémon by name, id, or type. More functionality to come...?

![Recording of My Dex](images/MyDex.gif)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes

This project was created using Xcode 10 and Swift 5

### Prerequisites

In order to compile this project, you must have Xcode and cocoapods installed on your Mac

* Xcode can be installed [here](https://developer.apple.com/xcode/)
* [Here](https://stackoverflow.com/questions/20755044/how-to-install-cocoapods) is a post on how to install Cocoapods

### Installing

Once you have cloned the project repo, navigate to the project directory using your terminal

```zsh
cd path/to/project
```

After navigating to the project, install pods

```zsh
pod install
```

Make sure to open "My Dex.xcproj". The project should now be able to run either on the simulator or on your device.
Make sure to change the bundle identifier for the project

## Built With

* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Library to handle downloading and caching images in iOS
* [PokéApi V2](https://pokeapi.co/) - API used to retrieve Pokémon data from

## What I Learned

Although this isn't my first project that doesn't use storyboards, it is worth noting it

After using Alamofire and SwiftyJSON for a few projects, I became curious about networking and parsing JSON without using Cocoapods libraries. I found [this](https://matteomanferdini.com/codable/) article by Matteo Manferdini that cleared up several confusions I had about the topic. He also had a pretty compelling argument on why you shouldn't use libraries

I can now confidently use the Decodable protocol and setup custom coding keys to parse the JSON obtained from the PokéApi

I also learned how to use URLSessions to create data tasks for fetching the JSON from the Api. Since each Pokémon needed to call the Api for data, I also learned to use dispatch groups to sync the data fetches and update the ui once all data fetches are complete

## Licensing

The code in this project is licensed under MIT license
