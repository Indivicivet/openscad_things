---
name: render-openscad-previews
description: Render 2D image previews of OpenSCAD (.scad) designs using the headless openscad.com CLI, for visual verification or GitHub README galleries.
---

# OpenSCAD Preview Renderer

Use this skill when you need to generate preview PNG images of `.scad` models in the repository (e.g., to verify geometry changes or update the gallery in `README.md`).

## OpenSCAD Executable on Windows

On Windows, `openscad.exe` runs asynchronously as a GUI application and does not write output or wait cleanly in CLI mode. Always invoke the CLI console wrapper:

```powershell
"C:\Program Files\OpenSCAD\openscad.com"
```

## Standard Rendering Workflows

### 1. Default Isometric Preview (Auto-Centered & Auto-Fitted)
Best for general model overviews:
```powershell
& "C:\Program Files\OpenSCAD\openscad.com" -o "assets/previews/<name>.png" --preview --imgsize=600,600 --viewall --autocenter "<path_to_model>.scad"
```

### 2. Custom Camera Angle (Rotated / Alternate View)
When a model needs a side, top, or angled view:
```powershell
& "C:\Program Files\OpenSCAD\openscad.com" -o "assets/previews/<name>_alt.png" --preview --camera=0,0,0,65,0,315,200 --imgsize=600,600 "<path_to_model>.scad"
```

Camera parameter breakdown:
- `--camera=translate_x,translate_y,translate_z,rot_x,rot_y,rot_z,distance`

### 3. Orthogonal / Top-Down View
Useful for flat designs, puzzles, or grids:
```powershell
& "C:\Program Files\OpenSCAD\openscad.com" -o "assets/previews/<name>_top.png" --preview --projection=o --camera=0,0,0,0,0,0,150 --imgsize=600,600 "<path_to_model>.scad"
```

## Rules & Gotchas

1. **Preview Mode**: Always include `--preview`. This invokes the CSG/OpenCSG fast preview pipeline (~0.1-0.5s per model) rather than a full CGAL polyhedral render (which can take minutes on complex geometry).
2. **Infinite Bounds**: Models with dummy infinite cubes (e.g., `cube(999)` used in differences) will skew `--viewall --autocenter` so the actual part becomes tiny. For such models, supply explicit `--camera` center coordinates and distance.
3. **Paths**: Write preview PNGs into `assets/previews/` and reference them with relative paths (e.g., `assets/previews/<name>.png`) in `README.md`.
