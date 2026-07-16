# estudiEO Flutter Optimization Rules

Always implement the following guidelines when writing or modifying UI components and graphics code to ensure optimal performance on mobile and Flutter Web (CanvasKit/HTML):

## 1. Repaint Boundary Isolation
- **Always** wrap heavy, continuous animation layers (such as particles, particle canvases, floating orbs, or custom loops) in a `RepaintBoundary` widget.
- **Always** wrap complex static UI components (like text overlays, navigation bars, bento grids, and details) in a `RepaintBoundary` to prevent them from repainting when nearby animated widgets redraw.
- For widgets that feature micro-animations (e.g., repeating shimmering overlays inside cards like `BentoCard`), wrap the animating element itself in a `RepaintBoundary` to isolate the rest of the card from rebuild invalidation.

## 2. Distance and Math Loop Optimizations
- When calculating distances between multiple elements in loops (like particle networks, physics engines, or touch tracking), **never** calculate square roots (`math.sqrt`) by default.
- Use **squared distance comparisons** first (e.g., `dx * dx + dy * dy < threshold * threshold`). Only compute the actual square root if the elements are within the interactive boundary.

## 3. Layout Centering and Responsiveness
- For screens that need to be centered vertically and horizontally on mobile but responsive on desktop, use `LayoutBuilder` combined with `ConstrainedBox(constraints: BoxConstraints(minHeight: constraints.maxHeight))` to cleanly center the elements dynamically without breaking scrolling on smaller viewports.

## 4. UI Design & Glassmorphism Aesthetics
- **Premium Glassmorphism**: Use highly translucent, dark surface colors (e.g. `NeuralDesignSystem.surfaceCard` with low alpha like 0.3-0.5) to achieve a clean glass effect.
- **Subtle Gradients & Glows**: Avoid heavy, saturated background tints or massive, opaque inner glows. Radial gradients (glows) behind icons or borders should be very subtle and diffuse.
- **Borders**: Use very thin, semi-transparent white/colored borders (`width: 1.0` or `1.5`) to give the glass edge a crisp, frosted appearance without looking cartoonish.
- **Compact Layouts**: Prefer compact, proportionally constrained cards (e.g. `childAspectRatio: 1.05 - 1.15`) that center vertically within the viewport (`GridView(shrinkWrap: true)` inside a `Center`) rather than stretching components vertically to fill empty space.
