# Build

```bash
docker build . -t microblink/base:latest -t microblink/base:<VERSION>
```

# Deploy

```bash
docker push microblink/base:latest
docker push microblink/base:<VERSION>
```

# Run LicenceRequestTool

```bash
docker run -it --rm  microblink/base LicenseRequestTool
```
