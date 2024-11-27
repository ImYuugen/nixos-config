import { bind, Variable } from "astal";

// TODO: Right click on CPU -> All cores + Power profiles
// Put CPU temperature somewhere
// Hover on CPU -> Clock
// Right click on Disk -> All mounted disks

// Get CPU usage every 4 seconds
const cpuUsage = Variable(0).watch(
    ["vmstat", "4"],
    (out) => 100 - parseInt(out.split("\n").pop()?.split(/ +/)[14]!!),
);

const ramUsage = Variable(0).poll(2000, "free", (out) => {
    const line = out
        .split("\n")
        .find((line) => line.includes("Mem"))
        ?.split(/ +/) ?? ["0", "1", "0"];
    // 100 * free / total
    return (100 * parseInt(line[2])) / parseInt(line[1]);
});

// Don't need faster than 20 seconds
const diskRootUsage = Variable("").poll(20000, "df", (out) => {
    // Line that ends in '/' <=> Root disk
    const line =
        out
            .split("\n")
            .find((l) => /\/$/.test(l))
            ?.split(/ +/) ?? [];
    return line[4] ?? "0%";
});

function System() {
    return (
        <box>
            {bind(cpuUsage)} |{" "}
            {bind(ramUsage).as((u) =>
                u.toLocaleString(undefined, { maximumFractionDigits: 2 }),
            )}{" "}
            | {bind(diskRootUsage)}
        </box>
    );
}

export default System;
