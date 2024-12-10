function humanReadable(bytes: number, unit: string, si = false, dp = 1): string {
    const div = si ? 1000 : 1024;
    if (Math.abs(bytes) < div) {
        return bytes.toFixed(dp) + "B" + unit;
    }
    const units = si ? ["k", "M", "G", "T"] : ["ki", "Mi", "Gi", "Ti"];
    let u = -1;
    const r = 10 ** dp;

    while (Math.round(Math.abs(bytes) * r) / r >= div && u < units.length) {
        bytes /= div;
        u++;
    }

    return bytes.toFixed(dp) + units[u] + unit;
}

export { humanReadable };
