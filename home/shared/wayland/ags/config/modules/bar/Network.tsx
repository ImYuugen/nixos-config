import { bind, Binding, Variable } from "astal";
import AstalNetwork from "gi://AstalNetwork";
import Gtk from "gi://Gtk?version=3.0";
import { humanReadable } from "../../utils/strings";

// INFO: Grosse feuille pour detailler structure network
// network.client: on s'en tape, infos sur l'instance nm
// network "primary": sert juste a dire si cable ou pas
// network "state": etat de la connection, pas utile
// network "connectivity": j'en sais rien frr

// INFO:
// network.wired:
//  - device: NMDeviceEthernet
//    - carrier: boolean
//    - perm_hw_address: string
//    - s390_subchannels: string (bro wtf is that)
//    - speed: number
//  - "speed": number
//  - "internet": AstalNetworkInternet
//  - "state": AstalNetworkDeviceState
//  - "icon_name": string

// INFO:
// network.wifi:
//  - device: NMDeviceWifi
//    - access_points: GPtrArray
//    - active_access_point: NMAccessPoint
//    - bitrate: number
//    - last-scan: number
//    - mode: NM80211Mode
//    - perm_hw_address: string
//    - wireless-capabilities: NMDeviceWifiCapabilities
//  - active_connection: NMActiveConnection
//    - connection: NMRemoteConnection
//    - controller: NMDevice
//    - "default": boolean
//    - "default6": boolean
//    - "devices": GPtrArray
//    - dhcp4-config: NMDhcpConfig
//    - dhcp6-config: NMDhcpConfig
//    - id: string
//    - ip4_config: NMIPConfig
//    - ip6_config: NMIPConfig
//    - master: NMDevice
//    - specific_object_path: string
//    - state: NMActiveConnectionState
//    - state_flags: number
//    - type: string
//    - uuid: string
//    - vpn: boolean
//  - active_access_point: AstalNetworkAccessPoint
//    - "bandwidth": number
//    - "bssid": string
//    - "frequency": number
//    - "last_seen": number
//    - "max_bitrate": number
//    - "strength": number
//    - "icon_name": string
//    - "mode": NM80211Mode (802.11 mode an access point is in)
//    - "flags": NM80211ApFlags (Access point flags)
//    - "rsn_flags": NM80211ApSecurityFlags (Sec. req. of access point)
//    - "wpa_flags": NM80211ApSecurityFlags (Sec. req. of access point)
//    - "ssid": string
//  - "access_points": [AstalNetworkAccessPoint*]
//  - "enabled": boolean
//  - "internet": AstalNetworkInternet
//  - "bandwidth": number
//  - "ssid": string
//  - "strength": number
//  - "frequency": number
//  - "state": AstalNetworkDeviceState
//  - "icon_name": string
//  - "is_hotspot": boolean
//  - "scanning": boolean

function NetworkModule() {
    const network = AstalNetwork.get_default();

    const netPrimary = bind(network, "primary");
    // [[rx total, rx last], [tx total, tx last]]
    const rxtx = Variable([
        [0, 0],
        [0, 0],
    ]).poll(4000, ["ifstat", "--interval=4", "-j"], (out, prev) => {
        const netif = netPrimary.get() == 1 ? "eno1" : "wlo1";
        const ifstat = JSON.parse(out).kernel;
        if (ifstat[netif] === undefined) {
            printerr(`${netif} not found in ifstat output`);
            return [
                [0, 0],
                [0, 0],
            ];
        }
        const rx_bytes = parseInt(ifstat[netif].rx_bytes),
            tx_bytes = parseInt(ifstat[netif].tx_bytes);
        return [
            [rx_bytes - prev[0][1], rx_bytes],
            [tx_bytes - prev[1][1], tx_bytes],
        ];
    });
    return (
        <box className="network-module">
            <revealer revealChild={netPrimary.as((p) => p != 0)}>
                <box vertical className="speeds">
                    <box className="rx">
                        v.
                        <label
                            label={rxtx(([[rx_cur, _rx_tot], _tx]) =>
                                humanReadable(rx_cur / 4, "B/s", false, 0),
                            )}
                        />
                    </box>
                    <box className="tx">
                        ^.
                        <label
                            label={rxtx(([_rx, [tx_cur, _tx_tot]]) =>
                                humanReadable(tx_cur / 4, "B/s", false, 0),
                            )}
                        />{" "}
                    </box>
                </box>
            </revealer>
            <box className="wired" visible={netPrimary.as((p) => p == 1)}>
                <label label="󰈀" />
            </box>
            <box className="wifi" visible={netPrimary.as((p) => p == 2)}>
                <label
                    className="icon-material"
                    label={bind(network.wifi, "strength").as(
                        (p) => "signal_wifi_4_bar",
                    )}
                />
            </box>
        </box>
    );
}

export default NetworkModule;
