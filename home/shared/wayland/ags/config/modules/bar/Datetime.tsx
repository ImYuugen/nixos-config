import { Variable, GLib } from "astal";

// TODO: Seconds toggle
// Calendar

function DatetimeModule({ format = "%H:%M - %A %e" }) {
    const time = Variable<string>("").poll(
        1000,
        () => GLib.DateTime.new_now_local().format(format)!,
    );

    return (
        <label className="bar-datetime" onDestroy={() => time.drop()} label={time()} />
    );
}

export default DatetimeModule;