# Picard Iteration in Haskell

Approximate solutions of ordinary differential equations, written in Haskell for an honors differential equations course.

Picard iteration builds a solution by repeated integration:

$$x_{j+1}(t) = x_0 + \int_{t_0}^{t} v(x_j(s), s)\, ds$$

Each integral is a Riemann sum. Evaluating the previous iterate inside every sum costs on the order of $N^j$ work, so each iterate is stored on a uniform grid and read back with linear interpolation. The grid interval for a given time is found with binary search.

The example is $x'(t) = x \cos t$ with $x(0) = 1$, which has the exact solution $e^{\sin t}$. `demo.hs` prints the 10th approximate iterate on $[0, 2\pi]$.

## Run

Requires [GHC](https://www.haskell.org/ghc/).

```bash
ghc demo.hs -o picard && ./picard
```

The other `.hs` files are the pieces: Riemann integration, one Picard step, interval search, and interpolation.
