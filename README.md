# Garmin Instinct 2S Custom Data Field

A custom Garmin Connect IQ data field designed specifically for the **Garmin Instinct 2S**.

This project creates a compact multi-metric activity display that works alongside the Instinct 2S's circular secondary display.

## Features

The custom data field displays:

* **Current Time** — 12-hour format with AM/PM
* **Elapsed Activity Time**
* **Distance** — miles
* **Current Elevation** — feet
* **Total Ascent** — feet
* **Total Descent** — feet

The field is designed to be used in a **two-field activity layout** on the Instinct 2S.

The Garmin native **Heart Rate** field can be assigned to the circular display, while this Connect IQ data field occupies the main display.

## Intended Layout

```text
 Current Time        [ HR ]
 Elapsed Time        [ ❤️ ]

---------------------------

    Distance | Elevation

---------------------------

       Total Ascent

---------------------------

       Total Descent
```

The circular heart-rate field is provided by Garmin and is not drawn by this Connect IQ application.

## Development Environment

This project was developed using:

* Garmin Connect IQ SDK
* Monkey C
* Visual Studio Code
* Garmin Monkey C VS Code extension
* Java JDK 17
* Garmin Instinct 2S simulator

## Requirements

To modify or build the project, install:

1. [Visual Studio Code](https://code.visualstudio.com/)
2. [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/)
3. Garmin's **Monkey C** extension for VS Code
4. Java JDK 17 or another compatible Java version
5. A Garmin Connect IQ developer key

## Building

Open the project folder in Visual Studio Code.

Use the Command Palette:

```text
Ctrl + Shift + P
```

Then run:

```text
Monkey C: Build Current Project
```

Select the **Garmin Instinct 2S** as the target device.

A successful build will create a `.prg` file in the project's `bin` directory.

## Simulator

The project can be tested using Garmin's Connect IQ simulator.

With the project open in VS Code, press:

```text
F5
```

Select the **Instinct 2S** simulator if prompted.

Activity/FIT simulation data can be used to test changing values such as distance, elapsed time, elevation, ascent, and descent.

## Installing on an Instinct 2S

Build the project for the Instinct 2S.

Connect the watch to the computer using USB and copy the generated `.prg` file into:

```text
GARMIN/APPS/
```

Safely disconnect the watch.

On the Instinct 2S:

1. Open the desired activity.
2. Open the activity settings.
3. Edit **Data Screens**.
4. Select a **two-field layout**.
5. Assign Garmin's native **Heart Rate** field to the circular field.
6. Assign this Connect IQ data field to the main field.

## Units

The Connect IQ activity API provides distance and elevation measurements in metric units.

This project converts:

* Meters → **Miles** for distance
* Meters → **Feet** for elevation
* Meters → **Feet** for ascent
* Meters → **Feet** for descent

## Project Status

The project is currently designed and tested for the **Garmin Instinct 2S**.

Other Garmin devices may require changes to the display layout, coordinates, fonts, or supported-device configuration.

## Security

Garmin Connect IQ developer keys should **never be committed to a public Git repository**.

The project's `.gitignore` excludes common developer-key and compiled application files.

## License

This project is provided for personal and educational use.
