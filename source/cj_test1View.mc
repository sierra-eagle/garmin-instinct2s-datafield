using Toybox.Activity;
using Toybox.Graphics;
using Toybox.System;
using Toybox.WatchUi;

class cj_test1View extends WatchUi.DataField {

    var elapsedTime;
    var distanceMiles;
    var ascentFeet;
    var descentFeet;
    var altitudeFeet;
    var heartRate;

    function initialize() {
        DataField.initialize();

        elapsedTime = 0;
        distanceMiles = 0.0;
        ascentFeet = 0;
        descentFeet = 0;
        altitudeFeet = 0;
        heartRate = 0;
    }


    function compute(info) {

        // ---------------------------------
        // ELAPSED ACTIVITY TIME
        // Garmin provides this in milliseconds
        // ---------------------------------
        if (info.elapsedTime != null) {
            elapsedTime = info.elapsedTime;
        }

        // ---------------------------------
        // DISTANCE
        // Garmin provides meters
        // Convert to miles
        // ---------------------------------
        if (info.elapsedDistance != null) {
            distanceMiles =
                info.elapsedDistance / 1609.344;
        }

        // ---------------------------------
        // TOTAL ASCENT
        // Convert meters to feet
        // ---------------------------------
        if (info.totalAscent != null) {
            ascentFeet =
                (info.totalAscent * 3.28084).toNumber();
        }

        // ---------------------------------
        // TOTAL DESCENT
        // Convert meters to feet
        // ---------------------------------
        if (info.totalDescent != null) {
            descentFeet =
                (info.totalDescent * 3.28084).toNumber();
        }

        // ---------------------------------
        // CURRENT ELEVATION
        // Convert meters to feet
        // ---------------------------------
        if (info.altitude != null) {
            altitudeFeet =
                (info.altitude * 3.28084).toNumber();
        }

        // heart rate 
        if (info.currentHeartRate != null) {
            heartRate = info.currentHeartRate;
        }

        return distanceMiles;
    }

function drawClockIcon(dc, x, y) {

    // Clock outline
    dc.drawCircle(
        x,
        y,
        8
    );

    // Hour hand
    dc.drawLine(
        x,
        y,
        x,
        y - 5
    );

    // Minute hand
    dc.drawLine(
        x,
        y,
        x + 4,
        y
    );
}


function drawHeartIcon(dc, x, y) {

    // Left half
    dc.fillCircle(
        x - 4,
        y - 3,
        5
    );

    // Right half
    dc.fillCircle(
        x + 4,
        y - 3,
        5
    );

    // Lower part of heart
    dc.fillPolygon([
        [x - 9, y - 2],
        [x + 9, y - 2],
        [x, y + 10]
    ]);
}



   function onUpdate(dc) {

    dc.setColor(
        Graphics.COLOR_BLACK,
        Graphics.COLOR_WHITE
    );

    dc.clear();


    // =================================
    // CURRENT CLOCK TIME
    // =================================

    var clock = System.getClockTime();

    var hour = clock.hour;
    var minute = clock.min;

    // Used for testing total clock width:
    // var hour = 11;
    // var minute = 58;

    var suffix = "AM";

    if (hour >= 12) {
        suffix = "PM";
    }

    if (hour == 0) {
        hour = 12;
    } else if (hour > 12) {
        hour -= 12;
    }

    var clockString =
        hour.format("%d") +
        ":" +
        minute.format("%02d");


    // =================================
    // ELAPSED ACTIVITY TIME
    // =================================

    var totalSeconds = (elapsedTime / 1000).toNumber();
    var elapsedHours = (totalSeconds / 3600).toNumber();
    var elapsedMinutes = ((totalSeconds % 3600) / 60).toNumber();
    var elapsedSeconds = (totalSeconds % 60).toNumber();
    var elapsedString;

    if (elapsedHours > 0) {

        elapsedString =
            elapsedHours.format("%d") +
            ":" +
            elapsedMinutes.format("%02d") +
            ":" +
            elapsedSeconds.format("%02d");

    } else {

        elapsedString =
            elapsedMinutes.format("%d") +
            ":" +
            elapsedSeconds.format("%02d");
    }


    // =================================
    // FORMAT ACTIVITY VALUES
    // =================================

    var distanceString = distanceMiles.format("%.2f");
    var elevationString = altitudeFeet.format("%d");
    var ascentString = ascentFeet.format("%d");
    var descentString = descentFeet.format("%d");
    var heartRateString = heartRate.format("%d");

    // =================================
    // notifications info 
    // =================================
  
    var deviceSettings = System.getDeviceSettings();
    var notificationCount = deviceSettings.notificationCount;
    //var notificationCount = 1;  //used for testinig notification icon display

    // =================================
    // battery info
    // =================================
    
    var systemStats = System.getSystemStats();
    var batteryPercent = systemStats.battery.toNumber();
    var batteryString = batteryPercent.format("%d") + "%";

    // =================================
    // DETECT DEVICE SCREEN SIZE
    // =================================

    var width = dc.getWidth();

    if (width == 218) {   //255s section


        // =================================
        // notification ICON
        // =================================

        if (notificationCount > 0) {

            dc.drawText(
                109,
                24,
                Graphics.FONT_XTINY,
                notificationCount.format("%d"),
                Graphics.TEXT_JUSTIFY_CENTER
            );
        }


        // =================================
        // HEART ICON
        // =================================

        drawHeartIcon(
            dc,
            160,
            30
        );


        // =================================
        // HEART RATE
        // =================================

        dc.drawText(
            160,
            41,
            Graphics.FONT_MEDIUM,
            heartRateString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // CLOCK ICON
        // =================================

        drawClockIcon(
            dc,
            68,
            30
        );
        
        // =================================
        // CURRENT TIME 255
        // =================================

        dc.drawText(
            87,
            42,
            Graphics.FONT_MEDIUM,
            clockString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        // AM / PM

        dc.drawText(
            93,
            50,
            Graphics.FONT_XTINY,
            suffix,
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // BATTERY PERCENTAGE
        // TOP CENTER
        // =================================

        dc.drawText(
            109,
            2,
            Graphics.FONT_XTINY,
            batteryString,
            Graphics.TEXT_JUSTIFY_CENTER
        );

        // =================================
        // CURRENT ELEVATION 255
        // =================================

        dc.drawText(
            129,
            183,
            Graphics.FONT_SMALL,
            elevationString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            135,
            189,
            Graphics.FONT_XTINY,
            "ft",
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // FIRST HORIZONTAL DIVIDER 255
        // =================================

        dc.drawLine(
            22,
            73,
            196,
            73
        );


        // =================================
        // DISTANCE 255
        // =================================

        dc.drawText(
            55,
            76,
            //Graphics.FONT_LARGE,
            Graphics.FONT_NUMBER_MILD,
            distanceString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // ELAPSED ACTIVITY TIME 255
        // =================================

        dc.drawText(
            163,
            76,
            //Graphics.FONT_LARGE, 
            Graphics.FONT_NUMBER_MILD,
            elapsedString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // VERTICAL DIVIDER LINE 255
        // =================================

        dc.drawLine(
            109,
            78,
            109,
            117
        );


        // =================================
        // SECOND HORIZONTAL DIVIDER 255
        // =================================

        dc.drawLine(
            22,
            120,
            196,
            120
        );


        // =================================
        // ELEVATION GAIN/UP 255
        // =================================

        dc.drawText(
            82,
            122,
            Graphics.FONT_SMALL,
            "UP",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            188,
            122,
            Graphics.FONT_SMALL,
            ascentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );


        // =================================
        // THIRD HORIZONTAL DIVIDER 255
        // =================================

        dc.drawLine(
            22,
            150,
            196,
            150
        );

        // =================================
        // FOURTH HORIZONTAL DIVIDER 255
        // =================================

        dc.drawLine(
            22,
            180,
            196,
            180
        );

        // =================================
        // ELEVATION LOSS/DOWN 255
        // =================================

        dc.drawText(
            82,
            153,
            Graphics.FONT_SMALL,
            "DOWN",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            188,
            153,
            Graphics.FONT_SMALL,
            descentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );


    // ============================================================
    //
    // INSTINCT 2
    // 176 x 176
    //
    // ============================================================

    } else if (width == 176) { // instinct2 section


        // =================================
        // CURRENT TIME
        // =================================

        dc.drawText(
            70,
            10,
            Graphics.FONT_SMALL,
            clockString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        // AM / PM

        dc.drawText(
            75,
            10,
            Graphics.FONT_XTINY,
            suffix,
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // CURRENT ELEVATION
        // =================================

        dc.drawText(
            80,
            35,
            Graphics.FONT_MEDIUM,
            elevationString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            87,
            38,
            Graphics.FONT_XTINY,
            "ft",
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // FIRST HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            8,
            66,
            164,
            66
        );


        // =================================
        // DISTANCE
        // =================================

        dc.drawText(
            43,
            77,
            Graphics.FONT_LARGE,
            distanceString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // ELAPSED ACTIVITY TIME
        // =================================

        dc.drawText(
            124,
            77,
            Graphics.FONT_LARGE,
            elapsedString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // VERTICAL DIVIDER
        // =================================

        dc.drawLine(
            82,
            72,
            82,
            116
        );


        // =================================
        // SECOND HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            8,
            118,
            164,
            118
        );


        // =================================
        // ELEVATION GAIN
        // =================================

        dc.drawText(
            68,
            121,
            Graphics.FONT_XTINY,
            "UP",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            145,
            119,
            Graphics.FONT_SMALL,
            ascentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );


        // =================================
        // THIRD HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            8,
            145,
            164,
            145
        );


        // =================================
        // ELEVATION LOSS
        // =================================

        dc.drawText(
            73,
            148,
            Graphics.FONT_XTINY,
            "DOWN",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            145,
            146,
            Graphics.FONT_SMALL,
            descentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );


    // ============================================================
    //
    // INSTINCT 2S
    // 156 x 156
    //
    // ============================================================

    } else {  //instinct2s section


        // =================================
        // CURRENT TIME
        //
        // Upper-right intentionally left
        // open for Garmin HR circle.
        // =================================

        dc.drawText(
            70,
            3,
            Graphics.FONT_LARGE,
            clockString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        // AM / PM

        dc.drawText(
            76,
            8,
            Graphics.FONT_XTINY,
            suffix,
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // ELAPSED ACTIVITY TIME
        // =================================

        dc.drawText(
            112,
            69,
            Graphics.FONT_LARGE,
            elapsedString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // FIRST HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            7,
            59,
            145,
            59
        );


        // =================================
        // DISTANCE
        // =================================

        dc.drawText(
            38,
            69,
            Graphics.FONT_LARGE,
            distanceString,
            Graphics.TEXT_JUSTIFY_CENTER
        );


        // =================================
        // CURRENT ELEVATION
        // =================================

        dc.drawText(
            70,
            31,
            Graphics.FONT_MEDIUM,
            elevationString,
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            76,
            34,
            Graphics.FONT_XTINY,
            "ft",
            Graphics.TEXT_JUSTIFY_LEFT
        );


        // =================================
        // VERTICAL DIVIDER
        // =================================

        dc.drawLine(
            73,
            64,
            73,
            103
        );


        // =================================
        // SECOND HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            7,
            106,
            145,
            106
        );


        // =================================
        // ELEVATION GAIN
        // =================================

        dc.drawText(
            60,
            108,
            Graphics.FONT_XTINY,
            "UP",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            137,
            106,
            Graphics.FONT_SMALL,
            ascentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );


        // =================================
        // THIRD HORIZONTAL DIVIDER
        // =================================

        dc.drawLine(
            7,
            130,
            145,
            130
        );


        // =================================
        // ELEVATION LOSS
        // =================================

        dc.drawText(
            60,
            132,
            Graphics.FONT_XTINY,
            "DOWN",
            Graphics.TEXT_JUSTIFY_RIGHT
        );

        dc.drawText(
            137,
            130,
            Graphics.FONT_SMALL,
            descentString + " ft",
            Graphics.TEXT_JUSTIFY_RIGHT
        );
    }
}
}