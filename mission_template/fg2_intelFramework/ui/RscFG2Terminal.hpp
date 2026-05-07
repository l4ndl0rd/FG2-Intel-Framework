class RscTitles {};

class RscText
{
    access = 0;
    type = 0;
    idc = -1;
    style = 0;
    linespacing = 1;

    x = 0;
    y = 0;
    w = 0.1;
    h = 0.1;

    colorBackground[] = {0,0,0,0};
    colorText[] = {1,1,1,1};

    text = "";
    shadow = 2;
    font = "RobotoCondensed";
    sizeEx = 0.035;
};

class RscStructuredText
{
    access = 0;
    type = 13;
    idc = -1;
    style = 0;

    x = 0;
    y = 0;
    w = 0.1;
    h = 0.1;

    colorBackground[] = {0,0,0,0};
    size = 0.035;
    text = "";

    class Attributes
    {
        font = "RobotoCondensed";
        color = "#FFFFFF";
        align = "left";
        shadow = 1;
    };
};

class RscPicture
{
    access = 0;
    type = 0;
    idc = -1;
    style = 48;

    x = 0;
    y = 0;
    w = 0.1;
    h = 0.1;

    text = "";
    colorText[] = {1,1,1,1};
    colorBackground[] = {0,0,0,0};

    font = "RobotoCondensed";
    sizeEx = 0;
    lineSpacing = 0;
};

class RscButton
{
    access = 0;
    type = 1;
    idc = -1;
    style = 2;

    text = "";
    font = "RobotoCondensed";
    sizeEx = 0.035;
    shadow = 2;

    x = 0;
    y = 0;
    w = 0.1;
    h = 0.04;

    colorText[] = {1,1,1,1};
    colorDisabled[] = {0.4,0.4,0.4,1};

    colorBackground[] = {0.18,0.18,0.18,1};
    colorBackgroundDisabled[] = {0.08,0.08,0.08,0.7};
    colorBackgroundActive[] = {0.8,0.41,0,1};
    colorFocused[] = {0.28,0.28,0.28,1};

    colorShadow[] = {0,0,0,0.7};

    offsetX = 0.003;
    offsetY = 0.003;
    offsetPressedX = 0.002;
    offsetPressedY = 0.002;

    colorBorder[] = {0,0,0,0};
    borderSize = 0;

    soundEnter[] = {"",0.09,1};
    soundPush[] = {"",0.09,1};
    soundClick[] = {"",0.09,1};
    soundEscape[] = {"",0.09,1};

    action = "";
};

///----- SCREEN LAYOUT DEFINITIONS -----///
#define TABLET_W (safeZoneW * 0.62)
#define TABLET_H (TABLET_W / 1.15)
#define TABLET_X (safeZoneX + ((safeZoneW - TABLET_W) / 2))
#define TABLET_Y (safeZoneY + ((safeZoneH - TABLET_H) / 2))

#define SCREEN_X (TABLET_X + (TABLET_W * 0.275))
#define SCREEN_Y (TABLET_Y + (TABLET_H * 0.245))
#define SCREEN_W (TABLET_W * 0.45)
#define SCREEN_H (TABLET_H * 0.48)

#define PAD_X (TABLET_W * 0.025)
#define PAD_Y (TABLET_H * 0.025)

#define CONTENT_X (SCREEN_X + (SCREEN_W * 0.06))
#define CONTENT_W (SCREEN_W * 0.88)

#define LEFT_COL_X CONTENT_X
#define RIGHT_COL_X (CONTENT_X + (CONTENT_W * 0.52))
#define BUTTON_W (CONTENT_W * 0.46)

class RscFG2Terminal
{
    idd = 88021;
    movingEnable = 0;
    enableSimulation = 1;

    onLoad = "params ['_display']; uiNamespace setVariable ['fg2_terminalDisplay', _display];";
    onUnload = "uiNamespace setVariable ['fg2_terminalDisplay', displayNull]; uiNamespace setVariable ['fg2_activeDevice', objNull]; uiNamespace setVariable ['fg2_progressBarInitialized', false]; uiNamespace setVariable ['fg2_lastProgressValue', -1];";

    class controlsBackground
    {
        class TabletBackground: RscPicture
        {
            idc = -1;
            text = "fg2_intelFramework\ui\images\tablet_bg.paa";

            x = TABLET_X;
            y = TABLET_Y;
            w = TABLET_W;
            h = TABLET_H;

            colorText[] = {1,1,1,1};
        };

        class ScreenShadow_4: RscText
        {
            idc = -1;
            x = SCREEN_X + 0.020;
            y = SCREEN_Y + 0.020;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0,0,0,0.06};
        };

        class ScreenShadow_3: RscText
        {
            idc = -1;
            x = SCREEN_X + 0.014;
            y = SCREEN_Y + 0.014;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0,0,0,0.12};
        };

        class ScreenShadow_2: RscText
        {
            idc = -1;
            x = SCREEN_X + 0.009;
            y = SCREEN_Y + 0.009;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0,0,0,0.18};
        };

        class ScreenShadow_1: RscText
        {
            idc = -1;
            x = SCREEN_X + 0.004;
            y = SCREEN_Y + 0.004;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0,0,0,0.25};
        };

        class ScreenFrameBase: RscText
        {
            idc = -1;
            x = SCREEN_X;
            y = SCREEN_Y;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0.10,0.10,0.10,1};
        };

        class ScreenGlassOverlay: RscText
        {
            idc = -1;
            x = SCREEN_X;
            y = SCREEN_Y;
            w = SCREEN_W;
            h = SCREEN_H;
            colorBackground[] = {0.16,0.18,0.20,0.18};
        };

        class Header: RscText
        {
            idc = -1;
            text = "FG2 Intel Terminal";

            x = SCREEN_X;
            y = SCREEN_Y - 0.04;
            w = SCREEN_W;
            h = 0.04;

            colorBackground[] = {0.8,0.41,0,1};
            colorText[] = {1,1,1,1};
        };

        class HeaderAccent: RscText
        {
            idc = -1;
            x = SCREEN_X;
            y = SCREEN_Y - 0.004;
            w = SCREEN_W;
            h = 0.004;
            colorBackground[] = {0.8,0.41,0,1};
        };

        class ProgressBackground: RscText
        {
            idc = 1200;
            x = CONTENT_X;
            y = SCREEN_Y + (SCREEN_H * 0.60);
            w = CONTENT_W;
            h = SCREEN_H * 0.07;
            colorBackground[] = {0.02,0.02,0.02,1};
        };
    };

    class controls
    {
        class JobInfo: RscStructuredText
        {
            idc = 1001;
            x = CONTENT_X;
            y = SCREEN_Y + (SCREEN_H * 0.10);
            w = CONTENT_W;
            h = SCREEN_H * 0.36;
            text = "No active job";
        };

        class ProgressText: RscText
        {
            idc = 1002;
            x = CONTENT_X;
            y = SCREEN_Y + (SCREEN_H * 0.50);
            w = CONTENT_W;
            h = SCREEN_H * 0.08;
            text = "Progress: 0%";
        };

        class ProgressFill: RscText
        {
            idc = 1201;
            x = CONTENT_X;
            y = SCREEN_Y + (SCREEN_H * 0.60);
            w = 0;
            h = SCREEN_H * 0.07;
            colorBackground[] = {0.8,0.41,0,1};
        };

        class CancelButton: RscButton
        {
            idc = 1600;
            text = "Cancel";
            x = LEFT_COL_X;
            y = SCREEN_Y + (SCREEN_H * 0.76);
            w = BUTTON_W;
            h = SCREEN_H * 0.10;

            action = "private _device = uiNamespace getVariable ['fg2_activeDevice', objNull]; if (!isNull _device) then { ['fg2_request_cancelJob', [netId _device, getPlayerUID player]] call CBA_fnc_serverEvent; };";
        };

        class StartPauseResumeButton: RscButton
        {
            idc = 1601;
            text = "Start Job";
            x = RIGHT_COL_X;
            y = SCREEN_Y + (SCREEN_H * 0.76);
            w = BUTTON_W;
            h = SCREEN_H * 0.10;

            action = "private _device = uiNamespace getVariable ['fg2_activeDevice', objNull]; if (!isNull _device) then { private _activeJob = _device getVariable ['fg2_activeJob', []]; private _paused = _device getVariable ['fg2_jobPaused', false]; if (_activeJob isEqualTo []) then { ['fg2_request_startJob', [netId _device, getPlayerUID player]] call CBA_fnc_serverEvent; } else { if (_paused) then { ['fg2_request_resumeJob', [netId _device, getPlayerUID player]] call CBA_fnc_serverEvent; } else { ['fg2_request_pauseJob', [netId _device, getPlayerUID player]] call CBA_fnc_serverEvent; }; }; };";
        };

        class CancelButtonAccent: RscText
        {
            idc = -1;
            x = LEFT_COL_X;
            y = SCREEN_Y + (SCREEN_H * 0.76);
            w = 0.003;
            h = SCREEN_H * 0.10;
            colorBackground[] = {0.8,0.41,0,1};
        };

        class StartButtonAccent: RscText
        {
            idc = -1;
            x = RIGHT_COL_X;
            y = SCREEN_Y + (SCREEN_H * 0.76);
            w = 0.003;
            h = SCREEN_H * 0.10;
            colorBackground[] = {0.8,0.41,0,1};
        };

        class CloseX: RscButton
        {
            idc = 1602;
            style = 48;
            text = "\a3\3DEN\Data\Displays\Display3DEN\search_end_ca.paa";

            // exakt im Header zentriert
            x = SCREEN_X + SCREEN_W - 0.026;
            y = SCREEN_Y - 0.04;
            w = 0.022;
            h = 0.04;

            colorText[] = {1,1,1,0.9};
            colorTextFocused[] = {1,1,1,1};
            colorTextActive[] = {1,0.8,0.5,1};

            colorBackground[] = {0,0,0,0};
            colorBackgroundFocused[] = {1,1,1,0.12};
            colorBackgroundActive[] = {1,1,1,0.18};

            colorDisabled[] = {1,1,1,0.2};

            colorBorder[] = {0,0,0,0};
            colorShadow[] = {0,0,0,0};
            borderSize = 0;

            offsetX = 0;
            offsetY = 0;
            offsetPressedX = 0;
            offsetPressedY = 0;

            action = "closeDialog 0;";
        };
    };
};