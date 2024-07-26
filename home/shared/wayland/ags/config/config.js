"use strict";

import App from 'resource:///com/github/Aylur/ags/app.js';
import { Bar, BarCornerTopLeft, BarCornerTopRight } from './modules/bar/bar.ts';

const scss = `${App.configDir}/scss/main.scss`;
const css = `/tmp/ags-style.css`;
Utils.exec(`sass ${scss} ${css}`);

// TODO: For each monitor util function

const BarWithRounding = (monitor = 0) => [
    Bar(monitor),
    BarCornerTopLeft(monitor),
    BarCornerTopRight(monitor),
];

App.config({
    style: css,
    windows: [
        BarWithRounding(1),
    ],
});
