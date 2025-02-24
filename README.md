# display-arranger
display-arranger is command-line application designed to make interacting with your connected displays a bit simpler. It provides you easy access to information about your displays in addition to affording you the ability to easily alter your display arrangement, or mouse-cursor position from the command line or via a separate scripting tool.

# Usage
Usage:
```
display-arranger

# Basic/Info commands
[-h, --help] Shows the help text
[-v, --version] Shows the version of the application

# Query/List commands
[-i, --info] Shows information about the connected displays
[-l, --list-displays] Returns the ids for all connected displays
[-L, --list-positions] Displays a list of the supported positions for --arrange argument

# Action commands
[-p, --primary <DisplayId>] Pass the id of the display that you want to make the primary display (dock/menu bar)
[-a, --arrange <DisplayId> <Position> <ReferenceDisplayId>] Used in conjunction with --primary to control the position of your other displays. Order is important, see README for additional usage details.
[-m, --move] Moves the mouse cursor to the given coordinates on the main display (example: 100,100)
```


Note: For the --arrange command, <ReferenceDisplayId> is optional (defaults to the main display if not included) and is used to determine which screen the included position parameter refers to when laying out your display arrangement. Order of arguments received is important for this command. If you are using a secondary screen as the reference for another secondary screen, the reference display's frame must already be determined, either by itself having referenced the main screen or another anchored display prior to itself being used as a reference. For example: `display-arranger --primary 1234 -a 5678 on-left:above -a 9012 on-left:bottom-aligned 5678` is valid and unambiguous, whereas `display-arranger --primary 1234 -a 9012 on-left:bottom-aligned 5678 -a 5678 on-left:above` will not have the information necessary at runtime to provide 9012 with a reference frame. This will result in 9012's position not being set as intended.

# Installation
To install display-arranger, you can either download the latest release from the [releases page](https://github.com/namolnad/display-arranger/releases) or build the application from source. To build from source, clone the repository and run the following commands in the root directory of the project:
``` swift
swift build -c release
cp .build/release/display-arranger /usr/local/bin/display-arranger
```

# Acknowledgements
display-arranger is a derivative work of [hmscreens](http://www.hamsoftengineering.com/codeSharing/hmscreens/hmscreens.html) and started as a Swift rewrite of that application. Much of the visible functionality remains quite similar to the original product, though display-arranger adds several useful/more robust features and incorporates various technical improvements.

# License
display-arranger is licensed under the [Apache 2.0 license](http://www.apache.org/licenses/LICENSE-2.0) (see LICENSE for complete list of affordances)

Copyright 2018 Daniel Loman

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
