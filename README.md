# Xor-AthocDemo

## Overview
This is the demo project created for AtHoc iOS team. 
The main intention for this project is to provide the idea on Coding Standards, MVVM architecture, Project Structure using simple registration form and welcome dashboard screen.

## Contents

* [Problem Statement and Solution]
  + [Problem Statement]
  + [Solution]
* [Requirements]
* [Project Details]
  + [Architecture]
  + [Standards]
  + [Project Structure]
  + [Database]
  + [Documentations and Comments]
* [Installation]
* [Usage]

## Problem Statement and Solution

### Problem Statement

Design a Registration screen where you have a drop-down, to select from a Phone Number or email address, an edit field, and submit button.
* The edit field should have validation for phone number/email address whatever the user has chosen earlier.
* On clicking on Submit button, the app should navigate to another screen where it will call an API for verification, and until API returns the response as a success, wait on the same screen. You must display "Thank you for registering. We have sent a confirmation to <add number or email address> on that screen. (For this problem, you can assume that API returns the response after the 30s). You can also cover negative scenarios (error cases) if you have time.
* Once the email or phone verification is completed, show a Welcome screen and it should display the entered Phone Number /Email. You can assume that verification is done in the 30s(can hardcode this value).
*If you will kill & re-launch the app after registration, it should start from the Welcome screen and it should display the entered Phone Number /Email.

### Solution
This demo app shows the Regsitration screen on launch with a menu to select from Phone or Email and textfield to enter the selected data.
The text field data get validated before being verified and shows the error message if invalid. Post verification success user data is stored in database for welcome screen that shows the user data fetched from local database on next launch of app.
  
Technical details of this solution is provided below in `Project Details`

## Requirements
* Xcode 14.2
* Swift 5

## Project Details

### Architecture
This demo project follows the MVVM architecture.

### Standards
Swift coding standards are followed to maintain the hydein and clean classes

### Project Structure
Each module is separated in group with its corresponding files

### Database
  To store the user information Coredata is used.

### Documentations and Comments
Find the class and method documentation with multiple line and signle line comment.
Helper comments are provided above the  corresponsponding  line.

## Installation
Simply donwnload the project and run `XorAthoc-Demo.xcodeproj` file in Xcode.

** No External Dependecies Required **

## Usage
Run the application on iOS 15 and above. Enter the Email or Phone number for registration and sit back until you get verified.

## Author
**Sahil Ratnani**

<!--- In file -->
[Problem Statement and Solution]: #problem-statement-and-solution
[Problem Statement]: #problem-statement
[Solution]: #solution
[Requirements]: #requirements
[Project Details]: #project-details
[Architecture]: #architecture
[Standards]: #standards
[Project Structure]: #project-structure
[Database]: #database
[Documentations and Comments]: #documentations-and-comments
[Installation]: #installation
[Usage]: #usage
