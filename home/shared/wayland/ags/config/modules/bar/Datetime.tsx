import { Variable, GLib } from "astal";

// TODO: Seconds toggle
// Calendar

function DatetimeModule() {
    const time = Variable(GLib.DateTime.new_now_local()).poll(1000, () =>
        GLib.DateTime.new_now_local(),
    );
    const dayKanji = ["", "月", "火", "水", "木", "金", "土", "日"];

    return (
        <box className="datetime-module">
            <label
                className="day-kanji"
                label={time((t) => dayKanji[+(t.format("%u") ?? 0)])}
            />
            <box vertical>
                <label
                    className="time"
                    label={time((t) => t.format("%R") ?? "00:00")}
                />
                <label
                    className="date small-text"
                    label={time((t) => t.format("%d/%m") ?? "00/00")}
                />
            </box>
        </box>
    );
}

export default DatetimeModule;
