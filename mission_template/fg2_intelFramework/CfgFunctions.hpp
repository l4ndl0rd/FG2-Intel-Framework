class CfgFunctions
{
    class fg2
    {
        tag = "fg2";

        class bootstrap
        {
            file = "fg2_intelFramework\bootstrap";
            class initFramework {};
            class initCompletionEffects {};
        };

        class core
        {
            file = "fg2_intelFramework\core";
            class autoRegisterDevices {};
            class registerDevice {};
            class addIntelJob {};
            class pushQueue {};
            class jobRouter {};
            class executeJob {};
            class pauseJob {};
            class resumeJob {};
            class cancelJob {};
        };

        class interaction
        {
            file = "fg2_intelFramework\interaction";
            class initDeviceActions {};
        };

        class ui
        {
            file = "fg2_intelFramework\ui";
            class openTerminal {};
            class updateTerminal {};
        };
        class util
        {
            file = "fg2_intelFramework\util";
            class log {};
        };
    };
};