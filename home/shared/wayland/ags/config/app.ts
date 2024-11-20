import { App } from "astal/gtk3";
import Bar from "./modules/bar/Bar";
import { exec } from "astal/process";

exec(["sass", "./style/style.scss", "/tmp/ags-style.css"]);

App.start({
    css: "/tmp/ags-style.css",
    main() {
        App.get_monitors().map(Bar);
    },
});
