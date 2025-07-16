{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.desktop.fcitx5;
in
{
  options.modules.desktop.fcitx5 = {
    enable = lib.mkEnableOption "Mine very own Fcitx5 config";
    autoLaunch = lib.mkEnableOption "Auto launch on supported stuff";
  };

  config = lib.mkIf cfg.enable {
    home.sessionVariables.QT_IM_MODULE = lib.mkDefault "fcitx";
    i18n.inputMethod = {
      enable = lib.mkDefault true;
      type = lib.mkDefault "fcitx5";
      fcitx5 = {
        addons = with pkgs; [
          fcitx5-mozc
          fcitx5-gtk
          catppuccin-fcitx5
        ];
        settings = {
          addons = {
            classicui.globalSection = {
              "Vertical Candidate List" = false;
              WheelForPaging = true;
              # TODO: Change once theming is done
              Font = "Sans 10";
              MenoFont = "Sans 10";
              TrayFont = "Sans Bold 10";
              TrayOutlineColor = "#000000";
              TrayTextColor = "#ffffff";
              PreferTextIcon = false;
              ShowLayoutNameInIcon = true;
              UseInputMethodLanguageToDisplayText = true;
              Theme = "catppuccin-latte-teal";
              DarkTheme = "catppuccin-macchiato-teal";
              # Misleading, this enables following system light/dark accent
              UseDarkTheme = true;
              UseAccentColor = true;
              PerScreenDPI = false;
              ForceWaylandDPI = 0;
              EnableFractionalScale = true;
            };
            clipboard = {
              globalSection = {
                "NumberOfEntries" = 5;
                IgnorePasswordFromPasswordManager = false;
                ShowPassword = false;
                ClearPasswordAfter = 30;
              };
              sections.TriggerKey."0" = "Control+colon";
            };
            keyboard = {
              globalSection = {
                PageSize = 5;
                EnableEmoji = true;
                EnableQuickPhraseEmoji = true;
                "Choose Modifier" = "Control";
                EnableHintByDefault = false;
                UseNewComposeBehavior = false;
                EnableLongPress = false;
              };
              sections = {
                PrevCandidate."0" = "Shift+Tab";
                NextCandidate."0" = "Tab";
              };
            };
            mozc.globalSection = {
              InitialMode = "Hiragana";
              InputState = "Follow Global Configuration";
              Vertical = true;
              ExpandMode = "On Focus";
              PreeditCursorPositionAtBeginning = false;
            };
            quickphrase = {
              globalSection = {
                "Choose Modifier" = "None";
                Spell = true;
                FallbackSpellLanguage = "en";
              };
              # grave == `
              sections.TriggerKey."0" = "Super+grave";
            };
            unicode.sections.TriggerKey."0" = "Control+Alt+Shift+U";
            # Plus long aussi fdp
            wayland.globalSection."Allow Overriding System XKB Settings" = false;
            waylandim.globalSection = {
              DetectApplication = true;
              PreferKeyEvent = true;
            };
            xcb.globalSection = {
              "Allow Overriding System XKB Settings" = true;
              AlwaysSetToGroupLayout = true;
            };
            xim.globalSection.UseOnTheSpot = true;
          };
          globalOptions = {
            Behavior = {
              ActiveByDefault = false;
              resetStateWhenInFocus = false;
              ShareInputState = false;
              PreeditEnabledByDefault = true;
              ShowInputMethodInformation = true;
              showInputMethodInformationWhenFocusIn = false;
              CompactInputMethodInformation = true;
              ShowFirstInputMethodInformation = true;
              DefaultPageSize = 5;
              OverrideXkbOption = false;
              CustomXkbOption = "";
              EnabledAddons = "";
              DisabledAddons = "";
              PreloadInputMethod = true;
              AllowInputMethodForPassword = false;
              ShowPreeditForPassword = false;
              AutoSavePeriod = 30;
            };
            Hotkey = {
              EnumerateWithTriggerKeys = true;
              AltTriggerKeys = "";
              EnumerateForwardKeys = "";
              EnumerateBackwardKeys = "";
              EnumerateSkipFirst = false;
            };
            "Hotkey/TriggerKeys"."0" = "Control+space";
            "Hotkey/PrevPage"."0" = "Up";
            "Hotkey/NextPage"."0" = "Down";
            "Hotkey/PrevCandidate"."0" = "Shift+Tab";
            "Hotkey/NextCandidate"."0" = "Tab";
            # No one wants to press ts
            "Hotkey/TogglePreedit"."0" = "";
          };
          inputMethod = {
            GroupOrder = {
              "0" = "Default";
            };
            "Groups/0" = {
              Name = "Default";
              "Default Layout" = "us-altgr-intl";
              DefaultIM = "mozc";
            };
            "Groups/0/Items/0" = {
              Name = "keyboard-us-altgr-intl";
            };
            "Groups/0/Items/1" = {
              Name = "mozc";
            };
          };
        };
        waylandFrontend = true;
      };
    };

    wayland.windowManager = lib.mkIf cfg.autoLaunch {
      hyprland.settings.exec-once = lib.mkAfter [
        "fcitx5 -d --replace &"
      ];
    };
  };
}
