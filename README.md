# Pre-work - **Tippy**

**Tippy** is a tip calculator application for iOS.

Submitted by: **Pavel Savva**

Time spent: **11** hours spent in total

## User Stories

The following **required** functionality is complete:

* [x] User can enter a bill amount, choose a tip percentage, and see the tip and total values.

The following **optional** features are implemented:
* [x] Settings page to change the default tip percentage.
* [x] UI animations
* [x] Remembering the bill amount across app restarts (if <10mins)
* [x] Using locale-specific currency and currency thousands separators.
* [x] Making sure the keyboard is always visible and the bill amount is always the first responder. This way the user doesn't have to tap anywhere to use this app. Just launch the app and start typing.

The following **additional** features are implemented:
- [x] Add a light/dark color theme to the settings view. In viewWillAppear, update views with the correct theme colors.
- [x] Add animations to your UI
- [x] The Tip calculator has a very primitive UI. Feel free to play with colors, layout, or even modify the UI to improve it.
- [ ] Add app icon
- [ ] Change app name to Tippy (from tippy)
- [ ] Add an option to change the default tip percentages
- [ ] Add an option to split the bill between x people


## Video Walkthrough 

[Here's a walkthrough of implemented user stories](https://i.imgur.com/X29HC6T.mp4)

GIF created with `xcrun simctl io booted recordVideo ~/Desktop/walhrough.mp4` command.

## Notes

In the project set up screen I had to make sure to create a Storyboard and not a SwiftUI project.

## License

    Copyright 2019 Pavel Savva

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
