# PaybackFeedDemo

To get it up and running -
clone
pod install
open MyGitHub.xcworkspace

Time Taken - 28 Hours.

What is completed:

// TableView cells - 
Has different type of cells, which have dynanic sizes. 
    video cell - plays a full screen video
    image cell - will open the content in a child view controller
    shopping cell- Has a text feild and a shopping list. Shopping List is saved in User defaults and can be deleted using left swipi gesture.
    website cell -  will open the website in webView.
Pull to refresh

// Data Persistence- 
Saves the Feed Data to UserDefaults.
which will be reset in 24 hours.

Error Handling - API Faliure, Image Fetching failures.

What isnt in this PR yet:
Unit Tests (Est: 3 Hours)
Pagination - if feed api has a next token, we can implement pagination
Create a seperate shopping list tab for user to delete multiple items.


Third parties libraries used:
AlamoFire - for networking,
Kingfisher - for loading images.
