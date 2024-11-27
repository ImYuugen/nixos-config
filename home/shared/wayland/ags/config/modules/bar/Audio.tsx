import Wp from "gi://AstalWp";
import { bind } from "astal";
import Gdk from "gi://Gdk";

function AudioModule() {
    const audio = Wp.get_default()?.audio!!;

    const volume = bind(audio.default_speaker, "volume");
    const muted = bind(audio.default_speaker, "mute");
    return (
        <button
            onClick={() => audio.default_speaker.set_mute(!muted.get())}
            onScroll={(_, event) => {
                audio.default_speaker.set_volume(
                    volume.get() + -event.delta_y * 0.1,
                );
            }}
        >
            <box>
                <label
                    label={volume.as((v) =>
                        (v * 100).toLocaleString(undefined, {
                            maximumFractionDigits: 0,
                        }),
                    )}
                />
                <label label={muted.as((m) => (m ? "Ø" : "O"))} />
            </box>
        </button>
    );
}

export default AudioModule;
