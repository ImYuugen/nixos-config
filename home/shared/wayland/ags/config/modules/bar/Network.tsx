import { bind } from "astal";
import AstalNetwork from "gi://AstalNetwork";

// INFO: Grosse feuille pour detailler structure network
// network.client: on s'en tape, infos sur l'instance nm
// network "primary": sert juste a dire si cable ou pas
// network "state": etat de la connection, pas utile
// network "connectivity": j'en sais rien frr

// INFO:
// network.wired:
//  - device: NMDeviceEthernet
//    -
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

    return <box></box>;
}

export default NetworkModule;
