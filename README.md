# Garmin Instinct 2, Instinct 2S, and Forerunner 255S Custom Data Field

A custom Garmin Connect IQ data field designed for the **Garmin Instinct 2S, Instinct 2, and Forerunner 255S**.

This project provides a compact multi-metric activity display optimized for hiking and other outdoor activities. Device-specific layouts are used to take advantage of the different screen sizes and designs of each supported watch.

## Supported Devices

* **Garmin Instinct 2S** — 156 × 156 display
* **Garmin Instinct 2** — 176 × 176 display
* **Garmin Forerunner 255S** — 218 × 218 display

Each device uses a layout specifically adjusted for its display size.

## Features

The custom data field displays:

* **Current Time** — 12-hour format with AM/PM
* **Elapsed Activity Time**
* **Distance** — miles
* **Current Elevation** — feet
* **Total Ascent** — feet
* **Total Descent** — feet

The **Forerunner 255S layout** additionally displays:

* **Current Heart Rate**
* **Battery Percentage**
* **Notification Indicator** — displayed when notifications are present

## Instinct 2 / Instinct 2S Layout

The field is designed to be used in a **two-field activity layout** on the Instinct 2 and Instinct 2S.

Garmin's native **Heart Rate** field can be assigned to the circular secondary display while this Connect IQ data field occupies the main display.

```text
 Current Time        [ HR ]
 Elevation           [ ♥  ]

---------------------------

    Distance | Elapsed Time

---------------------------

       Total Ascent

---------------------------

       Total Descent
```

The circular heart-rate field is provided by Garmin and is not drawn by this Connect IQ application.

## Forerunner 255S Layout

The Forerunner 255S uses a dedicated **218 × 218** layout designed for its larger circular display.

Unlike the Instinct models, the Forerunner layout displays heart rate directly within the Connect IQ data field.

The Forerunner 255S layout includes:

* Current time
* Current heart rate
* Battery percentage
* Notification indicator
* Distance
* Elapsed activity time
* Current elevation
* Total ascent
* Total descent

## Development Environment

This project was developed using:

* Garmin Connect IQ SDK
* Monkey C
* Visual Studio Code
* Garmin Monkey C VS Code extension
* Java JDK 17
* Garmin Connect IQ Simulator

The project has been tested using the:

* Garmin Instinct 2S simulator
* Garmin Instinct 2 simulator
* Garmin Forerunner 255S simulator

## Requirements

To modify or build the project, install:

1. [Visual Studio Code](https://code.visualstudio.com/)
2. [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/)
3. Garmin's **Monkey C** extension for Visual Studio Code
4. Java JDK 17 or another compatible Java version
5. A Garmin Connect IQ developer key

## Building

Open the project folder in Visual Studio Code.

Open the Command Palette:

```text
Ctrl + Shift + P
```

Then run:

```text
Monkey C: Build Current Project
```

Select the desired target device:

```text
Garmin Instinct 2S
Garmin Instinct 2
Garmin Forerunner 255S
```

A successful build creates a device-specific `.prg` file in the project's `bin` directory.

## Simulator

The project can be tested using Garmin's Connect IQ Simulator.

With the project open in Visual Studio Code, build the project for the desired device and press:

```text
F5
```

Activity/FIT simulation data can be used to test changing values such as:

* Distance
* Elapsed time
* Heart rate
* Elevation
* Total ascent
* Total descent

The simulator is also useful for testing long values to ensure that text remains within the available display area.

## Manual Installation

Build the project for the specific Garmin device on which it will be installed.

Connect the watch to the computer using USB and copy the generated `.prg` file into:

```text
GARMIN/APPS/
```

Safely disconnect the watch.

The `.prg` file is device-specific, so make sure the project is built for the correct watch before sideloading.

## Setting Up on Instinct 2 / Instinct 2S

After installing the data field:

1. Open the desired activity, such as **Hike**.
2. Open the activity settings.
3. Select **Data Screens**.
4. Select or create a **two-field layout**.
5. Assign Garmin's native **Heart Rate** field to the circular field.
6. Assign this Connect IQ data field to the main field.

This configuration allows the Garmin native heart-rate display and the custom hiking data field to operate together on one screen.

## Setting Up on Forerunner 255S

After installing the data field:

1. Open the desired activity, such as **Hike**.
2. Open the activity settings.
3. Select **Data Screens**.
4. Select or create a **one-field data screen**.
5. Assign this Connect IQ data field to the screen.

Heart rate is displayed directly by the custom data field on the Forerunner 255S, so a separate Garmin heart-rate field is not required.

## Units

The Connect IQ activity API provides distance and elevation measurements in metric units.

This project converts:

* Meters → **Miles** for distance
* Meters → **Feet** for current elevation
* Meters → **Feet** for total ascent
* Meters → **Feet** for total descent

## Device-Specific Layouts

The application detects the available display width and uses a layout optimized for that screen.

Current layouts include:

```text
156 px  → Instinct 2S
176 px  → Instinct 2
218 px  → Forerunner 255S
```

This allows the activity calculations and data handling to remain shared while the visual layout is customized for each display.

## Project Status

Current support:

* **Garmin Instinct 2S** — supported and tested
* **Garmin Instinct 2** — supported and tested
* **Garmin Forerunner 255S** — supported and tested in the Connect IQ Simulator

Additional Garmin Connect IQ devices may be added in the future.

Other devices may require adjustments to display coordinates, fonts, screen layouts, and supported-device configuration.

## Security

Garmin Connect IQ developer keys should **never be committed to a public Git repository**.

The project's `.gitignore` excludes common developer-key and compiled application files.

## License

This project is provided for personal and educational use.