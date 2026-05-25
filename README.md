# Sentrux Docker Image

This repository contains a `Dockerfile` to build a Docker image for the `sentrux` project using the upstream official install script.

## Build

```bash
docker build -t sentrux .
```

## Run

To run `sentrux` against a local repository on your machine, mount the repo into the container and pass the target path:

```bash
docker run --rm -it -v /path/to/repo:/repo sentrux check /repo
```

Example for a repository in your home folder:

```bash
cd my-project
docker run --rm -it -v "$(pwd)":/repo sentrux check /repo
```

> Note: `sentrux scan` opens the GUI. In a container, you must forward your host display to the container.

For X11 hosts:

```bash
cd my-project
docker run --rm -it \
  --env DISPLAY="$DISPLAY" \
  --env XAUTHORITY="$XAUTHORITY" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$(pwd)":/repo \
  sentrux scan /repo
```

## Notes

- The image downloads the official Sentrux release binary via `curl -fsSL https://raw.githubusercontent.com/sentrux/sentrux/main/install.sh | sh`.
- Language grammars are preloaded during image build so the container does not need a first-run grammar download.
- The runtime stage installs the GTK libraries required by the official binary so `sentrux --help` and GUI/CLI usage work correctly.
- Use `sentrux --help` for additional command options.
