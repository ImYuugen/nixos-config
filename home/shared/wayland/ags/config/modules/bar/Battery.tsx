import { bind, Variable } from "astal";
import Battery from "gi://AstalBattery";

function BatteryModule() {
    const LOW_BATTERY = 0.20;

    const bat = Battery.get_default();

    const perchance = Variable.derive([
        bind(bat, "percentage"),
        bind(bat, "charging"),
    ]);
    return (
        <box
            className="battery-module"
            visible={bind(bat, "is_present")}
            setup={(self) => {
                self.toggleClassName(
                    "critical",
                    perchance.get()[0] < LOW_BATTERY && !perchance.get()[1],
                );
                self.hook(perchance, (self) =>
                    self.toggleClassName(
                        "critical",
                        perchance.get()[0] < LOW_BATTERY && !perchance.get()[1],
                    ),
                );
            }}
        >
            <box className="icon-block">
                <overlay>
                    <label className="big-text battery-icon" label="󰂎" />
                    <label
                        className="charging-icon"
                        label="󱐋"
                        visible={perchance((p) => p[1])}
                    />
                </overlay>
            </box>
            <label
                className="percentage"
                label={perchance((p) => `${Math.floor(p[0] * 100)}%`)}
            />
        </box>
    );
}

export default BatteryModule;
