# fiori_flutter

This is a simple business application intended potentially for keeping track of product inventory. While this application was created using Flutter and MaterialUI, the UI is meant to mimic SAP Fiori Design Guidelines and includes a List Report Page and Object Detail Page.

This is the second in a series of Flutter applications made primarily relying on Github CoPilot. The first application can be found here: https://github.com/MindsetConsulting/com.mindset.copilot_flutter
## Functionality

This flutter application was created to simulate an SAP Fiori mobile application. Fiori design guidelines were used as a general rule but not followed specifically as this is a Flutter application that still uses MaterialUI is its front-end design system. The application's main page is a List Report Page with a list of products. The main page allows you to view a list of products, add new products, delete old products using the edit button, and navigate to an Object Detail Page for each product. From the Object Detail Page a user can view all relevant detail for the item, adjust the quantity of the item, approve or reject the item, add a note about the item (with the days date auto populated with the note), and edit the item. The edit button takes the user to a separate screen for editing the item details (NOTE: saving edited information functionality was NOT completed in this PoC sprint).

## How it was built

This app was built in with 7 days of development time by a single developer who had very minimal Flutter experience using VSCode and Github CoPilot Chat. As the goal of this Proof of Concept project was to see how many features could be put into this single app, not everything was finished but it is mostly functional. This app is a front-end only application.

## Github Copilot

Github CoPilot was used extensively to create this application. The purpose of this project was to explore more of the capabilities and limitations of Github CoPilot. Some of the findings are:
PROS:
- Development work is so much faster! Especially if you know specifically what you want and the architecture of your application. You can create a functioning application in an incredibly short amount of time.
- For less experienced developers, the ability for CoPilot to explain chunks of code is incredibly invaluable. This application was created by a developer with less than 2 weeks experience developing in Flutter and Dart.

CONS:
- CoPilot Chat currently cannot see all of your code at once. It knows the code examples it has given you, but if you write custom code it cannot see it. This requires you to either regularly paste snippets of your code into the chat or only work on very small pieces of functionality at a time. It would be better if CoPilot could have access to all of your code and see how it works as a whole, particularly the code gets broken down into smaller components and separate files.
- CoPilot Chat can sometimes get itself stuck in a "loop" of responses and will make up resources that don't exist. Especially when it comes to dependencies or third-party libraries, it will just make up a library that doesn't exist but with a name that sounds like something you need.

## Video

A short video demonstrating the app: https://youtu.be/hrLPm8RkRpM
