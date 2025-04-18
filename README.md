# PyroByte Adaptive Cards Boilerplate

A simple boilerplate for implementing Adaptive Cards in FiveM scripts during the player connection process (deferrals).

## Overview

This boilerplate provides examples of using Adaptive Cards with deferrals in FiveM. It includes various card types and interactions that can be used during the player connection process.

## Features

- **Simple Cards**: Basic cards with a single action
- **Form Cards**: Cards with input fields for user data
- **Complex Cards**: Advanced layouts with custom visual elements
- **Card Switching**: Seamless transitions between different cards
- **Timeout Handling**: Built-in timeout functionality with countdown

## File Structure

- `functions.lua`: Contains helper functions for creating Adaptive Cards
- `sv_main.lua`: Main server file with implementation examples
- `fxmanifest.lua`: Resource manifest file

## Examples Included

1. **Main Menu Card**: Simple card with multiple actions
2. **Recovery Form Card**: Form with input field for recovery code
3. **Success Message**: Standard deferral message for successful actions
4. **Timeout Screen**: Countdown timer for failed attempts
5. **Welcome Card**: Complex card with server information and rules acceptance

## Implementation Details

### Card Types

The boilerplate includes functions for creating different types of cards:

- `CreateSimpleCard`: Basic card with a title, message, and single button
- `CreateMultiActionCard`: Card with multiple action buttons
- `CreateFormCard`: Card with input fields for user data
- `CreateComplexCard`: Card with custom layout and visual elements

### Deferral Flow

The main connection handler in `sv_main.lua` demonstrates a complete flow:

1. Initial connection and loading
2. Main menu presentation
3. Form handling for account recovery
4. Success/failure handling
5. Timeout implementation with countdown
6. Final connection approval

## Installation

1. Copy the resource to your server's resources folder
2. Add `ensure pyro_adaptivecards` to your server.cfg
3. Restart your server or start the resource manually

## Customization

You can customize the cards by modifying the card creation functions in `functions.lua` or directly in `sv_main.lua`. The example includes placeholder image URLs that should be replaced with your own images.

## Requirements

- FiveM server
- Basic knowledge of Lua programming

## License

This boilerplate is provided as-is for use by the PyroByte team and authorized users.

## Credits

Developed by the PyroByte team.
