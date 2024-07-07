"use strict";

import App from 'resource:///com/github/Aylur/ags/app.js';
import { Bar } from './modules/bar/bar.js';

const scss = `${App.configDir}/scss/main.scss`;
const css = `/tmp/ags-style.css`;
Utils.exec(`sass ${scss} ${css}`);

App.config({
    style: css,
    windows: [
        Bar(0),
    ],
});
