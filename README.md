# Sentrux Docker Image

This repository contains a `Dockerfile` to build a Docker image for the [`sentrux` project](https://github.com/sentrux/sentrux) using the upstream official install script.

## Build

```bash
docker build -t sentrux .
```

## Run

### Check

To run `sentrux check` against a local repository on your machine, mount the repo into the container and pass the target path:

```bash
docker run --rm -it -v /path/to/repo:/repo sentrux check /repo
```

Example for a `my-project` repository:

```bash
cd my-project
docker run --rm -it -v "$(pwd)":/repo sentrux check /repo
```

### Scan

To run `sentrux scan` against a local repository on your machine, mount the repo into the container and pass the target path:

> Note: `sentrux scan` opens the GUI. In a container, you must forward your host display to the container.

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

- The image downloads the official Sentrux release binary.
- The runtime stage installs the GTK libraries required by the official binary so GUI/CLI usage work correctly.
- Use `sentrux --help` for additional command options.
