import { Astal, Gtk, Gdk } from "astal/gtk3";
import AudioModule from "./Audio";
import BatteryModule from "./Battery";
import DatetimeModule from "./Datetime";
import WorkspacesModule from "./Workspaces";

function BarLeft(): JSX.Element {
    return (
        <box className="bar-left" hexpand halign={Gtk.Align.START}>
            <WorkspacesModule />
        </box>
    );
}

function BarCenter(): JSX.Element {
    return (
        <box className="bar-center">
            <DatetimeModule />
        </box>
    );
}

function BarRight(): JSX.Element {
    return (
        <box className="bar-right" hexpand halign={Gtk.Align.END}>
            <BatteryModule />
        </box>
    );
}

function Bar(monitor: Gdk.Monitor) {
    const anchor =
        Astal.WindowAnchor.TOP |
        Astal.WindowAnchor.LEFT |
        Astal.WindowAnchor.RIGHT;

    return (
        <window
            className="Bar"
            gdkmonitor={monitor}
            exclusivity={Astal.Exclusivity.EXCLUSIVE}
            anchor={anchor}
        >
            <centerbox className="bar-centerbox">
                <BarLeft />
                <BarCenter />
                <BarRight />
            </centerbox>
        </window>
    );
}

export default Bar;
