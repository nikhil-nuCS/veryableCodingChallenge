# Veryable iOS Coding Challenge - Nikhil Khandelwal
##### Installation
- A new testing target is added to perform basic unit testing. In addition, the SnapKit pod is added as a dependency for the testing target.
- This may require running 'pod install' before building/running the test target of the project.

##### Motivation for approaches

###### Combine Framework
- The app requires making an API call to a REST endpoint and receiving JSON data in response. This can be achieved using URLSession dataTask or another 3rd party library. For the project, I have used the Combine framework as an alternative to callbacks or delegate methods. Combine allows chaining and transforming operations and enables publisher-subscriber patterns through the app. 
- The function coded is generic and can be used by different API services to fulfill their request. In this, the AccountService class uses Combine to fetch, parse and populate the accounts received via the REST call.

###### Enum Approach for Account type
- Since the project required recreating the UI available in Wireframe.pdf, I have used an enum approach to identify and group the different account types. Analyzing the JSON, only bank and card account types are currently available. These are coded in the enum AccountType. The enum is made CaseIterable for counting and populating the sections of the tableView. The order of the tableView depends on the order of the enum definition.
- Another approach would be a data-driven model for populating the tableView. The tableView is driven by the JSON rather than the structs/enums coded in the app. In this approach, the enum type would be replaced by String, and the accounts will be grouped based on the parsed values of the JSON. This would eliminate the need to modify code when there is a change in the JSON in the form of a new account type. Instead, the table view would automatically handle the changes. However, a limitation in this approach exists. The order of the sections may change with each passing unless the order of the sections is hard coded.
- For this exercise, an enum approach is followed since the account types are limited and known.

###### Unit Testing
- A few unit test cases have been written to test different views and perform unit testing on the logic.
- The purpose is to demonstrate the use of mockable classes and the XCTest framework.
