# Build

```bash
docker build . -t microblink/base:latest -t microblink/base:<VERSION>
```

# Deploy

```bash
docker push microblink/base:latest
docker push microblink/base:<VERSION>
```

# Build and Deploy

This script will build and deploy image to Docker Hub

```bash
./docker-release.sh
```
