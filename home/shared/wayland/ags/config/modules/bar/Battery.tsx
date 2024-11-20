import { bind } from "astal";
import Battery from "gi://AstalBattery";

function BatteryModule() {
    const bat = Battery.get_default();

    return (
        <box className="bar-battery" visible={bind(bat, "isPresent")}>
            <label
                label={bind(bat, "percentage").as(
                    (p) => `${Math.floor(p * 100)}%`,
                )}
            />
        </box>
    );
}

export default BatteryModule;
