import { Astal, Gtk, Gdk } from "astal/gtk3";
import AudioModule from "./Audio";
import BatteryModule from "./Battery";
import DatetimeModule from "./Datetime";
import SystemModule from "./System";
import WorkspacesModule from "./Workspaces";
import NetworkModule from "./Network";

function BarLeft() {
    return (
        <box className="bar-left" hexpand halign={Gtk.Align.START}>
            <WorkspacesModule />
        </box>
    );
}

function BarCenter() {
    return (
        <box className="bar-center">
            <NetworkModule />
            <DatetimeModule />
            <SystemModule />
        </box>
    );
}

function BarRight() {
    return (
        <box className="bar-right" hexpand halign={Gtk.Align.END}>
            <AudioModule />
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
