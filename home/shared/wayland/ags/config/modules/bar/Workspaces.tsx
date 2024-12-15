import Hyprland from "gi://AstalHyprland";
import { bind } from "astal";

// TODO: Groups
// App icon on workspace if only window

function WorkspacesModule() {
    const hypr = Hyprland.get_default();
    return (
        <box className="Workspaces">
            {bind(hypr, "workspaces").as((wss) =>
                wss
                    .sort((a, b) => a.id - b.id)
                    .map((ws) => (
                        <button
                            className={bind(hypr, "focusedWorkspace").as(
                                (fw) => (ws === fw ? "focused" : ""),
                            )}
                            onClicked={() => ws.focus()}
                        >
                            {ws.id}
                        </button>
                    )),
            )}
        </box>
    );
}

export default WorkspacesModule;
