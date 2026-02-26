## [3.0.0]
- `s_packages` dependency upgraded to ^3.0.0

 
## 2.1.0
- `s_packages` dependency upgraded to ^1.3.0
- Added `successDuration` and `errorDuration` for configurable state display timing
- Added `loadingWidget` for custom loading indicator replacement

## 2.0.0
- package no longer holds the source code for it, but exports/exposes the `s_packages` package instead, which will hold this package's latest source code.
- The only future changes to this package will be made via `s_packages` package dependency upgrades, in order to bring the new fixes or changes to this package
- dependent on `s_packages`: ^1.1.2



## 1.0.0

* **Initial stable release**: SFutureButton widget with full async operation support
* **Automatic state management**: Handles loading, success, error, and reset states
* **Future return value handling**:
  - Returns `true`: Shows success animation
  - Returns `false`: Shows error state with validation message
  - Returns `null`: Silent dismissal without animation
  - Throws exception: Shows error state with exception message
* **Customizable UI**:
  - Configurable button dimensions (height, width)
  - Custom background and icon colors
  - Border radius customization
  - Elevated or flat button styles
  - Optional error message display
* **Callbacks and hooks**:
  - `onPostSuccess`: Called after successful operation completion
  - `onPostError`: Called after error state display
* **Accessibility features**:
  - Focus node support
  - Focus change callbacks
  - Disabled state handling with SDisabled
* **Animation features**:
  - Smooth squeeze animation on tap
  - Loading circle indicator with configurable size
  - Success/error state animations with bounce effect
  - 1.5-second error display before auto-reset
* **State persistence**: Button state survives hot reload
* **Dependencies**: Uses RxDart for reactive state management and states_rebuilder for state management
