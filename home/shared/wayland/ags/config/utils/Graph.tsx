import { Binding } from "astal";
import { Gtk } from "astal/gtk3";
import Cairo from "cairo";

type Props = {
    samples?: number;
    className?: string;
    value: Binding<number>;
    maxValue?: number;
    minValue?: number;
    fill?: GraphFill;
};

enum GraphFill {
    NONE,
    FULL,
    HATCHED,
}

const DEFAULT_MAX_VALUE = 100;
const DEFAULT_MIN_VALUE = 0;
const clamp = (num: number, min: number, max: number) =>
    Math.max(Math.min(num, max), min);

const drawCurve = (
    cr: Cairo.Context,
    data: Array<number>,
    ctx: Gtk.StyleContext,
    props: Props,
) => {
    const width = ctx.get_property("min-width", ctx.get_state()) as number;
    const color = ctx.get_border_color(ctx.get_state());
    const lineWidth = ctx.get_border(ctx.get_state()).top;
    cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
    // Divide original width by scale reduction factor => width / 1.0
    cr.setLineWidth(lineWidth / width);
    let x = 0.0,
        y = 0.0;
    for (let i = 0; i < data.length; i++) {
        y = 1.0 - data[i] / props.maxValue!;
        x = i / (data.length - 1);
        cr.lineTo(x, y);
    }
    cr.stroke();
};

const fillUnderCurve = (
    cr: Cairo.Context,
    data: Array<number>,
    ctx: Gtk.StyleContext,
    props: Props,
) => {
    const color = ctx.get_color(ctx.get_state());
    cr.setSourceRGBA(color.red, color.green, color.blue, color.alpha);
    let x = 0.0,
        y = 0.0;
    for (let i = 0; i < data.length; i++) {
        y = 1.0 - data[i] / props.maxValue!;
        x = i / (data.length - 1);
        cr.lineTo(x, y);
    }
    // Make sure it goes *under* the curve
    cr.lineTo(x, 1.0);
    cr.lineTo(0.0, 1.0);
    cr.fill();
};

// Binds to a value, drawing a point for each past value
// - `value`: the binding
// - `{max,min}Value`: how {high,low} it can go
// - `sample`: the number of points on the graph
// CSS values:
// - `min-{width,height}`: the {width,height}. duh
// - `color`: color of the under-the-curve area
// - `border-color`: color of the curve
// - `border-width`: width of the curve
// - `background-color`: you'll NEVER guess
function Graph(props: Props) {
    const DATA_BUF_LIMIT = props.samples ?? 10;
    return (
        <drawingarea
            className={props.className}
            setup={(self) => {
                let data = new Array(DATA_BUF_LIMIT).fill(DEFAULT_MIN_VALUE);
                props.maxValue = props.maxValue ?? DEFAULT_MAX_VALUE;

                // FIX: If the value is updated, but is the same as
                // before, this won't be called, for now use delta
                self.hook(props.value, () => {
                    let val = props.value.get();
                    if (Number.isNaN(val)) {
                        val = data[data.length - 1];
                    }
                    data.push(
                        clamp(
                            Math.round(val),
                            props.minValue ?? DEFAULT_MIN_VALUE,
                            props.maxValue ?? DEFAULT_MAX_VALUE,
                        ),
                    );
                    data.shift();
                    self.queue_draw();
                });
                self.connect("draw", (_, cr: Cairo.Context) => {
                    const ctx = self.get_style_context();
                    const width = ctx.get_property(
                        "min-width",
                        ctx.get_state(),
                    ) as number;
                    const height = ctx.get_property(
                        "min-height",
                        ctx.get_state(),
                    ) as number;
                    self.set_size_request(width, height);

                    // Set scale so that 1, 1 is bottom right and 0,0 is top left
                    cr.scale(width, height);

                    if (props.fill == GraphFill.FULL) {
                        fillUnderCurve(cr, data, ctx, props);
                    } else if (props.fill == GraphFill.HATCHED) {
                        // TODO:
                    }
                    drawCurve(cr, data, ctx, props);
                });
            }}
        />
    );
}

export { Graph, GraphFill };
