# Bitpanda Task

## Setup 

 - Xcode: 13.2.1 
 - iOS Deployment Target: 13.0  
 - Swift 5
 - Resolve swift package versions

## General

- Full dark mode support while taking into account the right logo for each mode (Inverted fiat logos to match design).
- All app list view inherits from the base `SearchableTableViewController` with a search by name or symbol functionality and animated data reload.
- Using a custom decoder to bypass the nested JSON data and flatten it to usable objects.
- Used logos from Asset data to compute the logos for Wallet data as they are required and missing.

<p align="center">
 <img src="https://github.com/eldesouky/Bitpanda-Task/blob/master/Readme%20Gifs/apperance_support.gif" alt="Apperance Support">
</p>

## Splash Screen

- Splash animation added.
- Used tinting method to support different appearance modes (color the logo), due to lack of asset resources. In a real project, I would have used 2 images (one for each mode). Hence, there might be a very slight flicker in the animation.

<p align="center">
 <img src="https://github.com/eldesouky/Bitpanda-Task/blob/master/Readme%20Gifs/splash.gif" alt="Splash Screen">
</p>

## Asset Screen

- Segment control to filter between crypto coins, commodities, or fiats assets.
- Horizontal scrolling gestures to switch between different segments.
- Reading the requirement "price must take the regional **location** of the device into account" made me doubt that it means (1) to fetch the actual user geo location and not (2) the user's locale. Aside from that, the first option will require user permission, and the second doesn't, as a user, I always want to see content formatted according to my preferences and not where I currently am. (German traveler would want to see the data in German format even when he is on a visit to the US). Hence, I assumed the second option. In a real project, I would have communicated my doubts and concerns with the product owner beforehand.
- Precision requirements applied for crypto coins, commodities.
- Only fiats with wallets are displayed
- Data sorted ascending by name.

## Wallets Screen

- Grouped wallets as: All, Fiat wallets, Crypto wallets, and Commodity wallets.
- Clicking a wallet group pushes a `WalletListViewController` on the navigation stack.
- Wallets sorted descending by balance.
- Used the same formatting mechanism as with the Asset prices (fixed precision to 2 decimal places).
- Default wallets tagged.
- Deleted wallets hidden.
- Fiat wallets cells uniquely designed. 
- Wallet group's sum added in `WalletListViewController` table view header.

## Showcase
<p align="center">
 <img src="https://github.com/eldesouky/Bitpanda-Task/blob/master/Readme%20Gifs/light_mode.gif" alt="Light Mode">
  <img src="https://github.com/eldesouky/Bitpanda-Task/blob/master/Readme%20Gifs/dark_mode.gif" alt="Dark Mode">
</p>

## Packages Used
 - KingFisher
 - Pocket SVG

## Future Work (If it was a real project)

- Apply GitFlow.
- Add localization.
- Add linter.
- Increase unit testing coverage.
- Add UI testing.
- Split `AssetInterface` and `WalletInterface` based on future progress.
- Network:
  - Separate network layer with generic decoding.
  - data persistence.
