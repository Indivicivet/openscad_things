import numpy as np
from stl import mesh


def cube_coords(divs):
    return [
        (i, j, k)
        for i in range(divs + 1)
        for j in range(divs + 1)
        for k in range(divs + 1)
        if (
            i in [0, divs]
            or j in [0, divs]
            or k in [0, divs]
        )
    ]


def cube_tris(divs):
    def rev(positions, extra_coord):
        if extra_coord:
            return list(reversed(positions))
        return positions

    return (
        []
        # front+back UL
        + [
            rev([(i, j, k), (i + 1, j, k), (i, j + 1, k)], k)
            for i in range(divs)
            for j in range(divs)
            for k in [0, divs]
        ]
        # front+back LR
        + [
            rev([(i, j + 1, k), (i + 1, j, k), (i + 1, j + 1, k)], k)
            for i in range(divs)
            for j in range(divs)
            for k in [0, divs]
        ]
        # top+bottom UL
        + [
            rev([(i, j, k), (i + 1, j, k), (i, j, k + 1)], j)
            for i in range(divs)
            for j in [0, divs]
            for k in range(divs)
        ]
        # top+bottom LR
        + [
            rev([(i, j, k + 1), (i + 1, j, k), (i + 1, j, k + 1,)], j)
            for i in range(divs)
            for j in [0, divs]
            for k in range(divs)
        ]
        # left+right UL
        + [
            rev([(i, j, k), (i, j, k + 1), (i, j + 1, k)], i)
            for i in [0, divs]
            for j in range(divs)
            for k in range(divs)
        ]
        # left+right LR
        + [
            rev([(i, j, k + 1), (i, j + 1, k), (i, j + 1, k + 1,)], i)
            for i in [0, divs]
            for j in range(divs)
            for k in range(divs)
        ]
    )


def initial_positions(coords, scaling):
    return {ijk: np.array(ijk) * scaling for ijk in coords}


def get_mesh(tris, positions):
    data = np.zeros(len(tris), dtype=mesh.Mesh.dtype)
    for n, tri in enumerate(tris):
        data["vectors"][n] = np.vstack([positions[coord] for coord in tri])
    return mesh.Mesh(data)


if __name__ == "__main__":
    DIVS = 50
    SIZE = 20
    coords = cube_coords(DIVS)
    tris = cube_tris(DIVS)
    positions = initial_positions(coords, SIZE / DIVS)
    cube = get_mesh(tris, positions)
    cube.save(f"cube_{DIVS=}_{SIZE=}_0.stl")
