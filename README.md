# Java Web Application Finch Setup

A containerized Java web application environment using Finch (Docker alternative) with Tomcat 9.

## Features

- **Java 8** (OpenJDK) runtime
- **Tomcat 9.0** application server
- **Finch/Docker** containerization
- **Health checks** and monitoring
- **JMX** support for debugging
- **Volume mounting** for logs and easy development

## Directory Structure
- `webapps/` - **This directory should contain your WAR files**
  - `ROOT.war` - Main application (accessible at `/`)
  - `LIVE.war` - Live application (accessible at `/LIVE`)
  - `images.war` - Images service (accessible at `/images`)
  - `smvs.war` - SMVS application (accessible at `/smvs`)
- `logs/` - Tomcat logs (mounted from container)

**Important:** Place your WAR files in the `webapps/` directory before building the container. The Dockerfile copies all `*.war` files from `webapps/` to Tomcat's webapps directory.

## Setup

1. **Prepare your WAR files**: Place all your `.war` files in the `webapps/` directory
2. **Ensure proper naming**: 
   - `ROOT.war` for the main application (maps to `/`)
   - Other war files will be accessible at `/{filename}` (e.g., `LIVE.war` → `/LIVE`)

## Quick Start

### Using Finch Compose (Recommended)
```bash
# Build and start the container
finch compose up --build

# Run in background
finch compose up -d --build

# Stop the container
finch compose down
```

### Using Finch directly
```bash
# Build the image
finch build -t java-webapp .

# Run the container
finch run -p 8080:8080 java-webapp
```

## Access Your Applications
- Main app: http://localhost:8080/
- LIVE app: http://localhost:8080/LIVE
- Images: http://localhost:8080/images
- SMVS: http://localhost:8080/smvs

## Configuration
- Tomcat runs on port 8080 inside the container
- Java heap size: 256MB min, 512MB max (configurable in docker-compose.yml)
- Logs are mounted to `./logs` directory for easy access

## Troubleshooting
- **WAR files not found**: Ensure your `.war` files are in the `webapps/` directory before building
- **Application not accessible**: Check that your WAR file is properly named and deployed
- Check logs: `finch compose logs tomcat-app`
- Access container: `finch compose exec tomcat-app bash`
- View Tomcat logs: `finch compose exec tomcat-app tail -f /usr/local/tomcat/logs/catalina.out`
- List deployed applications: `finch compose exec tomcat-app ls -la /usr/local/tomcat/webapps/`

## Prerequisites

- [Finch](https://github.com/runfinch/finch) installed on your system
- Java WAR files ready for deployment

## License

This project is open source and available under the [MIT License](LICENSE).

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request