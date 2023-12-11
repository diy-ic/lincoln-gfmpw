# Lincoln GFMPW-1

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![UPRJ_CI](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/user_project_ci.yml) [![Caravel Build](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml/badge.svg)](https://github.com/efabless/caravel_project_example/actions/workflows/caravel_build.yml)


This repo contains a collection of projects & the internconnects required for them to function on the GFMPW-1 silicon.

## Projects

### Titan
Titan is a WIP compiler that is designed to take regular Python code and convert it into SystemVerilog, which should be solid enough to realise it on either FPGAs or ASICs. The submission of a Titan core into the repo is an attempt to validate whether or not this will be possible. More details are available [here](https://titan-compiler-project.github.io/titan/), and a paper is available [here](https://eprints.lincoln.ac.uk/id/eprint/56659/).

This is a part of my Masters by Research in Computer Science degree at the University of Lincoln, UK.

### Manchester Baby
Logisim implementation of the Manchester Baby, slightly modified to fit into the limitations of the harness. Available [here](https://gitlab.com/charles.fox/comparch/-/tree/main).

### MOS 6502 Decoder
Work-in-progress Logisim implementation of the MOS 6502, however this only uses the decoder section. Available [here](https://github.com/LAMB-TARK/MOS-6502-Logisim-Evolution).
