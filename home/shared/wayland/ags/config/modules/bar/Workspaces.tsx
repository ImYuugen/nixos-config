import AstalHyprland from "gi://AstalHyprland?version=0.1";
import { bind } from "astal";

function WorkspacesModule() {
    const hypr = AstalHyprland.get_default();

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
