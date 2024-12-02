import { bind } from "astal";
import Battery from "gi://AstalBattery";
import { DrawingArea } from "astal/gtk3/widget";

function BatteryModule() {
    const bat = Battery.get_default();

    const percentage = bind(bat, "percentage");
    const charging = bind(bat, "charging");
    return (
        <box className="battery-module" visible={bind(bat, "is_present")}>
            <box className="icon-block">
                <overlay>
                    <label className="big-text battery-icon" label="󰂎" />
                    <label
                        className="charging-icon"
                        label="󱐋"
                        visible={charging.get()}
                    />
                </overlay>
            </box>
            <label
                className="percentage"
                label={percentage.as((p) => `${Math.floor(p * 100)}%`)}
            />
        </box>
    );
}

export default BatteryModule;
