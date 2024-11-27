# WRUV
Created by Lucas Mayo, Wade Bradford, Max Schwarz, and John Driscoll

## Overview
WRUV is an iOS app designed to stream live and previous radio shows hosted by the University of Vermont's student-run local radio station, WRUV. Programmed using Swift/SwiftUI, it provides users with the ability to listen to WRUV live streams and comment in a live text channel linked to a personal account.

## Features
**Player**<br>
**Spinitron**<br>
**Archives**<br> 
**Chat**<br>
* The WRUV website has functionality that enables listeners to talk music with the DJ and other listeners without needing to call into the station. The site implements this functionality via custom PHP and SQL. Instead, we've used Google Firebase documents containining chat UUIDs, text, sending user, and a timestamp. The latter field enables us to specifically request new documents from the time of the last query in sequential order. Query latency is thus very fast. We borrowed a bit of retro styling as seen on WRUV's website for the styling of the app chat, which uses black Courier font. 

## Views
- Home Screen: Displays the WRUV logo and lists the upcoming schedule of shows.
- Chat Screen: A live text chat for users to communicate with each other and the DJ.
- Archives Screen: A catalog of previous shows hosted on WRUV that are available to listen back to.
- Account Screen: Displays the user's account info: chatName and email.

### Package Dependencies
Our app requires the FirebaseCore, FirebaseAuth, and FirebaseFirestore packages contained within the Firebase iOS SDK repository. 

### Bugs and Known Issues
There are no known bugs at this time.
